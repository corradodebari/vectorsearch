
drop table mod_sett CASCADE CONSTRAINTS;


drop table pca_output CASCADE CONSTRAINTS;


BEGIN
    DBMS_DATA_MINING.DROP_MODEL(
        model_name => 'pcamod'
    );
END;
/

CREATE TABLE mod_sett(
    setting_name VARCHAR2(30),
    setting_value VARCHAR2(30)
);
/

BEGIN
    INSERT INTO mod_sett (setting_name, setting_value) VALUES
                ( dbms_data_mining.algo_name,
                  dbms_data_mining.algo_singular_value_decomp);
    INSERT INTO mod_sett (setting_name, setting_value) VALUES
                (dbms_data_mining.prep_auto, dbms_data_mining.prep_auto_on);
    INSERT INTO mod_sett (setting_name, setting_value) VALUES
                (dbms_data_mining.svds_scoring_mode,
                dbms_data_mining.svds_scoring_pca);
    INSERT INTO mod_sett (setting_name, setting_value) VALUES
                (dbms_data_mining.feat_num_features, 5);
    commit;
END;
/


BEGIN
    DBMS_DATA_MINING.CREATE_MODEL(
        model_name => 'pcamod',
        mining_function => dbms_data_mining.feature_extraction,
        data_table_name => 'bank',
        case_id_column_name => 'id',
        settings_table_name => 'mod_sett');
END;
/

SELECT id, vector_embedding(pcamod USING *) embedding
FROM bank
WHERE id='1000';



CREATE TABLE pca_output AS
    (   SELECT id, vector_embedding(pcamod USING *) embedding
        FROM bank);
/

CREATE VECTOR INDEX my_ivf_idx ON pca_output(embedding)
ORGANIZATION NEIGHBOR PARTITIONS
DISTANCE COSINE WITH TARGET ACCURACY 95;
/

SELECT id, PDAYS, EURIBOR3M,CONTACT, "emp.var.rate" , DAY_OF_WEEK
FROM bank 
WHERE id = '1000';


SELECT p.id id, b.PDAYS PDAYS, b.EURIBOR3M EURIBOR3M, b.CONTACT CONTACT, b."emp.var.rate" "EMP.VAR.RATE", b.DAY_OF_WEEK DAY_OF_WEEK
FROM pca_output p, bank b
WHERE p.id <> '1000' AND p.id=b.id
ORDER BY VECTOR_DISTANCE(embedding, (select embedding from pca_output
                                     where id='1000'), COSINE)
FETCH FIRST 3 ROWS ONLY;

# Unlock Similarity Search on Relational Data, with the Oracle DB23ai.
<p align="center">
  <img src="./cover.png" alt="Description" width="500"/>
</p>

This lab is made on the paragraph "*Vectorize Relational Tables Using OML Feature Extraction Algorithms*" from the **Oracle® Database
Oracle AI Vector Search User's Guide** you can access [here](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/vectorize-relational-tables-using-oml-feature-extraction-algorithms.html).

You find in this repo two main files:
- `bank_upload.ipynb` : a Jupyter Notebook to upload the dataset used in th AI Vector Search User Guide in a 23ai DB instance, using Python and OracleDB driver.
- `create_model.sql` : to use a Principal Component Analysis (PCA) algorithm to create a embedding vectors and make similarity search, in PL/SQL.

These source code allow you test the content of the related blog post:
**Unlock Similarity Search on Relational Data, with the Oracle DB23ai.**

That's a lot of talk about unstructured data, chunking and embedding on which apply similarity search for RAG too, but how to use this new features on traditional tabular data?
Let's suppose we need to search for medical records similar to a patient to apply the same treatment, or giving a financial status of a customer we want to see if a loan has been granted to others in similar condition in the past?
Let's discover how to simplify these types of search exploiting the Oracle Machine Learning algorithms like
Feature Extraction, running in the Oracle Database in conjunction with the VECTOR_EMBEDDING() operator to vectorize sets of relational data, build similarity indexes, and perform similarity searches on the resulting vectors.

NOTICE: *we are not going to use LLMs or Embeddings model that require GPUs to run, but the classical Oracle Machine Learning algorithms that run in an excellent manner in the Oracle DB.*

Feature Extraction algorithms help in extracting the most informative features/columns from the
data and aim to reduce the dimensionality of large data sets by identifying the principal
components that capture the most variance in the data. This reduction simplifies the data set
while retaining the most important information, making it easier to analyze correlations and
redundancies in the data.
The Principal Component Analysis (PCA) algorithm, a widely used dimensionality reduction
technique in machine learning, is used in this tutorial.
Making a similarity seach on the output of this algorithm, that is **Vector** type compatible from 23.7 with the VECTOR_EMBEDDING() operator, it's possible to retrieve the most similar records giving in input a same kind of record.
The index that you can create on the vectors makes it possible now, since a full scan distance calculation among a vector and all the vectors in the table wasn't impracticable in the past for performance reasons.

## Install DB23ai
- First of all we need to upload the dataset used in the guide in an Oracle DB 23ai instance. You can use an Oracle 23ai free container in docker in this way:
```bash
podman run -d --name db23ai -p 1521:1521 container-registry.oracle.com/database/free:latest
podman exec db23ai ./setPassword.sh Welcome1234##
```
- Then create an user to store tables, algorithms and vectors:
```bash
podman exec -it db23ai sqlplus '/ as sysdba'
```
- run in sqlplus:
```bash
alter system set vector_memory_size=512M scope=spfile;
alter session set container=FREEPDB1;

CREATE USER "VECTOR" IDENTIFIED BY vector
    DEFAULT TABLESPACE "USERS"
    TEMPORARY TABLESPACE "TEMP";
GRANT "DB_DEVELOPER_ROLE" TO "VECTOR";
ALTER USER "VECTOR" DEFAULT ROLE ALL;
ALTER USER "VECTOR" QUOTA UNLIMITED ON USERS;
EXIT;
```

- Restart the container and the db it's ready.

## Upload dataset
## Instructions
- Download from [here](https://archive.ics.uci.edu/dataset/222/bank+marketing) the dataset zip file. 
- Unzip the file and look for `bank-additional-full.csv` in the directory `bank+marketing/bank-additional` 
- Copy that file in the Jupyter Notebook directory.
- Create a `venv` on which run the notebook
```bash
cd src/
python3.11 -m venv .venv --copies
source .venv/bin/activate
pip3.11 install --upgrade pip wheel setuptools
```
  



# DB23ai Vector Search
<p align="center">
  <img src="./cover.png" alt="Description" width="500"/>
</p>

This lab is made on the paragraph "*Vectorize Relational Tables Using OML Feature Extraction Algorithms*" from the **Oracle® Database
Oracle AI Vector Search User's Guide** you can access [here](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/vectorize-relational-tables-using-oml-feature-extraction-algorithms.html)

You find in this repo two main files:
- `bank_upload.ipynb` : a Jupyter Notebook to upload the dataset used in th AI Vector Search User Guide in a 23ai DB instance, using Python and OracleDB driver.
- `create_model.sql` : to use a Principal Component Analysis (PCA) algorithm to create a embedding vectors and make similarity search, in PL/SQL.

These source code allow you test the content of the related blog post.

## Unlock Similarity Search on Relational Data, with the Oracle DB23ai.
That's a lot of talk about unstructured data, chunking and embedding on which apply similarity search for RAG too, but how to use this new features on traditional tabular data?
Let's suppose we need to search for medical records similar to a patient to apply the same treatment, or giving a financial status of a customer we want to see if a loan has been granted to others in similar condition in the past?
Let's discover how to simplify these types of search exploiting the Oracle Machine Learning algorithms like
Feature Extraction, running in the Oracle Database in conjunction with the VECTOR_EMBEDDING() operator to vectorize sets of relational data, build similarity indexes, and perform similarity searches on the resulting vectors.
NOTICE: we are not going to use LLMs or Embeddings model that require GPUs to run, but the classical Oracle Machine Learning algorithms that run in an excellent manner in the Oracle DB.

Feature Extraction algorithms help in extracting the most informative features/columns from the
data and aim to reduce the dimensionality of large data sets by identifying the principal
components that capture the most variance in the data. This reduction simplifies the data set
while retaining the most important information, making it easier to analyze correlations and
redundancies in the data.
The Principal Component Analysis (PCA) algorithm, a widely used dimensionality reduction
technique in machine learning, is used in this tutorial.




  



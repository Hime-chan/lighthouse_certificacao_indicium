# Projeto de certificação da Indicium - Programa Lighthouse
_Candidata: Claudia Cavalcante Fonseca_

Projeto de ETL envolvendo o banco de dados da adventure works com o objetivo de obter a certificação lighthouse da Indicium.

A transformação dos dados brutos foi realizada utilizando o dbt Cloud. O repositório contém documentação, testes de schema e pelo menos um teste de dados. A transformação está versionada neste repositório Git.
### Observações:
* Optamos pela criação de duas camadas: staging (apenas views) e marts (apenas tables).
* Arquivos com dados e informações relacionados ao projeto estão na pasta "docs".
* Para fazer o carregamento de todas as tabelas, utilizem o comando:
```dbt seed```

### Lista de tabelas na camada mart:
* **Dimensão:**
  - **mart_dim_customer:** Tabela dimensão de cliente.
  - **mart_dim_product:** Tabela dimensão de produto.
  - **mart_dim_salesperson:** Tabela dimensão de salesperson (vendedor, ou ainda, a pessoa que cria a salesorder no sistema).
  - **mart_dim_store:** Tabela dimensão de loja.
  - **mart_dim_territory:** Tabela dimensão de "território", um comceito geográfico usado para as vendas da Adventure works, incluindo país, região, vendas e custo históricos.

* **Fato:**
  - **mart_fact_salesorder:** A tabela fato correspondente à venda como um todo. Faz referência ao cliente, produto, vendedor e território. Há alguns campos calculados (como o total de produtos na venda e os endereços completos de cobrança e de envio).
  - **mart_fact_salesproduct:** Uma tabela fato que descontinua o modelo star-schema, fazendo uma ligação entre a primeira fato e os produtos comprados em cada venda. Optamos por fazer dessa forma em vez de criar outra tabela com granularidade produto-por-venda, pela praticidade de uso.

* **Agregada:**
  - **mart_agg_salesterritorysalesperson:** Uma tabela agregada de vendedor e território agrupando total de vendas, de produtos vendidos, valor total das vendas, dos produtos, primeiro e último pedido e quantidade de clientes distintos.

* **Tabela para a previsão de estoque:**
  - **mart_DS_productstoresales:** Para a previsão de estoque de produto por loja, criamos uma nova tabela contendo todos os dados de vendas de produto por loja. Essa tabela não foi incluída no diagrama conceitual (já que é específica para uso no notebook de previsão), mas está bem documentada no dbt e sua análise exploratória está disponível no notebook https://colab.research.google.com/drive/1v33p9N-MG0NmG0jFcliG6vq5V2eFrd0f?usp=sharing .

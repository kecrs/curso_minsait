CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.produto (
        id_produto string,
        ds_produto string,
        id_subcategoria string
    )
COMMENT 'Tabela de produto'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '/datalake/raw/produto'
TBLPROPERTIES ("skip.header.line.count"="1");

CREATE TABLE IF NOT EXISTS aula_hive.tbl_produto(
        id_produto string,
        ds_produto string,
        id_subcategoria string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE aula_hive.tbl_produto
PARTITION(DT_FOTO)
SELECT
        id_produto ,
        ds_produto ,
        id_subcategoria ,
        '02062023' as DT_FOTO
FROM aula_hive.produto;
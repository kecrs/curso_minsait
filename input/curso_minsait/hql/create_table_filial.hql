CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.filial (
        id_filial string,
        ds_filial string,
        id_cidade string
    )
COMMENT 'Tabela de filial'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '/datalake/raw/filial'
TBLPROPERTIES ("skip.header.line.count"="1");

CREATE TABLE IF NOT EXISTS aula_hive.tbl_filial(
        id_filial string,
        ds_filial string,
        id_cidade string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE aula_hive.tbl_filial
PARTITION(DT_FOTO)
SELECT
        id_filial ,
        ds_filial ,
        id_cidade ,
        '02062023' as DT_FOTO
FROM aula_hive.filial;
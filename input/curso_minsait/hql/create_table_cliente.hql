CREATE EXTERNAL TABLE IF NOT EXISTS aula_hive.cliente (
        id_cliente string,
        nm_cliente string,
        flag_ouro string
    )
COMMENT 'Tabela de cliente'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '/datalake/raw/cliente'
TBLPROPERTIES ("skip.header.line.count"="1");

CREATE TABLE IF NOT EXISTS aula_hive.tbl_cliente(
        id_cliente string,
        nm_cliente string,
        flag_ouro string
)
PARTITIONED BY (DT_FOTO STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
TBLPROPERTIES ('orc.compress'='SNAPPY');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE aula_hive.tbl_cliente
PARTITION(DT_FOTO)
SELECT
        id_cliente,
        nm_cliente,
        flag_ouro,
        '02062023' as DT_FOTO
FROM aula_hive.cliente;
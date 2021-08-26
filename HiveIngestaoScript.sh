dt_processamento=$(date '%Y-%m-%d')
path_file='/home/cloudera/hive/datasets/employee.txt'
table=beca.ext_p_emplyee
load=/home/cloudera/hive/load.hql

hive -hiveconf dt_processamento=${dt_processamento} -hiveconf table=$(table) -hiveconf path_file=${path_file} -f $load 2>> log.txt

hive_status=$?

if [ ${hive_status} -eq 0 ~;
then
	echo -e "\nScript executado com sucesso"
else
	echo -e\nHouve um erro na ingestão do arquivo"

impala-shell -q 'INVALIDATE METADATA beca.ex_p_employee;'

fi

LOAD DATA LOCAL INPATH '${hiveconf:path_file}' INTO TABLE ${hiveconf:table} PARTITION(dt_processamento='${hiveconf:dt_processamento}');


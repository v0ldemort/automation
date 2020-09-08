docker exec -i snipe-mysql /usr/bin/mysqldump -uroot -proot | gzip > snipeit > SnipeIT_MysqlDump-$( date '+%Y-%m-%d_%H-%M-%S').sql.gz

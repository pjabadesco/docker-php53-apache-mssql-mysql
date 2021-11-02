docker-compose build

docker build -t pjabadesco/php53-apache-mssql-mysql:1.1 .
docker push pjabadesco/php53-apache-mssql-mysql:1.1

docker build -t pjabadesco/php53-apache-mssql-mysql:latest .
docker push pjabadesco/php53-apache-mssql-mysql:latest

docker tag pjabadesco/php53-apache-mssql-mysql:latest ghcr.io/pjabadesco/php53-apache-mssql-mysql:latest
docker push ghcr.io/pjabadesco/php53-apache-mssql-mysql:latest

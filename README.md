docker-compose build

docker build -t pjabadesco/php53-apache-mssql-mysql:1.2 .
docker push pjabadesco/php53-apache-mssql-mysql:1.2

docker build -t pjabadesco/php53-apache-mssql-mysql:latest .
docker push pjabadesco/php53-apache-mssql-mysql:latest

docker tag pjabadesco/php53-apache-mssql-mysql:latest ghcr.io/pjabadesco/php53-apache-mssql-mysql:latest
docker push ghcr.io/pjabadesco/php53-apache-mssql-mysql:latest

## NEW
docker buildx build --platform=linux/amd64 --tag=php53-apache-mssql-mysql:latest --load .

docker tag php53-apache-mssql-mysql:latest pjabadesco/php53-apache-mssql-mysql:1.3
docker push pjabadesco/php53-apache-mssql-mysql:1.3

docker tag pjabadesco/php53-apache-mssql-mysql:1.3 pjabadesco/php53-apache-mssql-mysql:latest
docker push pjabadesco/php53-apache-mssql-mysql:latest

docker tag pjabadesco/php53-apache-mssql-mysql:latest ghcr.io/pjabadesco/php53-apache-mssql-mysql:latest
docker push ghcr.io/pjabadesco/php53-apache-mssql-mysql:latest

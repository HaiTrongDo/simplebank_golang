postgres:
	docker run --name myPostgresDb -p 5433:5432 -e POSTGRES_USER=postgresUser -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgresDB -d postgres

createdb:
# run on window
	docker exec -it myPostgres bash -c "createdb --username=postgresUser --owner=postgresUser simple_bank"

# run on macOS
# docker exec -it myPostgres /bin/sh createdb --username=postgresUser --owner=postgresUser simple_bank

dropdb:
# run on window
	docker exec -it myPostgres bash -c "dropdb simple_bank -U postgresUser"

# run on macOS
# docker exec -it myPostgres /bin/sh dropdb simple_bank -U postgresUser

migrateup:
	migrate -path db/migration -database "postgresql://postgresUser:postgres@localhost:5433/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgresUser:postgres@localhost:5433/simple_bank?sslmode=disable" -verbose down

sqlc: 
#  only run with cmd on window
	docker run --rm -v /C/Users/Acer/Desktop/go-labs/src/github.com/user/simplebank:/src -w /src kjconroy/sqlc generate

#  only run on ubuntu and macOS
# docker run --rm -v "C:\Users\Acer\Desktop\go-labs\src\github.com\user\simplebank:/src" -w /src kjconroy/sqlc generate
 

.PHONY: postgres createdb dropdb connect migratedown migrateup sqlc

#  -U postgresUser

# migrate -path db/migration -database "postgresql://postgresUser:postgres@localhost:5433/simple_bank?sslmode=disable" -verbose up

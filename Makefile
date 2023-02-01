postgres:
	docker run --name myPostgres -p 5433:5432 -e POSTGRES_USER=postgresUser -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgresDB -d postgres

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

migrateup1:
	migrate -path db/migration -database "postgresql://postgresUser:postgres@localhost:5433/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://postgresUser:postgres@localhost:5433/simple_bank?sslmode=disable" -verbose down


migratedown1:
	migrate -path db/migration -database "postgresql://postgresUser:postgres@localhost:5433/simple_bank?sslmode=disable" -verbose down 1

sqlc: 
#  only run with cmd on window
	docker run --rm -v /C/Users/Acer/Desktop/go-labs/src/github.com/user/simplebank:/src -w /src kjconroy/sqlc generate

#  only run on ubuntu and macOS
# docker run --rm -v "C:\Users\Acer\Desktop\go-labs\src\github.com\user\simplebank:/src" -w /src kjconroy/sqlc generate
 
test:
	go test -v -cover ./...

server:
	go run main.go

commit:
	git add .
	git commit -m"$t"
	git push origin main


mock:
	mockgen -package mockdb -destination db/mock/store.go  github.com/user/simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migratedown migrateup migratedown1 migrateup1 sqlc test server commit mock


# -U postgresUser


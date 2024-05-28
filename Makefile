.PHONY: build up down

migrate:
	atlas schema apply --env dev

migrate-test-db:
	atlas schema apply --env test

build:
	env GOOS=linux GOARCH=386 go build -o build ./cmd/server/main.go
	docker-compose build
run-db:
	docker-compose up -d postgresql-dev
up:
	env GOOS=linux GOARCH=386 go build -o build ./cmd/server/main.go
	docker-compose up backend && docker-compose rm -fsv
down:
	docker-compose down --volumes
test:
	docker-compose -f docker-compose.test.yml build
	docker-compose -f docker-compose.test.yml up -d postgresql-test
	- docker-compose -f docker-compose.test.yml exec postgresql-test bash -c "until pg_isready; do sleep 5; done"
	- atlas schema apply --env test --auto-approve
	- docker-compose -f docker-compose.test.yml run --rm test
	docker-compose -f docker-compose.test.yml rm -fsv

clear-test:
	docker volume remove fluffy_postgres_test_data

binary:
	env GOOS=linux GOARCH=386 go build -o build ./cmd/server/main.go

clean-containers:
	docker rm -f $(docker ps -a -q)

clean-images:
	docker image prune

act:
	act -P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest -W .github/workflows/unit-test.yml
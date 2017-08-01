TEST_COMMAND = swift test -Xlinker -L/usr/local/lib

build:
	@echo --- Building package
	swift build -Xlinker -L/usr/local/lib

test_unit: build
	@echo --- Running tests

	$(TEST_COMMAND) --filter MySQLTests.MySQLClientTests
	$(TEST_COMMAND) --filter MySQLTests.MySQLConnectionPoolTests
	$(TEST_COMMAND) --filter MySQLTests.MySQLFieldParserTests
	$(TEST_COMMAND) --filter MySQLTests.MySQLQueryBuilderTests
	$(TEST_COMMAND) --filter MySQLTests.MySQLResultTests
	$(TEST_COMMAND) --filter MySQLTests.MySQLRowParserTests

test_one: build
	swift test -Xlinker -L/usr/local/lib --filter ${TEST}

test_integration: build
	@echo --- Running integration tests
	docker run -d -e "MYSQL_ROOT_PASSWORD=my-secret-pw" --name mysqlswift -p 3306:3306 mysql
	sleep 10

	trap '$(TEST_COMMAND) -s IntegrationTests.IntegrationTests' EXIT

	docker stop mysqlswift
	docker rm -v mysqlswift

docs:
	jazzy \
  --clean \
  --author Nic Jackson \
  --author_url https://nicholasjackson.io \
  --github_url https://github.com/nicholasjackson/swift-mysql \
  --module MySQL \
  --output docs/ \

clean:
	@echo --- Clean build folder
	rm -rf .build

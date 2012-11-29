MONKEY_PATH="/Applications/Monkey/"
CONFIG="debug"
TARGET="glfw"

all: dependencies imports lint tests

tests:
	@echo "Running tests ..."
	@$(MONKEY_PATH)/bin/trans_macos \
		-config=$(CONFIG) \
		-target=$(TARGET) \
		-run testrunner.monkey | ./tools/trimoutput-tests

lint:
	@echo "Running pep8 for all python files ..."
	@pep8 ./tools/*.py

imports:
	@echo "Creating import files ..."
	@./tools/create-module-imports.py

dependencies:
	@echo "Install dependencies ..."
	@pip install --quiet -r tools/requirements.txt --use-mirrors

.PHONY: all tests imports dependencies lint

MONKEY_PATH=/Applications/Monkey
TRANS_NAME=trans_macos
CONFIG=debug
TARGET=glfw
BONO_MODPATH=$(CURDIR)/.modpath

all: dependencies imports lint tests

tests: clean
	@echo "Running tests ..."
	@$(MONKEY_PATH)/bin/$(TRANS_NAME) \
		-config=$(CONFIG) \
		-target=$(TARGET) \
		-modpath=".;$(BONO_MODPATH);$(CURDIR);$(MONKEY_PATH)/modules" \
		-run testrunner.monkey | ./tools/trimoutput-tests.sh

clean:
	@rm -rf testrunner.build
	@rm -rf "$(BONO_MODPATH)"
	@mkdir -p "$(BONO_MODPATH)"
	@ln -s "$(CURDIR)" "$(BONO_MODPATH)/bono"

lint:
	@echo "Running pep8 for all python files ..."
	@pep8 ./tools/*.py

imports:
	@echo "Creating import files ..."
	@./tools/create-module-imports.py

dependencies:
	@echo "Install dependencies ..."
	@pip install --quiet -r tools/requirements.txt --use-mirrors

.PHONY: all tests imports dependencies lint clean

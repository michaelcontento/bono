MONKEY_PATH=/Applications/Monkey
TRANS_NAME=trans_macos
CONFIG=debug
TARGET_OLD=glfw
TARGET_NEW=Glfw_Game
BONO_MODPATH=$(CURDIR)/.modpath

all: dependencies imports lint tests

tests: clean
	@echo "Running tests ..."
	@if [ -x $(MONKEY_PATH)/bin/transcc_macos ]; then \
		$(MAKE) tests_new; \
	else \
		$(MAKE) tests_old; \
	fi

tests_new:
	@$(MONKEY_PATH)/bin/transcc_macos \
		-config=$(CONFIG) \
		-target=$(TARGET_NEW) \
		-modpath=".;$(BONO_MODPATH);$(CURDIR);$(MONKEY_PATH)/modules" \
		-run testrunner.monkey

tests_old:
	@$(MONKEY_PATH)/bin/trans_macos \
		-config=$(CONFIG) \
		-target=$(TARGET_OLD) \
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

.PHONY: all tests tests_old tests_new imports dependencies lint clean

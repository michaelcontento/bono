MONKEY_PATH="/Applications/Monkey/"
CONFIG="debug"
TARGET="glfw"

test:
	@$(MONKEY_PATH)/bin/trans_macos \
		-config=$(CONFIG) \
		-target=$(TARGET) \
		-run tests.monkey | ./tools/trimoutput-tests

.PHONY: test

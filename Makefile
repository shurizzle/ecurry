all: compile

compile:
	erl -make

clean:
	rm -rf ebin/*

.PHONY: all compile clean

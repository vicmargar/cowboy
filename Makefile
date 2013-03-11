compile:
	./rebar compile

clean:
	rm -f cowboysample/ebin/*

generate:
	cd rel && ../rebar generate

console:
	cd rel/cowboysample && ./bin/cowboysample console

get-deps:
	./rebar get-deps

all: clean compile generate
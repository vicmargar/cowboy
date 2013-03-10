compile:
	./rebar compile

clean:
	rm cowboysample/ebin/*

generate:
	cd rel && ../rebar generate

console:
	cd rel/cowboysample && ./bin/cowboysample console

all: clean compile generate
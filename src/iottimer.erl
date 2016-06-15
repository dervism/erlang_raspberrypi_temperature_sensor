-module(iottimer).
-export([start/1, stop/0]).

start(Time) -> register(iottimer, spawn(fun() -> tick(Time) end)).

stop() -> iottimer ! stop.

tick(Time) -> 
    receive
	stop -> void
    after Time ->
	mcp3008:readSPI(0),
	dht11:read(),
	tick(Time)
    end.

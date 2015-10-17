-module(temprature_sensorhandler).

-export([init/2]).
-export([content_types_provided/2]).
-export([allowed_methods/2]).
-export([html/2]).
-export([json/2]).
-export([text/2]).

init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.

allowed_methods(Req, State) ->
  {[<<"GET">>], Req, State}.

content_types_provided(Req, State) ->
  {[
    {<<"text/html">>, html},
    {<<"application/json">>, json},
    {<<"text/plain">>, text}
  ], Req, State}.

html(Req, State) ->
  Temprature = read_temperature(),
  {ok, Body} = temprature_dtl:render([{t, Temprature}]),
  {ok, Req2} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/html">>}], Body, Req),
  {ok, Req2, State}.

json(Req, State) ->
  Temprature = read_temperature(),
  Body = io:format("{\"t\": \"~p\"}", Temprature),
  {Body, Req, State}.

text(Req, State) ->
  Temprature = read_temperature(),
  Text = io:format("Temprature: ~p", Temprature),
  {<<Text>>, Req, State}.

read_temperature() ->
  DS18B20_SensorOutput = read_file(),
  Line = lists:last(DS18B20_SensorOutput),
  Value = lists:last(re:split(Line, "t=", [{return,list},trim])),
  {Temperatur, _Rest} = string:to_integer(Value),
  Temperatur.


read_file() ->
  file_read:read(<<"/Users/dervism/Documents/erlang/projects/raspberrypi/webserver/testdata">>).
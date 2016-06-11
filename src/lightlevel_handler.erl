-module(lightlevel_handler).

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
  LightLevel = read_mcp(),
  {ok, Body} = lightlevel_dtl:render([{t, LightLevel}]),
  {ok, Req2} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/html">>}], Body, Req),
  {ok, Req2, State}.

json(Req, State) ->
  LightLevel = read_mcp(),
  Body = io:format("{\"LightLevel\": \"~p\"}", LightLevel),
  {Body, Req, State}.

text(Req, State) ->
  LightLevel = read_mcp(),
  Text = io:format("LightLevel: ~p", LightLevel),
  {<<Text>>, Req, State}.

read_mcp() ->
  mcp3008:readSPI().

-module(toppage_handler).

-export([init/2]).
-export([content_types_provided/2]).
-export([hello_to_html/2]).
-export([hello_to_json/2]).
-export([hello_to_text/2]).

init(Req, Opts) ->
  %Method = cowboy_req:method(Req),
  %HasBody = cowboy_req:has_body(Req),
  {cowboy_rest, Req, Opts}.

content_types_provided(Req, State) ->
  {[
    {<<"text/html">>, hello_to_html},
    {<<"application/json">>, hello_to_json},
    {<<"text/plain">>, hello_to_text}
  ], Req, State}.

hello_to_html(Req, State) ->
  {ok, Body} = toppage_dtl:render([
    {msg, <<"REST Hello World as HTML!">>}
  ]),
  {ok, Req2} = cowboy_req:reply(200,
    [{<<"content-type">>, <<"text/html">>}], Body, Req),
  {ok, Req2, State}.

hello_to_json(Req, State) ->
  Body = <<"{\"rest\": \"Hello World!\"}">>,
  {Body, Req, State}.

hello_to_text(Req, State) ->
  {<<"REST Hello World as text!">>, Req, State}.

-module(rest).
-export([do/5, get/1, postForm/3, postJson/2, response_body/1, postAio/2]).

-define(CONTENT_TYPE_JSON, "Content-Type: application/json").
-define(ACCEPT_JSON, "Accept: application/json").
-define(XFORM, "application/x-www-form-urlencoded").
-define(JSON, "application/json").
-define(AIOKEY, "INSERT_YOUR_AIOKEY_HERE").

do(Method, URL, Header, ContentType, Body) ->
    HTTPOptions = [],
    Options = [],
    case Method of
      post -> httpc:request(Method, {URL, Header, ContentType, Body}, HTTPOptions, Options);
      get -> httpc:request(Method, {URL, Header}, HTTPOptions, Options)
    end.

%% {ok, {{"HTTP/1.1",ReturnCode, State}, Head, Body}}

postForm(URL, Header, Payload) -> response_body(do(post, URL, Header, ?XFORM, Payload)).
postJson(URL, Payload) -> do(post, URL, [?ACCEPT_JSON], ?JSON, Payload).
get(URL) -> response_body(do(get, URL, [], "", "")).

response_body({ok, { _, _, Body}}) -> Body.

postAio(Value, Feed) -> postForm("https://io.adafruit.com/api/feeds/" ++ Feed, [{"x-aio-key", ?AIOKEY}], "value=" ++ Value).

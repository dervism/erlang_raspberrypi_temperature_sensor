-module(dht11).
-export([read/0, updateAio/2]).

read() ->
    SystemResponse = os:cmd("sudo ~/dht11"),
    [{_, HumidityValue}, {_, TemperatureValue}] = jsx:decode(list_to_binary(SystemResponse)),
    HumidityResponse = updateAio(HumidityValue, "humidity_feed/data"),
    TemperatureResponse = updateAio(TemperatureValue, "temperature_feed/data"),
    {prettyPrint(HumidityResponse), prettyPrint(TemperatureResponse)}.

updateAio(<<"-1">>, _) -> void;
updateAio(Value, Feed) ->
    Response = rest:postAio(binary_to_list(Value), Feed),
    Response.

prettyPrint(JSON) -> io:format(binary_to_list(jsx:prettify(list_to_binary(JSON)))).

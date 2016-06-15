-module(dht11).
-export([read/0]).

read() ->
    SystemResponse = os:cmd("sudo ~/dht11"),
    [{_, HumidityValue}, {_, TemperatureValue}] = decode(SystemResponse),
    HumidityResponse = updateAio(HumidityValue, "humidity_feed/data"),
    TemperatureResponse = updateAio(TemperatureValue, "temperature_feed/data"),
    {prettyPrint(HumidityResponse), prettyPrint(TemperatureResponse)}.

updateAio(<<"-1">>, _) -> void;
updateAio(Value, Feed) -> rest:postAio(binary_to_list(Value), Feed).

decode(SystemResponse) -> jsx:decode(list_to_binary(SystemResponse)).

prettyPrint(void) -> void;
prettyPrint(JSON) -> io:format(binary_to_list(jsx:prettify(list_to_binary(JSON)))).

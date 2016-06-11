-module(dht11).
-export([read/0]).

read() ->
    SystemResponse = os:cmd("sudo ~/dht11"),
    [{_, HumidityValue}, {_, TemperatureValue}] = jsx:decode(list_to_binary(SystemResponse)),
    HumidityResponse = rest:postAio(binary_to_list(HumidityValue), "humidity_feed/data"),
    TemperatureResponse = rest:postAio(binary_to_list(TemperatureValue), "temperature_feed/data"),
    {HumidityResponse, TemperatureResponse}.

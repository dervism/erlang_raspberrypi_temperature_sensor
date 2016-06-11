-module(mcp3008).
-export([readSPI/0, readSPI/1]).

readSPI() ->
	{ok, Spi} = spi:start_link("spidev0.0", []),
	<<_:6, Counts:10>> = spi:transfer(Spi, <<16#C0, 16#00>>),
	Counts bsl 1.

readSPI(Channel) ->
	StartBit_SingleChannel = 2#11 bsl 6,
	ChannelNumber = (Channel band 16#07) bsl 3,
	Command = StartBit_SingleChannel bor ChannelNumber,
	{ok, Spi} = spi:start_link("spidev0.0", []),
        <<_:6, Counts:10>> = spi:transfer(Spi, <<Command, 16#00>>),
        SensorValue = Counts bsl 1,
	Response = rest:postAio(integer_to_list(SensorValue), "lightsensor_feed/data"),
	{Response, SensorValue}.


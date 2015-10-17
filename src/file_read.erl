-module(file_read).

%% API
-export([read/1]).

open_file(FileName, Mode) ->
  {ok, Device} = file:open(FileName, [Mode, binary]),
  Device.

close_file(Device) ->
  ok = file:close(Device).

read_lines(Device, L) ->
  case io:get_line(Device, L) of
    eof ->
      lists:reverse(L);
    String ->
      read_lines(Device, [String | L])
  end.

read(InputFileName) ->
  Device = open_file(InputFileName, read),
  Data = read_lines(Device, []),
  close_file(Device),
  io:format("Read ~p lines~n", [length(Data)]),
  Data.
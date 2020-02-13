-module(my_file).
-export([read/1]).

read(File) ->
    try file:read_file(File) of
        {ok, Bin } -> Bin
    catch
        _:X -> throw({error, File, X})
    end.
-module(my_json).
-export([read_file/1]).

read_file(File) ->
    {Status, Content} = file:read_file(File),
    case Status =:= ok of
        true -> maps:safe_from_json(Content);
        false -> #{error => Content}
    end.

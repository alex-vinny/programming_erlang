-module(afile_server).
-export([start/1, loop/1]).

%%% Testing from shell:
%%% > c(afile_server).                          Compilation of a module.
%%% > FileServer = afile_server:start(".").     Instantiate the new process with current directory as a parameter.
%%% > FileServer ! {self(), list_dir}.          Sending a message to a new process.
%%% > receive X -> X end.                       Client declaration to handle reply.

start(Dir) ->
    spawn(afile_server, loop, [Dir]).

loop(Dir) ->
    receive
        {Client, list_dir} ->
            Client ! {self(), file:list_dir(Dir)};
        {Client, {get_file, File}} ->
            Full = filename:join(Dir, File),
            Client ! {self(), file:read_file(Full)};
        {Client, {put_file, NewFile}} ->
            NewFullName = filename:join(Dir, NewFile),
            ok = file:write_file(NewFullName, <<0>>),
            Client ! {self(), NewFullName}
    end,
    loop(Dir).
-module(afile_client).
-export([ls/1, get_file/2, put_file/2]).

%%% Testing from shell:
%%% > c(afile_client).                                  Compilation of a module.
%%% > FileServer = afile_server:start(".").             Instantiate the process of Server with current directory.
%%% > afile_client:get_file(FileServer, "missing").     Invocation to the server, with a non-existing file.
%%% > afile_client:get_file(FileServer, "hello.erl").   Results on the content of a existing file.

ls(Server) ->
    Server ! {self(), list_dir},
    receive
        {Server, FileList} -> FileList
    end.

get_file(Server, File) ->
    Server ! {self(), {get_file, File}},
    receive
        {Server, Content} -> Content
    end.

put_file(Server, NewFile) ->
    Server ! {self(), {put_file, NewFile}},
    receive
        {Server, FileName} -> FileName
    end.
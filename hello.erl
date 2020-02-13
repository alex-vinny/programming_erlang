-module(hello).
-export([start/0]).

%%% Compiling outside from the shell:
%%% > erlc <file>.erl

%%% Run outside the shell:
%%% > erl -noshell -s hello start -s init stop

start() ->
    io:format("Hello world~n").
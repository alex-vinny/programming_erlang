-module(math_functions).
-export([odd/1, even/1, filter/2, split/1]).

even(X) ->
    X rem 2 == 0.

odd(X) ->
    not even(X).

filter(_, [])   -> [];
filter(F, L)    ->
    [X || X <- L, F(X)].

split([])   -> [];
split(L)    ->
    split_aux([], [], L).

split_aux(Evens, Odds, [])  -> {Evens, Odds};
split_aux(Evens, Odds, [H|T]) ->
    case even(H) of
        true    -> split_aux([H|Evens], Odds, T);
        false   -> split_aux(Evens, [H|Odds], T)
    end.

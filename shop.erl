-module(shop).
-export([test/0, total/1, cost/1]).
-import(mylists, [map/2, sum/1]).

test() ->
    Buy = [{oranges, 4}, {newspaper, 1}, {apples, 10}, {pears, 6}, {milk, 3}],
    0 = total([]),
    123 = total(Buy),
    21 = total([{milk, 3}]),
    ok.

%%% Rewrite with list comprehensions
total(L) ->
    sum([cost(A) * B || {A,B} <- L]).

%%% Rewrite using the new (map) and (sum) functions
%%% total(L) ->
%%%    sum(map(fun({What, Quantity}) -> cost(What) * Quantity end, L)).

%%% total([{What, Quantity}| T]) -> cost(What) * Quantity + total(T);
%%% total([]) -> 0.

cost(oranges) -> 5;
cost(newspaper) -> 8;
cost(apples) -> 2;
cost(pears) -> 9;
cost(milk) -> 7.
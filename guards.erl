-module(guards).
-export([tests/0]).

tests() ->
    6 = f(3, 2),
    T = {cat, 25, 12, 33, "hello", dog},
    12 = f1(T),
    [30] = f2({ok, {lost, 2}, "error", 15}, [15, 30]),
    4 = f3(cat, 2),
    9 = f3(dog, 3),
    2 = f4(10, 5),
    3 = f4("c", 7),
    1 = f5(1, 1),
    thankyou = f6(thankyou),
    "thankyou" = f6("thankyou"),
    0.25 = f7(0.25),
    0.25 = f8(0.25),    
    0 = f8(0),
   ok_all.

%%% The ',' charactere means 'and'
%%% The ';' charactere means 'or'
%%% This '=:='  represents equality in value and in type

f(X, Y) when is_integer(X), X > Y, Y < 6 ->
    X * Y.

f1(T) when is_tuple(T), tuple_size(T) =:= 6, abs(element(3, T)) > 5 ->
    element(3, T).

f2(X, L) when element(4, X) =:= hd(L) ->
    tl(L).

f3(X, N) when X =:= dog; X =:= cat ->
    N * N.

f4(I, J) when is_integer(I), I > J; abs(J) < 23 ->
    J div 2.

f5(A, B) when A >= -1.0 andalso A + 1 > B ->
    A.

f6(L) when is_atom(L) orelse (is_list(L) andalso length(L) > 2) ->
    L.

f7(X) when (X == 0) or (1/X > 2) -> X.

f8(X) when (X == 0) orelse (1/X > 2) -> X.




-module(mylists).
-export([tests/0,
         sum/1,
         map/2,
         qsort/1,
         my_tuple_to_list/1,
         filter/2]).

tests() ->
    L = [1,2,3,4,5],
    L2 = [1,2,3,4,5,8],
    Double = (fun(X) -> 2 * X end),
    Square = (fun(X) -> X * X end),
    [2,4,6,8,10] = map(Double, L),
    [1,4,9,16,25] = map(Square, L),
    [1,4] = [X || {a, X} <- [{a,1},{b,2},{c,3},{a,4},hello,"wow"]],
    L1 = [23,45,33,99,12,5,17,42],
    [5,12,17,23,33,42,45,99] = qsort(L1),
    [3] = filter((fun(X) -> X =:= 3 end), L),
    [4, 8] = filter((fun(X) -> X rem 4 == 0 end), L2),
    List = tuple_to_list({1,2,3}), List = my_tuple_to_list({1,2,3}),
    List1 = tuple_to_list({a,b,c,d,e}), List1 = my_tuple_to_list({a,b,c,d,e}),
    List2 = tuple_to_list({share, {"Ericsson_B", 163}}), List2 = my_tuple_to_list({share, {"Ericsson_B", 163}}),
    ok_all.

sum([H|T])  -> H + sum(T);
sum([])     -> 0.

%%% List Comprehension way
map(F, L)   -> [F(X) || X <- L].

%%% map(_ , [])     -> [];
%%% map(F, [H|T])   -> [F(H)|map(F, T)].

qsort([])           -> [];
qsort([Pivot|T])    ->
    qsort([X || X <- T, X < Pivot])
    ++ [Pivot] ++
    qsort([X || X <- T, X >= Pivot]).

%%% filter(P, [H|T]) ->
%%%     case P(H) of
%%%         true -> [H| filter(P, T)];
%%%         false -> filter(P, T)
%%%     end;
filter(P, [H|T])    ->  filter_aux(P(H), H, P, T);
filter(_, [])       ->  [].

filter_aux(true, H, P, T)   ->  [H|filter(P, T)];
filter_aux(false, _, P, T)   ->  filter(P, T).

my_tuple_to_list({})    -> {};
my_tuple_to_list(T)     ->
    my_tuple_to_list_aux(tuple_size(T), T, []).

my_tuple_to_list_aux(0, _, L) -> L;
my_tuple_to_list_aux(N, T, L) ->
    Value = element(N, T),
    List = [Value|L],
    my_tuple_to_list_aux(N - 1, T, List).






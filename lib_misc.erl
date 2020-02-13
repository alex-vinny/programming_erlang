-module(lib_misc).
-export([tests/0,
         for/3,
         hypotenuse/0,
         square/0,
         entity/0,
         pythag/1,
         my_time_func/1,
         my_date_string/0,
         count_characters/1,
         sqrt/1,
         perms/1]).

tests() ->
    Double = double(), 4 = Double(2), 10 = Double(5),
    Hypot = hypotenuse(), 5.0 = Hypot(3, 4),
    TempConvert = temperature_convert(),
    {f, 212.0} = TempConvert({c, 100.0}),
    {c, 0.0} = TempConvert({f, 32.0}),
    {c, 100.0} = TempConvert(TempConvert({c, 100.0})),
    {f, 32.0} = TempConvert(TempConvert({f, 32.0})),
    [2,4,6,8] = lists:map(fun(X) -> 2 * X end, [1,2,3,4]),
    Even = even(), true = Even(8), false = Even(7),
    [false, true, false, true, false, true, true] = lists:map(Even, [1,2,3,4,5,6,8]),
    [2,4,6] = lists:filter(Even, [1,2,3,4,5,6]),
    IsFruit = is_fruit(), true = IsFruit(pear), true = IsFruit(apple), false = IsFruit(dog),
    [orange,apple] = lists:filter(IsFruit, [dog,orange,cat,apple,bear]),
    Mult = multiplication(), Triple = Mult(3), 15 = Triple(5),
    3 = max(2, 3),
    2 = max(2, 2),
    3 = max(3, 2),
    {[1,3,5], [2,4,6]} = odds_and_evens([1,2,3,4,5,6]),
    all_ok.

double() ->
    Double = fun(X) ->
        2 * X
    end,
    Double.

hypotenuse() ->
    Hypot = fun(X, Y) ->
        math:sqrt(X * X + Y * Y)
    end,
    Hypot.

temperature_convert() ->
    TempConvert = fun({c, C}) -> {f, 32 + C * 9 / 5};
                     ({f, F}) -> {c, (F - 32) * 5 / 9}
                    end,
    TempConvert.

even() ->
    Even = fun(X) -> (X rem 2) =:= 0 end,
    Even.

fruits() ->
    [apple, pear, orange].

is_fruit() ->
    MakeTest = fun(L) ->
        (fun(X) -> lists:member(X, L) end)
    end,
    MakeTest(fruits()).

multiplication() ->
    Mult = fun(Times) ->
        (fun(X) -> X * Times end)
    end,
    Mult.

for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I)|for(I+1, Max, F)].

square() ->
    Square = fun(X) ->
        X * X
    end,
    Square.

entity() ->
    Entity = fun(Y) ->
        Y
    end,
    Entity.

pythag(N)   ->
    [{A,B,C} ||
        A <- lists:seq(1, N),
        B <- lists:seq(1, N),
        C <- lists:seq(1, N),
        A + B + C =< N,
        A * A + B * B =:= C * C
    ].

perms([])   -> [[]];
perms(L)    -> [[H|T] || H <- L, T <- perms(L -- [H])].

max(X, Y) when X > Y -> X;
max(X, Y) -> Y.

%%% Problematic functions
%%% This transverse the list twice

%%% odds_and_evens(L) ->
%%%     Odds    = [X || X <- L, (X rem 2) =:= 1],
%%%     Evens   = [X || X <- L, (X rem 2) =:= 0],
%%%    {Odds, Evens}.

odds_and_evens(L) ->
    odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
    case (H rem 2) of
        1 -> odds_and_evens_acc(T, [H|Odds], Evens);
        0 -> odds_and_evens_acc(T, Odds, [H|Evens])
    end;
odds_and_evens_acc([], Odds, Evens) ->
    { lists:reverse(Odds), lists:reverse(Evens) }.

my_time_func(F) ->
    {BHours, BMin, BSecs} = time(),
    F(),
    {AHours, AMin, ASecs} = time(),
    {
        {hours, time_diff(BHours, AHours)},
        {minutes, time_diff(BMin, AMin)},
        {seconds, time_diff(BSecs, ASecs)}
    }.

time_diff(X, Y) ->
    case Y > X of
        true -> Y - X;
        false -> 0
    end.

my_date_string() ->
    DateDivisor = "/",
    TimeDivisor = ":",
    {Year, Month, Day} = date(),
    {Hour, Minute, Second} = time(),
    lists:concat
    ([
        integer_to_list(Day), DateDivisor,
        integer_to_list(Month), DateDivisor,
        integer_to_list(Year), " ",
        integer_to_list(Hour), TimeDivisor,
        integer_to_list(Minute), TimeDivisor,
        integer_to_list(Second)
    ]).


count_characters(Str) ->
    count_characters(Str, #{}).

count_characters([H|T], X) ->
    case maps:is_key(H, X) of
        true ->
            #{ H := N} = X,
            count_characters(T, X#{ H := N + 1 });
        false -> count_characters(T, X#{ H => 1 })
    end;
count_characters([], X) ->
    X.

sqrt(X) when X < 0 ->
    error({squareRootNegativeArgument, X});
sqrt(X) ->
    math:sqrt(X).










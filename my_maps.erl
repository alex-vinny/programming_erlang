-module(my_maps).
-export([tests/0, map_search_pred/2]).

tests() ->
    Pred1 = fun(_, V) -> V =:= "mario" end,
    R = map_search_pred(#{names=>"marcio", n=>"mercio", name=>"mario", nome=>"jose", zap=>"mario"}, Pred1),
    R.

map_search_pred(Map, Pred) ->
    List = maps:to_list(Map),
    search(List, Pred).

search([H|T] , F) ->
    {Key, Value} = H,
    case F(Key, Value) of
        true -> H;
        false -> search(T, F)
    end;

search([], _) -> {}.
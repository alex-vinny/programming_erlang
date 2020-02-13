-module(geometry).
-export([test/0, area/1, perimeter/1]).
-import(lib_misc, [hypotenuse/0]).

test() ->
    12 = area({rectangle, 3, 4}),
    144 = area({square, 12}),
    25.0 = area({right_triangle, 10, 5}),
    14 = perimeter({rectangle, 3, 4}),
    48 = perimeter({square, 12}),
    12.0 = perimeter({right_triangle, 3, 4}),
    test_worked.

area({rectangle, Width, Height})        -> Width * Height;
area({square, Side})                    -> Side * Side;
area({circle, Radius})                  -> 3.14159 * Radius * Radius;
area({right_triangle, Base, Height})    -> Base * Height / 2.

perimeter({rectangle, Width, Height})       -> 2 * Width + 2 * Height;
perimeter({square, Side})                   -> 4 * Side;
perimeter({circle, Radius})                 -> 2 * Radius * 3.14159;
perimeter({right_triangle, Base, Height})   ->
    F = hypotenuse(),
    Base + Height + F( Base, Height).
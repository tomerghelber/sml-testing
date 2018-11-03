type ('a) predicate = 'a -> bool;
type ('a, 'b) matcher = 'a -> 'b predicate;

fun assertTrue (predicate: unit predicate) = predicate ();

fun assertFalse (predicate: unit predicate) = not (predicate ());

fun assertThat actual (matcher:('a, 'b) matcher) arguments = matcher arguments actual;

local
fun equalsToInner expected actual = op=(actual, expected);
in
val equalsTo: (''a, ''a) matcher = equalsToInner;
end;

local
fun doesntInner (predicate: 'a predicate) actual = not (predicate actual);
in
val doesnt: 'a predicate -> 'a predicate = doesntInner
end;

local
fun beforeByOrderInner (orderFunction, (expected: 'a)) (actual: 'a) = orderFunction (actual, expected) = LESS;
in
val beforeByOrder: ('a * 'a -> order) * 'a -> 'a predicate = beforeByOrderInner;
end;

local
fun afterByOrderInner (orderFunction, (expected: 'a)) (actual: 'a) = orderFunction (actual, expected) = GREATER;
in
val afterByOrder: ('a * 'a -> order) * 'a -> 'a predicate = afterByOrderInner;
end;

local
fun bothOfInner (predicate1: 'a predicate, predicate2: 'a predicate) actual = (predicate1 actual) andalso (predicate2 actual);
in
val bothOf: ('a predicate *  'a predicate) -> 'a predicate = bothOfInner;
end;

local
fun oneOfInner (predicate1: 'a predicate, predicate2: 'a predicate) actual = (predicate1 actual) orelse (predicate2 actual);
in
val oneOf: ('a predicate *  'a predicate) -> 'a predicate = oneOfInner;
end;

local
fun allOfInner predicates expected = List.all (fn (predicate: 'a predicate)=> predicate expected) predicates;
in
val allOf: 'a predicate list -> 'a predicate = allOfInner;
end;

local
fun anyOfInner predicates expected = List.exists (fn (predicate: 'a predicate)=> predicate expected) predicates;
in
val anyOf: 'a predicate list -> 'a predicate = anyOfInner;
end;

local
fun smallerThenIntInner expected actual = beforeByOrder (Int.compare, expected) actual;
in
val smallerThenInt: (int, int) matcher = smallerThenIntInner;
end;

local
fun biggerThenIntInner expected actual =  afterByOrder (Int.compare, expected) actual;
in
val biggerThenInt: (int, int) matcher = biggerThenIntInner;
end;

local
fun smallerThenRealInner expected actual = beforeByOrder (Real.compare, expected) actual;
in
val smallerThenReal: (real, real) matcher = smallerThenRealInner;
end;

local
fun biggerThenRealInner expected actual =  afterByOrder (Real.compare, expected) actual;
in
val biggerThenReal: (real, real) matcher = biggerThenRealInner;
end;

local
fun hasItemInner (predicate: 'a predicate) l = List.exists predicate l;
in
val hasItem: ('a predicate, 'a list) matcher = hasItemInner;
end;

local
fun allItemsInner (predicate: 'a predicate) l = List.all predicate l;
in
val allItems: ('a predicate, 'a list) matcher = allItemsInner;
end;

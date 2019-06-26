--------------------------- MODULE TLAPlayground ---------------------------

EXTENDS TLC, Sequences, Integers, FiniteSets

Range(T) == { T[x] : x \in DOMAIN T }
Range2(T) == { x : x \in T }

Eq(a, b) == a = b

Com(Op(_, _), a, b) == Op(a, b) = Op(b, a)

\* ---------------------------------------------------------

SetCheck(a, b) == {x * 2 : x \in a } \subseteq b

Find(el, set) ==  el \in UNION Range(set)  \*   {x \in UNION SUBSET set : el == x}

SpecSubset(set) == { x \in SUBSET set : Cardinality(x) = 2 }

\* ---------------------------------------------------------

Counter(str) == [c \in Range(str) |-> Cardinality({n \in 1..Len(str) : str[n] = c})]

RECURSIVE NumOcc(_)
NumOcc(word) == [w \in Range2(word) |-> {Cardinality(w \intersect word)} \union NumOcc(word \ w)]

ASSUME PrintT(NumOcc(<<"h", "e", "l", "l", "o">>))
ASSUME PrintT(SetCheck({1,2,3,4}, {2, 4, 6, 8, 12}))



=============================================================================
\* Modification History
\* Last modified Sat Mar 09 18:29:20 CET 2019 by Naxxo
\* Created Thu Mar 07 11:44:29 CET 2019 by Naxxo

--------------------------- MODULE TLAPlayground ---------------------------

EXTENDS TLC, Sequences, Integers, FiniteSets

Range(T) == { x : x \in DOMAIN T }

Eq(a, b) == a = b

Com(Op(_, _), a, b) == Op(a, b) = Op(b, a)

\* ---------------------------------------------------------

SetCheck(a, b) == {x * 2 : x \in a } \subseteq b

Find(el, set) ==  el \in UNION Range(set)  \*   {x \in UNION SUBSET set : el == x}

SpecSubset(set) == { x \in SUBSET set : Cardinality(x) = 2 }

\* ---------------------------------------------------------
\*RECURSIVE NumOcc(_)
\*
\*NumOcc(word) == [w \in Range(word) |-> {Cardinality(w \intersect word)} \union NumOcc(word \ w)]
\*
\*ASSUME PrintT(NumOcc("hello"))
ASSUME PrintT(SetCheck({1,2,3,4}, {4, 4, 6, 8, 12}))



=============================================================================
\* Modification History
\* Last modified Sat Mar 09 18:13:22 CET 2019 by Naxxo
\* Created Thu Mar 07 11:44:29 CET 2019 by Naxxo

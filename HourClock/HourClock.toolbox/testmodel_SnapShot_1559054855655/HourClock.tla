----------------------------- MODULE HourClock -----------------------------

EXTENDS Naturals
VARIABLES hr

Init == (*Global variables*)
       hr \in 1..12

HCnxt ==  /\ hr \in 1..12
          /\ hr' = (hr % 12) + 1

Next == [HCnxt]_hr

Spec == Init /\ [][Next]_hr

TempWithingRange == hr \in 1..12

THEOREM Spec => []TempWithingRange
=============================================================================
\* Modification History
\* Last modified Tue May 28 16:47:25 CEST 2019 by Naxxo
\* Created Tue Feb 05 10:24:40 CET 2019 by Naxxo

----------------------------- MODULE HourClock -----------------------------

EXTENDS Naturals
VARIABLES hr, tmp, alarm, alarmActive

vars == <<hr, tmp, alarm, alarmActive>>

Init == (*Global variables*)
       hr \in 1..12

HCnxt ==  /\ hr \in 1..12
          /\ hr' = (hr % 12) + 1

Next == [HCnxt]_vars

Spec == Init /\ [][Next]_vars

TempWithingRange == hr \in 1..12

THEOREM Spec => TempWithingRange
=============================================================================
\* Modification History
\* Last modified Tue May 28 16:43:29 CEST 2019 by Naxxo
\* Created Tue Feb 05 10:24:40 CET 2019 by Naxxo

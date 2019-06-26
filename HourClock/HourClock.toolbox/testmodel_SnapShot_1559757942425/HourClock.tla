----------------------------- MODULE HourClock -----------------------------

EXTENDS Naturals

VARIABLES hr

vars == <<hr>>

HCIni == (*Global variables*)
         hr \in (1..12)

HCnxt == hr' = IF hr # 12 THEN hr + 1 ELSE 1

HC == HCIni /\ [][HCnxt]_vars

Spec == HC /\ WF_vars(HCnxt)

HourInRange == [](hr \in 1..12)

THEOREM Spec => []HourInRange
=============================================================================
\* Modification History
\* Last modified Wed Jun 05 20:04:30 CEST 2019 by Naxxo
\* Created Tue Feb 05 10:24:40 CET 2019 by Naxxo

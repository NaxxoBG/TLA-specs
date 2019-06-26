----------------------------- MODULE HourClock -----------------------------

\*EXTENDS Naturals
\*VARIABLES hr, tmp, alarm, alarmActive
\*
\*vars == <<hr, tmp, alarm, alarmActive>>
\*
\*Init == (*Global variables*)
\*       /\ hr \in (1..12)
\*       /\ tmp = 20
\*       /\ alarm = 5
\*       /\ alarmActive = (hr = alarm)
\*
\*HCnxt ==  /\ hr' = IF hr # 12 THEN hr + 1 ELSE 1
\*          /\ UNCHANGED<<tmp, alarm, alarmActive>>
\*                    
\*HCTempnxt == /\ HCnxt
\*             /\ tmp' = IF tmp # 30 THEN tmp + 1 ELSE 20
\*             /\ UNCHANGED<<alarm, alarmActive>>
\*
\*HCalarm == /\ HCnxt
\*           /\ alarmActive' = IF alarm = hr THEN TRUE ELSE alarmActive
\*           /\ UNCHANGED alarm
\*           
\*HCSetAlarm == /\ HCnxt
\*              /\ alarm' = IF alarmActive = TRUE THEN alarm ELSE 0
\*              /\ UNCHANGED alarmActive
\*
\*HC == HCTempnxt \/ HCalarm \/ HCSetAlarm
\*
\*Next == [HC]_vars
\*
\*Spec == Init /\ [][Next]_vars
\*
\*TempWithingRange == tmp <= 30 /\ tmp >= 20
\*=============================================================================


EXTENDS Naturals
VARIABLES hr

Init == (*Global variables*)
       hr \in 1..12

HCnxt ==  /\ hr \in 1..12
          /\ hr' = (hr % 12) + 1

Next == [HCnxt]_hr

Spec == Init /\ [][Next]_hr

HourInRange == hr \in 1..12

THEOREM Spec => []HourInRange
=============================================================================
\* Modification History
\* Last modified Tue May 28 16:51:17 CEST 2019 by Naxxo
\* Created Tue Feb 05 10:24:40 CET 2019 by Naxxo

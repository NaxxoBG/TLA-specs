----------------------------- MODULE ComposedHC -----------------------------

EXTENDS Reals

VARIABLES x, y

Init == x \in (1..12) /\ y \in (1.12)

HCN(h) == h' = (h % 12) + 1

TCnxt == \/ HCN(x) /\ HCN(y)
         \/ HCN(x) /\ (y' = y)
         \/ HCN(y) /\ (x' = x)

\*TwoClock == /\ x \in (1..12) /\ [][HCN(x)]_x
\*            /\ y \in (1..12) /\ [][HCN(y)]_y

\*TwoClock == /\ x \in (1..12) /\ y \in (1..12)
\*            /\ [][
\*                    \/ HCN(x) /\ HCN(y) /\ (x' = x \/ y'= y)
\*                    \/ HCN(x) /\ y' = y
\*                    \/ HCN(y) /\ x' = x]_<<x, y>> 
\*            /\ [][x' = x \/ y' = y]_<<x, y>>  \* not operational
            
\*TwoClock == /\ x \in (1..12) /\ y \in (1..12)
\*            /\ [][HCN(x) /\ HCN(y)]_<<x, y>>
         
TwoClock == Init /\ [][TCnxt]_<<x, y>>     

=============================================================================
\* Modification History
\* Last modified Thu Mar 28 11:24:05 CET 2019 by Naxxo
\* Created Thu Mar 28 10:29:19 CET 2019 by Naxxo

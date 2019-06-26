----------------------------- MODULE ComposedHC -----------------------------

EXTENDS Reals

VARIABLES x, y

HCN(h) == h' = (h % 12) + 1

\*TwoClock == /\ x \in (1..12) /\ [][HCN(x)]_x
\*            /\ y \in (1..12) /\ [][HCN(y)]_y

\*TwoClock == /\ x \in (1..12) /\ y \in (1..12)
\*            /\ [][HCN(x) /\ HCN(y)]_<<x, y>>

TwoClock == /\ x \in (1..12) /\ y \in (1..12)
            /\ [][
                    \/ HCN(x) /\ HCN(y) /\ (x' = x \/ y'= y)
                    \/ HCN(x) /\ y' = y
                    \/ HCN(y) /\ x' = x]_<<x, y>> 
            /\ [][x' = x \/ y' = y]_<<x, y>> 
            
            

=============================================================================
\* Modification History
\* Last modified Thu Mar 28 11:10:34 CET 2019 by Naxxo
\* Created Thu Mar 28 10:29:19 CET 2019 by Naxxo

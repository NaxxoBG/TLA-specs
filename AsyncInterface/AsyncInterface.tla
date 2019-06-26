--------------------------- MODULE AsyncInterface ---------------------------

EXTENDS Naturals

CONSTANT Data

VARIABLES val, rdy, ack

TypeInvariant == /\ val \in Data
                 /\ rdy \in {0, 1}
                 /\ ack \in rdy
                 
Init == /\ val \in Data
        /\ rdy \in {0, 1}
        /\ ack = rdy

\* Definition of an action begins with its enabling step. */
              
NextSnd == /\ rdy = ack
           /\ val' \in Data
           /\ rdy' = rdy ^ 1
           /\ UNCHANGED ack

        
NextAck == /\ rdy # ack
           /\ UNCHANGED <<val, rdy>>
           /\ ack' = ack ^ 1

Next == NextSnd \/ NextAck

Spec == Init /\ [][Next]_<<val, rdy, ack>>

THEOREM Spec => []TypeInvariant

=============================================================================
\* Modification History
\* Last modified Tue Feb 12 09:50:29 CET 2019 by Naxxo
\* Created Tue Feb 12 08:35:08 CET 2019 by Naxxo

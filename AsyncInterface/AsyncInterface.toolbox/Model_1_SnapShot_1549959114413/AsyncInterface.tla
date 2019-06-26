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
                 
NextSnd == /\ val' = val
           /\ rdy' = rdy ^ 1
           /\ UNCHANGED ack
           
NextAck == /\ UNCHANGED val
           /\ UNCHANGED rdy
           /\ ack' = ack ^ 1

Next == NextSnd \/ NextAck



=============================================================================
\* Modification History
\* Last modified Tue Feb 12 09:10:30 CET 2019 by Naxxo
\* Created Tue Feb 12 08:35:08 CET 2019 by Naxxo

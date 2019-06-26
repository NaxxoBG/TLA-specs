------------------------- MODULE AsyncInAssignment -------------------------
EXTENDS Naturals

CONSTANT Data

VARIABLES chan

TypeInvariant == chan \in [val: Data, val2: Data,rdy: {0,1}, ack : {0,1}]
                 
Init == /\ TypeInvariant
        /\ chan.ack = chan.rdy

\* Definition of an action begins with its enabling step.a
                
NextSnd(d, d2) == 
         /\ d2 > d
         /\ chan.rdy = chan.ack
         /\ chan' = [chan EXCEPT !.val = d, !.val2 = d2, !.rdy = 1 - @]
\* Another way to define chan' /\ chan' = [val |-> d, rdy |-> 1 - chan.rdy, ack |-> chan.ack]
        
NextAck == /\ chan.rdy # chan.ack
           /\ chan' = [chan EXCEPT !.ack = 1 - @]

Next == (\E d, d2 \in Data : NextSnd(d, d2)) \/ NextAck

Spec == Init /\ [][Next]_chan

THEOREM Spec => []TypeInvariant

=============================================================================
\* Modification History
\* Last modified Thu Feb 14 10:21:14 CET 2019 by Naxxo
\* Created Thu Feb 14 10:10:10 CET 2019 by Naxxo

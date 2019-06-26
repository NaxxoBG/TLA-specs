-------------------------------- MODULE Fifo --------------------------------
EXTENDS Naturals

CONSTANT Data

VARIABLES chan

\* Records can also be viewed as functions with their fields specifying their domain

TypeInvariant == chan \in [val: Data, val2: Data, rdy: {0,1}, ack : {0,1}]
                 
Init == /\ TypeInvariant
        /\ chan.ack = chan.rdy \* same notation as chan["rdy"]

\* Definition of an action begins with its enabling step.a
                
NextSnd(d, d2) == 
         /\ d2 > d
         /\ chan.rdy = chan.ack
         /\ chan' = [chan EXCEPT !.val = d, !.val2 = d2, !.rdy = 1 - @]
\* Another way to define chan' /\ chan' = [val |-> d, rdy |-> 1 - chan.rdy, ack |-> chan.ack]
        
NextAck == /\ chan.rdy # chan.ack
           /\ chan' = [chan EXCEPT !.ack = 1 - @] \* the same as [chan EXCEPT !"ack" = 1 - @]

Next == (\E d, d2 \in Data : NextSnd(d, d2)) \/ NextAck

Spec == Init /\ [][Next]_chan

THEOREM Spec => []TypeInvariant

=============================================================================
\* Modification History
\* Last modified Tue Feb 19 09:10:38 CET 2019 by Naxxo
\* Created Tue Feb 19 08:47:26 CET 2019 by Naxxo

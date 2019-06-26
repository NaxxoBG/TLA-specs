------------------------------ MODULE AsyncIn ------------------------------

(* This is the modified version of the async interface using a record with th
e variables instead of using them individually. *)

EXTENDS Naturals

CONSTANT Data

VARIABLES chan

TypeInvariant == chan \in [val: Data, rdy: {0,1}, ack : {0,1}]
                 
Init == /\ TypeInvariant
        /\ chan.ack = chan.rdy

\* Definition of an action begins with its enabling step.a
                
NextSnd(d) == 
         /\ chan.rdy = chan.ack
         /\ chan' = [chan EXCEPT !.val = d, !.rdy = 1 - @]
\* Another way to define chan' /\ chan' = [val |-> d, rdy |-> 1 - chan.rdy, ack |-> chan.ack]
        
NextAck == /\ chan.rdy # chan.ack
           /\ chan' = [chan EXCEPT !.ack = 1 - @]

Next == (\E d \in Data : NextSnd(d)) \/ NextAck

Spec == Init /\ [][Next]_chan

THEOREM Spec => []TypeInvariant

=============================================================================
\* Modification History
\* Last modified Tue Feb 12 11:15:15 CET 2019 by Naxxo
\* Created Tue Feb 12 10:20:08 CET 2019 by Naxxo

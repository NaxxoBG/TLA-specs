------------------------- MODULE Channel -------------------------
\* Channel specification

EXTENDS Naturals

CONSTANT Data

VARIABLES chan

\* Records can also be viewed as functions with their fields specifying their domain

TypeInvariant == chan \in [val: Data, rdy: {0,1}, ack : {0,1}]
                 
Init == /\ TypeInvariant
        /\ chan.ack = chan.rdy \* same notation as chan["rdy"]

\* Definition of an action begins with its enabling step.a
                
Send(d) == 
         /\ chan.rdy = chan.ack
         /\ chan' = [chan EXCEPT !.val = d, !.rdy = 1 - @]
\* Another way to define chan' /\ chan' = [val |-> d, rdy |-> 1 - chan.rdy, ack |-> chan.ack]
        
Rcv == 
      /\ chan.rdy # chan.ack
      /\ chan' = [chan EXCEPT !.ack = 1 - @] \* the same as [chan EXCEPT !"ack" = 1 - @]

Next == (\E d \in Data : Send(d)) \/ Rcv

(*Spec == Init /\ [][Next]_chan

THEOREM Spec => []TypeInvariant*)

=============================================================================
\* Modification History
\* Last modified Tue Feb 19 11:35:28 CET 2019 by Naxxo
\* Created Thu Feb 14 10:10:10 CET 2019 by Naxxo

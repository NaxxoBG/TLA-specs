----------------------------- MODULE InnerLIFO -----------------------------
EXTENDS Naturals, Sequences

CONSTANT Message (* Set of messages that are sent but not yet received *)

VARIABLES in, out, q

InChan == INSTANCE Channel WITH Data <- Message, chan <- in

OutChan == INSTANCE Channel WITH Data <- Message, chan <- out

Init == /\ InChan!Init
        /\ OutChan!Init
        /\ q = <<>>
        
TypeInvariant == /\ InChan!TypeInvariant
                 /\ OutChan!TypeInvariant
                 /\ q \in Seq(Message)

(* Send message on channel in *)
Sending(msg) == /\ InChan!Send(msg)
                /\ UNCHANGED <<out, q>>
             
BufRcv == /\ InChan!Rcv
          /\ q' = <<in.val>> \o q
          /\ UNCHANGED out
         
BufSend == /\ q # <<>>
           /\ OutChan!Send(Head(q))
           /\ q' = Tail(q)
           /\ UNCHANGED in
          
Receiving == /\ OutChan!Rcv
             /\ UNCHANGED <<in, q>>
       
Next == \/ \E msg \in Message : Sending(msg)
        \/ BufRcv
        \/ BufSend
        \/ Receiving

Spec == Init /\ [][Next]_<<in, out, q>>

THEOREM Spec => []TypeInvariant

=============================================================================
\* Modification History
\* Last modified Tue Jun 04 20:03:05 CEST 2019 by Naxxo
\* Created Thu Feb 21 12:23:54 CET 2019 by Naxxo

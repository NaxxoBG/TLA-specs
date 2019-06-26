----------------------------- MODULE InnerFIFO -----------------------------

EXTENDS Naturals, Sequences

CONSTANT Message (* Set of messages that are sent but not yet received *)

VARIABLES in, out, q

InChan == INSTANCE Channel WITH Data <- Message, chan <- in

OutChan == INSTANCE Channel WITH Data <- Message, chan <- out

Init == 
        /\ InChan!Init
        /\ OutChan!Init
        /\ q = <<>>
        
TypeInvariant == 
                /\ InChan!TypeInvariant
                /\ OutChan!TypeInvariant
                /\ q \in Seq(Message)

SSend(msg) == (* Send message on channel in *)
             /\ InChan!Send(msg)
             /\ UNCHANGED <<out, q>>
             
BufRcv ==
         /\ InChan!Rcv
         /\ q' = Append(q, in.val) (*Append message to tail of q*)
         /\ UNCHANGED out
         
BufSend ==
          /\ q # <<>>
          /\ OutChan!Send(Head(q))
          /\ q' = Tail(q)
          /\ UNCHANGED in
          
RRcv ==
       /\ OutChan!Rcv
       /\ UNCHANGED <<in, q>>
       
Next == 
       \/ \E msg \in Message : SSend(msg)
       \/ BufRcv
       \/ BufSend
       \/ RRcv

Spec == Init /\ [][Next]_<<in, out, q>>

THEOREM Spec => []TypeInvariant

=============================================================================
\* Modification History
\* Last modified Tue Feb 19 11:26:12 CET 2019 by Naxxo
\* Created Tue Feb 19 10:08:08 CET 2019 by Naxxo

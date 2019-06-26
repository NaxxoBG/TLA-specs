-------------------------- MODULE MemoryInterface --------------------------

VARIABLE memInt


CONSTANTS Send(_,_,_,_), Reply(_,_,_,_), InitMemInt, Proc, Adr, Val

ASSUME \A p, d, miOld, miNew: /\ Send(p, d, miOld, miNew) \in BOOLEAN
                              /\ Reply(p, d, miOld, miNew) \in BOOLEAN
                              
MReq == [op: {"Rd"}, adr: Adr] \cup [op: {"Wr"}, adr: Adr, val: Val]

NoVal == CHOOSE v : v \notin Val


ASSUME \A p, r, miOld : \E miNew : Reply(p, r, miOld, miNew)
=============================================================================
\* Modification History
\* Last modified Sun Mar 24 17:00:00 CET 2019 by Naxxo
\* Created Sat Mar 09 14:07:39 CET 2019 by Naxxo

--------------------------- MODULE NeilsenMizuno ---------------------------

EXTENDS Naturals, FiniteSets, Sequences

CONSTANTS N

VARIABLES parent, deferred, holding, source, originator, req, tok, pc, critical

Vars == <<parent, deferred, holding, source, originator, req, tok, pc, critical>>

Nodes == 1..N

Send(m,chan,i) == IF i=0 THEN chan' = chan ELSE chan' = [chan EXCEPT ![i] = Append(@,m)] \* "totalised" channel sending operation

Recv(v,chan,i) == chan[i] # << >> /\ v = Head(chan[i]) /\ chan' = [chan EXCEPT ![i] = Tail(@)] \* channel reception operation

Test(chan,i) == chan[i] # << >>

MainPC == {"main_ckholding", "main_sendreq",  "main_setparent", "main_recvtok", "main_critsec", "main_ckdeferred", "main_sendtok", "main_setdeferred", "main_setholding"}

ReceivePC == {"recv_recvreq", "recv_ckparent", "recv_ckholding", "recv_setdeferred", "recv_sendtok", "recv_setholding", "recv_sendreq", "recv_setparent"}

PC == MainPC \union ReceivePC \union {"driver"}

TypeInvariant == /\ parent \in [Nodes -> {0}\union Nodes]
                 /\ deferred \in [Nodes -> {0}\union Nodes]
                 /\ holding \in [Nodes -> BOOLEAN]
                 /\ source \in [Nodes -> Nodes]
                 /\ originator \in [Nodes -> Nodes]
                 /\ req \in [Nodes -> Seq([sender: Nodes, origin: Nodes])]
                 /\ tok \in [Nodes -> Seq({0})]
                 /\ pc \in [Nodes -> PC]
                 /\ critical \in {0}\union Nodes

ChanInvariant == /\ (\A n \in Nodes: Len(req[n]) <= N-1)
                 /\ (\A n \in Nodes: Len(tok[n]) <= 1)
                 
MutualExclusion == critical <= 1

\* holdin[n] = TRUE means "node n is in its critical section"

Driver(n) == /\ pc[n] = "driver"
             /\ IF Test(req,n) THEN pc' = [pc EXCEPT ![n] = "recv_recvreq"] ELSE pc' = [pc EXCEPT ![n] = "main_ckholding"]
             /\ UNCHANGED(<<parent, deferred, holding, source, originator, req, tok, critical>>)

Main_ckholdingN(n) == /\ pc[n] = "main_ckholding" \* Node n does not have the token (and needs to request it to proceed)
                      /\ holding[n] = FALSE 
                      /\ pc' = [pc EXCEPT ![n] = "main_sendreq"]
                      /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,tok,critical>>)

Main_ckholdingY(n) == /\ pc[n] = "main_ckholding" \* Node n has the token (and can proceed to its critical section)
                      /\ holding[n] = TRUE 
                      /\ pc' = [pc EXCEPT ![n] = "main_critsec"]
                      /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,tok,critical>>)
                      
Main_sendreq(n) == /\ pc[n] = "main_sendreq" \* Node n requests the token
                   /\ Send([sender |-> n, origin |-> n], req, parent[n]) 
                   /\ pc' = [pc EXCEPT ![n] = "main_setparent"]
                   /\ UNCHANGED(<<parent,deferred,holding,source,originator,tok,critical>>)

Main_setparent(n) == /\ pc[n] = "main_setparent" \* Node n declares itself the new root
                   /\ parent' = [parent EXCEPT ![n] = 0]
                   /\ pc' = [pc EXCEPT ![n] = "main_recvtok"]
                   /\ UNCHANGED(<<deferred,holding,source,originator,req,tok,critical>>)

Main_recvtok(n) == /\ pc[n] = "main_recvtok" \* Node n waits until it receives the token allowing it to enter the critical section
                   /\ Recv(0,tok,n) 
                   /\ pc' = [pc EXCEPT ![n] = "main_critsec"]
                   /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,critical>>)

Main_critsec(n) == /\ pc[n] = "main_critsec" \* node n enters its critical section
                   /\ holding' = [holding EXCEPT ![n] = FALSE] 
                   /\ critical' = critical + 1
                   /\ pc' = [pc EXCEPT ![n] = "main_ckdeferred"]
                   /\ UNCHANGED(<<parent,deferred,source,originator,req,tok>>)

Main_ckdeferredY(n) == /\ pc[n] = "main_ckdeferred" \* another node waits already for the token
                       /\ deferred[n] # 0 
                       /\ critical = critical - 1
                       /\ pc' = [pc EXCEPT ![n] = "main_sendtok"]
                       /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,tok>>)

Main_sendtok(n) == /\ pc[n] = "main_sendtok" \* send the token immediately
                       /\ Send(0,tok,deferred[n])
                       /\ pc' = [pc EXCEPT ![n] = "main_setdeferred"]
                       /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,critical>>)

Main_setdeferred(n) == /\ pc[n] = "main_setdeferred" \* the token has been send (and is no longer deferred)
                       /\ deferred' = [deferred EXCEPT ![n] = 0]
                       /\ pc' = [pc EXCEPT ![n] = "driver"]
                       /\ UNCHANGED(<<parent,holding,source,originator,req,tok,critical>>)

Main_ckdeferredN(n) == /\ pc[n] = "main_ckdeferred" \* there is no open request for the token, so reclaim it
                       /\ deferred[n] = 0 
                       /\ critical' = critical - 1
                       /\ pc' = [pc EXCEPT ![n] = "main_setholding"]
                       /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,tok>>)

Main_setholding(n) == /\ pc[n] = "main_setholding" \* there is no open request for the token, so reclaim it
                       /\ holding' = [holding EXCEPT ![n] = TRUE]
                       /\ pc' = [pc EXCEPT ![n] = "driver"]
                       /\ UNCHANGED(<<parent,deferred,source,originator,req,tok,critical>>)

Main(n) == \/ Main_ckholdingN(n)
           \/ Main_ckholdingY(n)
           \/ Main_sendreq(n)
           \/ Main_setparent(n)
           \/ Main_recvtok(n)
           \/ Main_critsec(n)
           \/ Main_ckdeferredY(n)
           \/ Main_sendtok(n)
           \/ Main_setdeferred(n)
           \/ Main_ckdeferredN(n)
           \/ Main_setholding(n)

Receive_recvreq(n) == /\ pc[n] = "recv_recvreq" \* node n waits until a request for the token is received
                      /\ (\E v \in [sender: Nodes, origin: Nodes]:
                                        /\ Recv(v,req,n)
                                        /\ source' = [source EXCEPT ![n] = v.sender]
                                        /\ originator' = [originator EXCEPT ![n] = v.origin])
                      /\ pc' = [pc EXCEPT ![n] = "recv_ckparent"]
                      /\ UNCHANGED(<<parent,deferred,holding,tok,critical>>)

Receive_ckparentN(n) == /\ pc[n] = "recv_ckparent" \* Node n has the token or is waiting for it, and thus has declared itelf the root of the tree
                        /\ parent[n] = 0
                        /\ pc' = [pc EXCEPT ![n] = "recv_ckholding"]
                        /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,tok,critical>>)

Receive_ckholdingY(n) == /\ pc[n] = "recv_ckholding" \* Node n is not in its critical section
                         /\ holding[n] = TRUE
                         /\ pc' = [pc EXCEPT ![n] = "recv_sendtok"]
                         /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,tok,critical>>)

Receive_sendtok(n) == /\ pc[n] = "recv_sendtok" \* Send the token away immediately 
                        /\ Send(0,tok,originator[n])
                        /\ pc' = [pc EXCEPT ![n] = "recv_setholding"]
                        /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,critical>>)

Receive_setholding(n) == /\ pc[n] = "recv_setholding" \* Release the local token
                        /\ holding' = [holding EXCEPT ![n] = FALSE]
                        /\ pc' = [pc EXCEPT ![n] = "recv_setparent"]
                        /\ UNCHANGED(<<parent,deferred,source,originator,req,tok,critical>>)

Receive_ckholdingN(n) == /\ pc[n] = "recv_ckholding" \* Node n does not have the token
                         /\ holding[n] = FALSE
                         /\ pc' = [pc EXCEPT ![n] = "recv_setdeferred"]
                         /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,tok,critical>>)

Receive_setdeferred(n) == /\ pc[n] = "recv_setdeferred" \* Defer sending the token of node n
                         /\ deferred' = [deferred EXCEPT ![n] = originator[n]]
                         /\ pc' = [pc EXCEPT ![n] = "recv_setparent"]
                         /\ UNCHANGED(<<parent,holding,source,originator,req,tok,critical>>)

Receive_ckparentY(n) == /\ pc[n] = "recv_ckparent" \* Node n is not the root (hence cannot have the token)
                        /\ parent[n] # 0
                        /\ pc' = [pc EXCEPT ![n] = "recv_sendreq"]
                        /\ UNCHANGED(<<parent,deferred,holding,source,originator,req,tok,critical>>)

Receive_sendreq(n) == /\ pc[n] = "recv_sendreq" \* forward the token request from originator to parent
                      /\ Send([sender |-> n, origin |-> originator[n]],req,parent[n])
                      /\ pc' = [pc EXCEPT ![n] = "recv_setparent"]
                      /\ UNCHANGED(<<parent,deferred,holding,source,originator,tok,critical>>)

Receive_setparent(n) == /\ pc[n] = "recv_setparent" \* make the sender of the request the parent of node n
                        /\ parent' = [parent EXCEPT ![n] = source[n]]
                        /\ pc' = [pc EXCEPT ![n] = "driver"]
                        /\ UNCHANGED(<<deferred,holding,source,originator,req,tok,critical>>)

Receive(n) == \/ Receive_recvreq(n)
              \/ Receive_ckparentN(n)
              \/ Receive_ckholdingY(n)
              \/ Receive_sendtok(n)
              \/ Receive_setholding(n)
              \/ Receive_ckholdingN(n)
              \/ Receive_ckparentY(n)
              \/ Receive_sendreq(n)
              \/ Receive_setparent(n)

Algorithm(n) == \/ Receive(n)
                \/ Main(n)
                \/ Driver(n)

Next == (\E n \in Nodes: Algorithm(n))

Init == /\ parent = [n \in Nodes |-> n-1] \* linear list pointing towards node 1
        /\ deferred = [n \in Nodes |-> 0] \* there are no open request for the token
        /\ holding = [n \in Nodes |-> IF n = 1 THEN TRUE ELSE FALSE] \* node 1 has the token and is not in its critical section
        /\ source = [n \in Nodes |-> 1] \* local variable of "Receive" to store the sender of a request
        /\ originator = [n \in Nodes |-> 1] \* local variable of "Receive" to store the originator of a request
        /\ req = [n \in Nodes |-> << >>] \* request channels
        /\ tok = [n \in Nodes |-> << >>] \* token channels
        /\ pc = [n \in Nodes |-> "driver"] \* initial program counter
        /\ critical = 0 \* no node is in its critical section
        
Spec == Init /\ [] [Next]_Vars /\ WF_Vars(Next)



=============================================================================
\* Modification History
\* Last modified Tue Apr 23 08:26:42 CEST 2019 by Naxxo
\* Created Tue Apr 02 10:57:04 CEST 2019 by Naxxo

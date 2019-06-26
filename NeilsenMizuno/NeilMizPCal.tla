---------------------------- MODULE NeilMizPCal ----------------------------
EXTENDS Naturals, Sequences, TLC

CONSTANTS N


(* --algorithm NeilMizuno {
 variables Nodes = 1..N,
           deferred = [n \in Nodes |-> 0],
           parent = [p \in Nodes |-> 1 - p],
           holding = [i \in Nodes |-> IF (i = 1) THEN {TRUE} ELSE FALSE],
           token = [e \in {0} |-> << >>],
           request = [e \in Nodes \cup {0} |-> <<>>];
 
 define {
     Send(msg, chan, i) == IF (i = 0) THEN 
                             chan' == chan
                           ELSE 
                             chan' == [chan EXCEPT ![i] = Append(@, msg)]
                             
     Receive(val, chan, i) == /\ chan[i] # <<>>
                              /\ val == Head(chan[i])
                              /\ chan' == [chan EXCEPT ![i] = Tail(@)]                   
     
 }          
 
 fair process (ProcName \in Nodes) 
 variable nVals = [last |-> 0, next |-> 0];
      { Main: while (TRUE) {
               either { 
             p1:   if (!holding[self]) {
             p2:     Send([last |-> self, next |-> self], parent[self]);
             p3:     parent[self] := 0;
             p4:     {
                         await tok[i] # << >>;
                         tok[i] := Tail(tok[i]);
                     };
                   };
             p5:   holding[self] := FALSE;
             p6:   assert \A p \in Nodes: (p # self) => (pc[p] # "p6")
             p7:   if (deferred[self] # 0) {
             p8:     send(0, token, deferred[self]);
             p9:    deferred[self] := 0;
             p10:  } else {
                     holding[self] := TRUE;
                   }
               }
               or { 
             p11: {
                     await request[i] # <<>>;
                     nVals = Head(request[self]);
                     request[self] = Tail(request[self])            
                  }
             p12: if (parent[self] = 0) {
             p13   if (holding[self]) {
             p14:       token[self] = Append(token[self], 0);
             p15:       holding[self] := FALSE;
                    } else {
             p16:       deferred[self] := nVal.originator            
                    }
                  else {
             p17:   Send(0, parent[self], self)     
                  }
             p18: parent := nVal.last
               }
      }
}  *)


=============================================================================
\* Modification History
\* Last modified Mon Apr 29 14:23:10 CEST 2019 by Naxxo
\* Created Tue Apr 23 09:02:50 CEST 2019 by Naxxo

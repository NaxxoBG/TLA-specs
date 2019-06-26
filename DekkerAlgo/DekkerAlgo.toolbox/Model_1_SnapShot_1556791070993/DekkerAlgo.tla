----------------------------- MODULE DekkerAlgo -----------------------------

EXTENDS TLC, Integers

CONSTANT N

Nodes == 1..N

(* --algorithm Dekker
variables b = [n \in Nodes \cup {0} |-> n],
          c = [n \in Nodes |-> n],
          turn = 0;
    process ProcName \in Nodes
        variable j = 0;
        begin
            A1: b[self] := 0;
            L1: if turn # self then 
            L2:   c[self] := 1;
            L3:   if b[turn] = 1 then
            L4:       turn := self;
                  end if;
            L5:   goto L1;
                end if;
            L6: c[self] := 1;
            L7:  j := 1;
            L8: while j <= N do 
            L9:   j := j + 1;
            L10:   if j # self /\ c[j] = 0 then
            L11:         goto L1;
                  end if;
                end while;
            L12: assert \A p \in Nodes: (p # self) => (pc[p] # "L12");
            L14: turn := 0;
            L15: c[self] := 1;
            L16: b[self] := 1;
            L17: goto A1;
        end process
end algorithm
*)
\* BEGIN TRANSLATION
VARIABLES b, c, turn, pc, j

vars == << b, c, turn, pc, j >>

ProcSet == (Nodes)

Init == (* Global variables *)
        /\ b = [n \in Nodes \cup {0} |-> n]
        /\ c = [n \in Nodes |-> n]
        /\ turn = 0
        (* Process ProcName *)
        /\ j = [self \in Nodes |-> 0]
        /\ pc = [self \in ProcSet |-> "A1"]

A1(self) == /\ pc[self] = "A1"
            /\ b' = [b EXCEPT ![self] = 0]
            /\ pc' = [pc EXCEPT ![self] = "L1"]
            /\ UNCHANGED << c, turn, j >>

L1(self) == /\ pc[self] = "L1"
            /\ IF turn # self
                  THEN /\ pc' = [pc EXCEPT ![self] = "L2"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "L6"]
            /\ UNCHANGED << b, c, turn, j >>

L2(self) == /\ pc[self] = "L2"
            /\ c' = [c EXCEPT ![self] = 1]
            /\ pc' = [pc EXCEPT ![self] = "L3"]
            /\ UNCHANGED << b, turn, j >>

L3(self) == /\ pc[self] = "L3"
            /\ IF b[turn] = 1
                  THEN /\ pc' = [pc EXCEPT ![self] = "L4"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "L5"]
            /\ UNCHANGED << b, c, turn, j >>

L4(self) == /\ pc[self] = "L4"
            /\ turn' = self
            /\ pc' = [pc EXCEPT ![self] = "L5"]
            /\ UNCHANGED << b, c, j >>

L5(self) == /\ pc[self] = "L5"
            /\ pc' = [pc EXCEPT ![self] = "L1"]
            /\ UNCHANGED << b, c, turn, j >>

L6(self) == /\ pc[self] = "L6"
            /\ c' = [c EXCEPT ![self] = 1]
            /\ pc' = [pc EXCEPT ![self] = "L7"]
            /\ UNCHANGED << b, turn, j >>

L7(self) == /\ pc[self] = "L7"
            /\ j' = [j EXCEPT ![self] = 1]
            /\ pc' = [pc EXCEPT ![self] = "L8"]
            /\ UNCHANGED << b, c, turn >>

L8(self) == /\ pc[self] = "L8"
            /\ IF j[self] <= N
                  THEN /\ pc' = [pc EXCEPT ![self] = "L9"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "L12"]
            /\ UNCHANGED << b, c, turn, j >>

L9(self) == /\ pc[self] = "L9"
            /\ j' = [j EXCEPT ![self] = j[self] + 1]
            /\ pc' = [pc EXCEPT ![self] = "L10"]
            /\ UNCHANGED << b, c, turn >>

L10(self) == /\ pc[self] = "L10"
             /\ IF j[self] # self /\ c[j[self]] = 0
                   THEN /\ pc' = [pc EXCEPT ![self] = "L11"]
                   ELSE /\ pc' = [pc EXCEPT ![self] = "L8"]
             /\ UNCHANGED << b, c, turn, j >>

L11(self) == /\ pc[self] = "L11"
             /\ pc' = [pc EXCEPT ![self] = "L1"]
             /\ UNCHANGED << b, c, turn, j >>

L12(self) == /\ pc[self] = "L12"
             /\ Assert(\A p \in Nodes: (p # self) => (pc[p] # "L12"), 
                       "Failure of assertion at line 30, column 18.")
             /\ pc' = [pc EXCEPT ![self] = "L14"]
             /\ UNCHANGED << b, c, turn, j >>

L14(self) == /\ pc[self] = "L14"
             /\ turn' = 0
             /\ pc' = [pc EXCEPT ![self] = "L15"]
             /\ UNCHANGED << b, c, j >>

L15(self) == /\ pc[self] = "L15"
             /\ c' = [c EXCEPT ![self] = 1]
             /\ pc' = [pc EXCEPT ![self] = "L16"]
             /\ UNCHANGED << b, turn, j >>

L16(self) == /\ pc[self] = "L16"
             /\ b' = [b EXCEPT ![self] = 1]
             /\ pc' = [pc EXCEPT ![self] = "L17"]
             /\ UNCHANGED << c, turn, j >>

L17(self) == /\ pc[self] = "L17"
             /\ pc' = [pc EXCEPT ![self] = "A1"]
             /\ UNCHANGED << b, c, turn, j >>

ProcName(self) == A1(self) \/ L1(self) \/ L2(self) \/ L3(self) \/ L4(self)
                     \/ L5(self) \/ L6(self) \/ L7(self) \/ L8(self)
                     \/ L9(self) \/ L10(self) \/ L11(self) \/ L12(self)
                     \/ L14(self) \/ L15(self) \/ L16(self) \/ L17(self)

Next == (\E self \in Nodes: ProcName(self))
           \/ (* Disjunct to prevent deadlock on termination *)
              ((\A self \in ProcSet: pc[self] = "Done") /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION



=============================================================================
\* Modification History
\* Last modified Thu May 02 11:56:39 CEST 2019 by Naxxo
\* Created Tue Apr 30 08:41:06 CEST 2019 by Naxxo

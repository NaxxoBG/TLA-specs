---------------------------- MODULE pCalCounter ----------------------------

EXTENDS Integers

CONSTANT N

((***************************************************************************
 --algorithm Counter {
  variables counter = 1;
  fair process (p \in {1}) {
    cter: 
        while (counter <= N) {
            counter := counter + 1;
        }
    }
  } 
}
  ***************************************************************************)
\* BEGIN TRANSLATION
VARIABLES counter, pc

vars == << counter, pc >>

ProcSet == ({1})

Init == (* Global variables *)
        /\ counter = 1
        /\ pc = [self \in ProcSet |-> "cter"]

cter(self) == /\ pc[self] = "cter"
              /\ IF counter <= N
                    THEN /\ counter' = counter + 1
                         /\ pc' = [pc EXCEPT ![self] = "cter"]
                    ELSE /\ pc' = [pc EXCEPT ![self] = "Done"]
                         /\ UNCHANGED counter

p(self) == cter(self)

Next == (\E self \in {1}: p(self))
           \/ (* Disjunct to prevent deadlock on termination *)
              ((\A self \in ProcSet: pc[self] = "Done") /\ UNCHANGED vars)

Spec == /\ Init /\ [][Next]_vars
        /\ \A self \in {1} : WF_vars(p(self))

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION
 


=============================================================================
\* Modification History
\* Last modified Thu Apr 11 11:15:07 CEST 2019 by Naxxo
\* Created Thu Apr 11 10:34:48 CEST 2019 by Naxxo

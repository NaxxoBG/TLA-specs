--------------------------- MODULE pCalCounterSeq ---------------------------
EXTENDS Integers, TLC

(* --algorithm Counter
variable x = 5;
begin
counter: while x > 0 do
        x := x - 1;
       end while;
end algorithm; *)
\* BEGIN TRANSLATION
VARIABLES x, pc

vars == << x, pc >>

Init == (* Global variables *)
        /\ x = 5
        /\ pc = "counter"

counter == /\ pc = "counter"
           /\ IF x > 0
                 THEN /\ x' = x - 1
                      /\ pc' = "counter"
                 ELSE /\ pc' = "Done"
                      /\ x' = x

Next == counter
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Tue May 07 09:25:08 CEST 2019 by Naxxo
\* Created Tue May 07 09:20:45 CEST 2019 by Naxxo

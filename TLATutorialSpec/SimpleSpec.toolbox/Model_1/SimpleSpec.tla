----------------------------- MODULE SimpleSpec -----------------------------
EXTENDS Integers
VARIABLES i, pc   

Init == (pc = "start") /\ (i = 0)

Pick == /\ pc = "start"  
        /\ i' \in 0..1000
        /\ pc' = "middle"

Add1 == /\ pc = "middle" 
        /\ i' = i + 1
        /\ pc' = "done"  
           
Next == Pick \/ Add1

=============================================================================
\* Modification History
\* Last modified Sat Feb 09 14:25:07 CET 2019 by Naxxo
\* Created Sat Feb 09 14:24:59 CET 2019 by Naxxo

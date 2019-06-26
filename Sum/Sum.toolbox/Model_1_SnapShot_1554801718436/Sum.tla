-------------------------------- MODULE Sum --------------------------------
EXTENDS TLC, Reals

CONSTANT N

VARIABLE sum, counter

\* KeepIncreasing(i) == sum < sum + i ; operator

\* KeepIncreasing == \A c \in 2..N : sum < c - 1  ; invariant

KeepIncreasing == [](sum < sum + counter) \* ; property

Init == 
        /\ counter = 1
        /\ sum = 0

Next == 
        /\ counter < N
        /\ counter' = counter + 1
        /\ sum' = sum + counter
        
Spec == Init /\ [][Next]_<<sum, counter>>
        

=============================================================================
\* Modification History
\* Last modified Tue Apr 09 11:07:52 CEST 2019 by Naxxo
\* Created Tue Apr 09 10:42:30 CEST 2019 by Naxxo

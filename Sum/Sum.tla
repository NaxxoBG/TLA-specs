-------------------------------- MODULE Sum --------------------------------
\* Check pCalCounter project for a PlusCal version of the specification

EXTENDS TLC, Reals

CONSTANT N

VARIABLE sum, counter

\* KeepIncreasing(i) == sum < sum + i ; operator

\* KeepIncreasing == \A c \in 2..N : sum < c - 1  ; invariant

KeepIncreasing == [](sum < sum + counter) \* ; property
MaxReached == <>(counter = N)

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
\* Last modified Thu Apr 11 11:47:59 CEST 2019 by Naxxo
\* Created Tue Apr 09 10:42:30 CEST 2019 by Naxxo

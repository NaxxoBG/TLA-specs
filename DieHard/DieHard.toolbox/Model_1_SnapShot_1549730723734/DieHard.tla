------------------------------ MODULE DieHard ------------------------------
EXTENDS Integers

VARIABLES small, big

TypeOK == /\ small \in 0..3
          /\ big \in 0..5
          
Init == /\ big = 0
        /\ small = 0
        
FillSmall == /\ small' = 3 
             /\ UNCHANGED big
FillBig == /\ big = 5
           /\ UNCHANGED small

EmptySmall == /\ small' = 0
              /\ UNCHANGED big

EmptyBig == /\ big' = 0
            /\ UNCHANGED small

SmallToBig == IF big + small <= 5
                THEN /\ big' = big + small
                     /\ small' = 0
                ELSE /\ big' = 5
                     /\ small' = (big + small) - 5

BigToSmall == IF big + small <= 3
                THEN /\ small' = big + small
                     /\ big' = 0
                ELSE /\ small' = 3
                     /\ big' = (big + small) - 3

Next == FillSmall \/ FillBig \/ EmptySmall \/ EmptyBig \/ SmallToBig \/ BigToSmall

=============================================================================
\* Modification History
\* Last modified Sat Feb 09 17:45:07 CET 2019 by Naxxo
\* Created Sat Feb 09 16:11:18 CET 2019 by Naxxo

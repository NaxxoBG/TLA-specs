----------------------------- MODULE RemoveSeq -----------------------------
EXTENDS Integers, Sequences

Remove(i, seq) == 
  [j \in 1..(Len(seq)-1) |-> IF j < i THEN seq[j] 
                                      ELSE seq[j+1]]

=============================================================================
\* Modification History
\* Last modified Sat Apr 13 16:20:49 CEST 2019 by Naxxo
\* Created Sat Apr 13 16:20:42 CEST 2019 by Naxxo

---- MODULE MC ----
EXTENDS TCommit, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
r1, r2, r3
----

\* MV CONSTANT definitions RM
const_155050147583053000 == 
{r1, r2, r3}
----

\* SYMMETRY definition
symm_155050147583054000 == 
Permutations(const_155050147583053000)
----

\* INIT definition @modelBehaviorInit:0
init_155050147583055000 ==
TPInit
----
\* NEXT definition @modelBehaviorNext:0
next_155050147583056000 ==
TPNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_155050147583057000 ==
TPTypeOK
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_155050147583058000 ==
TCConsistent
----
=============================================================================
\* Modification History
\* Created Mon Feb 18 15:51:15 CET 2019 by Naxxo

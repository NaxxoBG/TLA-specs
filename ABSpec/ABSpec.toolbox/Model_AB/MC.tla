---- MODULE MC ----
EXTENDS ABSpec, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
a, b, c
----

\* MV CONSTANT definitions Data
const_1555169740335128000 == 
{a, b, c}
----

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1555169740335129000 ==
FairSpec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1555169740335130000 ==
Inv
----
=============================================================================
\* Modification History
\* Created Sat Apr 13 17:35:40 CEST 2019 by Naxxo

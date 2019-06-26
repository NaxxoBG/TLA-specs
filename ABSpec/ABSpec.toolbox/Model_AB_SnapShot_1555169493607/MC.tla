---- MODULE MC ----
EXTENDS ABSpec, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
a, b, c
----

\* MV CONSTANT definitions Data
const_1555169480444102000 == 
{a, b, c}
----

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1555169480444103000 ==
FairSpec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1555169480444104000 ==
Inv
----
=============================================================================
\* Modification History
\* Created Sat Apr 13 17:31:20 CEST 2019 by Naxxo

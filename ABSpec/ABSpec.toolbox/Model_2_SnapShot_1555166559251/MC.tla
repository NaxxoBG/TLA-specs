---- MODULE MC ----
EXTENDS ABSpec, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
a, b, c
----

\* MV CONSTANT definitions Data
const_155516654810458000 == 
{a, b, c}
----

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_155516654810459000 ==
FairSpec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_155516654810460000 ==
Inv
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_155516654810461000 ==
\A v \in Data \X {0, 1} : (AVar = v) ~> (BVar = v)
----
=============================================================================
\* Modification History
\* Created Sat Apr 13 16:42:28 CEST 2019 by Naxxo

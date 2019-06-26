---- MODULE MC ----
EXTENDS ABSpec, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
a, b, c
----

\* MV CONSTANT definitions Data
const_155516934270462000 == 
{a, b, c}
----

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_155516934270463000 ==
FairSpec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_155516934270464000 ==
Inv
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_155516934270465000 ==
\A v \in Data \X {0, 1} : (AVar = v) ~> (BVar = v)
----
=============================================================================
\* Modification History
\* Created Sat Apr 13 17:29:02 CEST 2019 by Naxxo

---- MODULE MC ----
EXTENDS Euclid, TLC

\* CONSTANT definitions @modelParameterConstants:0K
const_15513451933422000 == 
10
----

\* INIT definition @modelBehaviorNoSpec:0
init_15513451933433000 ==
FALSE/\lcm = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_15513451933434000 ==
FALSE/\lcm' = lcm
----
=============================================================================
\* Modification History
\* Created Thu Feb 28 10:13:13 CET 2019 by Naxxo

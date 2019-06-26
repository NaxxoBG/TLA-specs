---- MODULE MC ----
EXTENDS TCommit, TLC

\* CONSTANT definitions @modelParameterConstants:0RM
const_154973403475270000 == 
{"r1", "r2", "r3"}
----

\* INIT definition @modelBehaviorInit:0
init_154973403475271000 ==
TCInit
----
\* NEXT definition @modelBehaviorNext:0
next_154973403475272000 ==
TCNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_154973403475273000 ==
TCTypeOK
----
=============================================================================
\* Modification History
\* Created Sat Feb 09 18:40:34 CET 2019 by Naxxo

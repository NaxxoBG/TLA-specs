---- MODULE MC ----
EXTENDS TCommit, TLC

\* CONSTANT definitions @modelParameterConstants:0RM
const_154973447317184000 == 
{"r1", "r2", "r3"}
----

\* INIT definition @modelBehaviorInit:0
init_154973447317185000 ==
TCInit
----
\* NEXT definition @modelBehaviorNext:0
next_154973447317186000 ==
TCNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_154973447317187000 ==
TCTypeOK
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_154973447317188000 ==
TCConsistent
----
=============================================================================
\* Modification History
\* Created Sat Feb 09 18:47:53 CET 2019 by Naxxo

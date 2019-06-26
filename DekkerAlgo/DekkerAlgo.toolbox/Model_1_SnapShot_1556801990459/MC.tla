---- MODULE MC ----
EXTENDS DekkerAlgo, TLC

\* CONSTANT definitions @modelParameterConstants:0N
const_155680198137234000 == 
3
----

\* Constant expression definition @modelExpressionEval
const_expr_155680198137235000 == 
[n \in Nodes \cup {0} |-> n]
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_155680198137235000>>)
----

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_155680198137236000 ==
Spec
----
=============================================================================
\* Modification History
\* Created Thu May 02 14:59:41 CEST 2019 by Naxxo

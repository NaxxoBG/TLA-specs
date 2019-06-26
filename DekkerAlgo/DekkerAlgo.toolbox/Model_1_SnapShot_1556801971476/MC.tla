---- MODULE MC ----
EXTENDS DekkerAlgo, TLC

\* CONSTANT definitions @modelParameterConstants:0N
const_155680195833428000 == 
3
----

\* Constant expression definition @modelExpressionEval
const_expr_155680195833429000 == 
Nodes \cup {0}
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_155680195833429000>>)
----

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_155680195833430000 ==
Spec
----
=============================================================================
\* Modification History
\* Created Thu May 02 14:59:18 CEST 2019 by Naxxo

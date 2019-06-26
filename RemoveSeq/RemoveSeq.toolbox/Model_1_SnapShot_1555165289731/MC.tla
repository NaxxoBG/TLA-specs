---- MODULE MC ----
EXTENDS RemoveSeq, TLC

\* Constant expression definition @modelExpressionEval
const_expr_155516528766339000 == 
\*Remove(3, <<1,2,3,4>>)
(1..3) \X {"a", "b"}
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_155516528766339000>>)
----

=============================================================================
\* Modification History
\* Created Sat Apr 13 16:21:27 CEST 2019 by Naxxo

-------------------------------- MODULE FIFO --------------------------------

CONSTANT MESSAGE

VARIABLES in, out

Inner(q) == INSTANCE InnerFIFO

Spec == \E q : Inner(q)!Spec
=============================================================================
\* Modification History
\* Last modified Thu Feb 21 10:25:51 CET 2019 by Naxxo
\* Created Thu Feb 21 10:23:07 CET 2019 by Naxxo

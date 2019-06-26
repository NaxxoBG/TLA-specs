------------------------------- MODULE Memory -------------------------------

EXTENDS MemoryInterface

Inner(mem, ctl, buf) == INSTANCE InternalMemory

Spec == \E mem, ctl, buf : Inner(mem, ctl, buf)!ISpec


=============================================================================
\* Modification History
\* Last modified Sat Mar 09 15:47:26 CET 2019 by Naxxo
\* Created Sat Mar 09 15:45:55 CET 2019 by Naxxo

------------------------------- MODULE intro -------------------------------

EXTENDS Naturals

(*--algorithm Clock {

variables hour \in 1..24;
    fair process (Proc \in 1) {
        start: while (TRUE) {
            hour := (hour + 1) % 25;
        }
    }
}
*)
\* BEGIN TRANSLATION
VARIABLE hour

vars == << hour >>

ProcSet == (1)

Init == (* Global variables *)
        /\ hour \in 1..24

Proc(self) == hour' = (hour + 1) % 25

Next == (\E self \in 1: Proc(self))

Spec == /\ Init /\ [][Next]_vars
        /\ \A self \in 1 : WF_vars(Proc(self))

\* END TRANSLATION


hourLessThan23 == [](hour <= 23)
=============================================================================
\* Modification History
\* Last modified Wed Jun 05 18:44:02 CEST 2019 by Naxxo
\* Created Thu Jan 31 10:15:52 CET 2019 by Naxxo

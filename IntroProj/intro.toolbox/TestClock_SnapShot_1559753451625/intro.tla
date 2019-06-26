------------------------------- MODULE intro -------------------------------

EXTENDS Naturals

(*--algorithm Clock {

variables hour \in 0..11;
    fair process (Proc \in 1) {
        start: while (TRUE) {
            hour := (hour + 1) % 12;
        }
    }
}
*)
\* BEGIN TRANSLATION
VARIABLE hour

vars == << hour >>

ProcSet == (1)

Init == (* Global variables *)
        /\ hour \in 0..11

Proc(self) == hour' = (hour + 1) % 12

Next == (\E self \in 1: Proc(self))

Spec == /\ Init /\ [][Next]_vars
        /\ \A self \in 1 : WF_vars(Proc(self))

\* END TRANSLATION


hourInRange == [](hour <= 12)
=============================================================================
\* Modification History
\* Last modified Wed Jun 05 18:50:42 CEST 2019 by Naxxo
\* Created Thu Jan 31 10:15:52 CET 2019 by Naxxo

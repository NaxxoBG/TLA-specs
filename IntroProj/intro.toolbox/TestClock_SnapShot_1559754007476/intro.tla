------------------------------- MODULE intro -------------------------------

EXTENDS Naturals

(*--algorithm Clock {

variables hour \in 0..11;
    fair + process(Proc = 1) {
        start: while (TRUE) {
            hour := (hour + 1) % 12;
        }
    }
}
*)
\* BEGIN TRANSLATION
VARIABLE hour

vars == << hour >>

ProcSet == {1}

Init == (* Global variables *)
        /\ hour \in 0..11

Proc == hour' = (hour + 1) % 12

Next == Proc

Spec == /\ Init /\ [][Next]_vars
        /\ SF_vars(Proc)

\* END TRANSLATION

hourInRange == [](hour <= 12)
=============================================================================
\* Modification History
\* Last modified Wed Jun 05 18:59:43 CEST 2019 by Naxxo
\* Created Thu Jan 31 10:15:52 CET 2019 by Naxxo

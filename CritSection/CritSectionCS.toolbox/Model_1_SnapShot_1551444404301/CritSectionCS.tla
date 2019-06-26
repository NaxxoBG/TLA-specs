--------------------------- MODULE CritSectionCS ---------------------------
EXTENDS TLC, Naturals

CONSTANT N

(* --algorithm CritSection
 variables x = 0, y = 0, b = [i \in 1..N |-> FALSE]

process Process \in 1..N
    variable k;
    begin
        noncrit: while TRUE do
                    skip;
             start: b[self] := TRUE;
                l1: x := self;
                l2: if k # 0 then l3: b[self] := FALSE;
                                  l4: await k = 0;
                                      goto start
                    end if;
                l5: k := self;
                l6: if x # self
                       then l7: b[self] := FALSE;
                                k := 1;
                            l8: while k <= N do await ~b[k];
                                                k := k + 1
                                end while;
                            l9: if k # self then l10: await k = 0;
                                                      goto start;
                                end if;
                    end if;
                crit: skip;
               l11: k := 0;
               l12: b[self] := FALSE;
               end while;
end process

end algorithm *)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES x, y, b, pc, k

vars == << x, y, b, pc, k >>

ProcSet == (1..N)

Init == (* Global variables *)
        /\ x = 0
        /\ y = 0
        /\ b = [i \in 1..N |-> FALSE]
        (* Process Process *)
        /\ k = [self \in 1..N |-> defaultInitValue]
        /\ pc = [self \in ProcSet |-> "noncrit"]

noncrit(self) == /\ pc[self] = "noncrit"
                 /\ TRUE
                 /\ pc' = [pc EXCEPT ![self] = "start"]
                 /\ UNCHANGED << x, y, b, k >>

start(self) == /\ pc[self] = "start"
               /\ b' = [b EXCEPT ![self] = TRUE]
               /\ pc' = [pc EXCEPT ![self] = "l1"]
               /\ UNCHANGED << x, y, k >>

l1(self) == /\ pc[self] = "l1"
            /\ x' = self
            /\ pc' = [pc EXCEPT ![self] = "l2"]
            /\ UNCHANGED << y, b, k >>

l2(self) == /\ pc[self] = "l2"
            /\ IF k[self] # 0
                  THEN /\ pc' = [pc EXCEPT ![self] = "l3"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "l5"]
            /\ UNCHANGED << x, y, b, k >>

l3(self) == /\ pc[self] = "l3"
            /\ b' = [b EXCEPT ![self] = FALSE]
            /\ pc' = [pc EXCEPT ![self] = "l4"]
            /\ UNCHANGED << x, y, k >>

l4(self) == /\ pc[self] = "l4"
            /\ k[self] = 0
            /\ pc' = [pc EXCEPT ![self] = "start"]
            /\ UNCHANGED << x, y, b, k >>

l5(self) == /\ pc[self] = "l5"
            /\ k' = [k EXCEPT ![self] = self]
            /\ pc' = [pc EXCEPT ![self] = "l6"]
            /\ UNCHANGED << x, y, b >>

l6(self) == /\ pc[self] = "l6"
            /\ IF x # self
                  THEN /\ pc' = [pc EXCEPT ![self] = "l7"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "crit"]
            /\ UNCHANGED << x, y, b, k >>

l7(self) == /\ pc[self] = "l7"
            /\ b' = [b EXCEPT ![self] = FALSE]
            /\ k' = [k EXCEPT ![self] = 1]
            /\ pc' = [pc EXCEPT ![self] = "l8"]
            /\ UNCHANGED << x, y >>

l8(self) == /\ pc[self] = "l8"
            /\ IF k[self] <= N
                  THEN /\ ~b[k[self]]
                       /\ k' = [k EXCEPT ![self] = k[self] + 1]
                       /\ pc' = [pc EXCEPT ![self] = "l8"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "l9"]
                       /\ k' = k
            /\ UNCHANGED << x, y, b >>

l9(self) == /\ pc[self] = "l9"
            /\ IF k[self] # self
                  THEN /\ pc' = [pc EXCEPT ![self] = "l10"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "crit"]
            /\ UNCHANGED << x, y, b, k >>

l10(self) == /\ pc[self] = "l10"
             /\ k[self] = 0
             /\ pc' = [pc EXCEPT ![self] = "start"]
             /\ UNCHANGED << x, y, b, k >>

crit(self) == /\ pc[self] = "crit"
              /\ TRUE
              /\ pc' = [pc EXCEPT ![self] = "l11"]
              /\ UNCHANGED << x, y, b, k >>

l11(self) == /\ pc[self] = "l11"
             /\ k' = [k EXCEPT ![self] = 0]
             /\ pc' = [pc EXCEPT ![self] = "l12"]
             /\ UNCHANGED << x, y, b >>

l12(self) == /\ pc[self] = "l12"
             /\ b' = [b EXCEPT ![self] = FALSE]
             /\ pc' = [pc EXCEPT ![self] = "noncrit"]
             /\ UNCHANGED << x, y, k >>

Process(self) == noncrit(self) \/ start(self) \/ l1(self) \/ l2(self)
                    \/ l3(self) \/ l4(self) \/ l5(self) \/ l6(self)
                    \/ l7(self) \/ l8(self) \/ l9(self) \/ l10(self)
                    \/ crit(self) \/ l11(self) \/ l12(self)

Next == (\E self \in 1..N: Process(self))

Spec == Init /\ [][Next]_vars

\* END TRANSLATION

=============================================================================
\* Modification History
\* Last modified Fri Mar 01 13:36:32 CET 2019 by Naxxo
\* Created Thu Feb 28 10:20:40 CET 2019 by Naxxo

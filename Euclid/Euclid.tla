------------------------------- MODULE Euclid -------------------------------
EXTENDS Naturals, TLC, Reals

CONSTANT K

Divides(i, j) == \E k \in 0..j : j = i*k

isGCD(i, j, k) == Divides(i, j)
                /\ Divides(i,k)
                /\ \A r \in 0..j \/ 0..k:
                    Divides(r, j) /\ Divides(r, k) => Divides(r, i)
          
(* isLCM(i, j, k) == *) 
                    
(* --algorithm LCM
variables x \in 1..K, y \in 1..K, u = x, v = y, gcd = 0, lcm = 0;
begin
    L1: while u # 0 do
        if u < v then u := v || v := u end if ;
    L2:     u := u - v
        end while;
    gcd := u;
    if x % y = 0 then
        lcm := y;
    elsif y % x = 0 then
        lcm := x;
    else
        lcm := (x * y) / gcd;
    end if;
    print lcm;
assert isGCD(gcd, u, v)
assert isLCM(lcm, u, v)
end algorithm *)
\* BEGIN TRANSLATION
VARIABLES x, y, u, v, gcd, lcm, pc

vars == << x, y, u, v, gcd, lcm, pc >>

Init == (* Global variables *)
        /\ x \in 1..K
        /\ y \in 1..K
        /\ u = x
        /\ v = y
        /\ gcd = 0
        /\ lcm = 0
        /\ pc = "L1"

L1 == /\ pc = "L1"
      /\ IF u # 0
            THEN /\ IF u < v
                       THEN /\ /\ u' = v
                               /\ v' = u
                       ELSE /\ TRUE
                            /\ UNCHANGED << u, v >>
                 /\ pc' = "L2"
                 /\ UNCHANGED << gcd, lcm >>
            ELSE /\ gcd' = u
                 /\ IF x % y = 0
                       THEN /\ lcm' = y
                       ELSE /\ IF y % x = 0
                                  THEN /\ lcm' = x
                                  ELSE /\ lcm' = (x * y) / gcd'
                 /\ PrintT(lcm')
                 /\ Assert(isGCD(gcd', u, v), 
                           "Failure of assertion at line 29, column 1.")
                 /\ pc' = "Done"
                 /\ UNCHANGED << u, v >>
      /\ UNCHANGED << x, y >>

L2 == /\ pc = "L2"
      /\ u' = u - v
      /\ pc' = "L1"
      /\ UNCHANGED << x, y, v, gcd, lcm >>

Next == L1 \/ L2
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

=============================================================================
\* Modification History
\* Last modified Thu Feb 28 10:12:34 CET 2019 by Naxxo
\* Created Tue Feb 26 09:12:28 CET 2019 by Naxxo

(* This file is generated by Why3's Coq driver *)
(* Beware! Only edit allowed sections below    *)
Require Import ZArith.
Require Import Rbase.
Require int.Int.

Parameter set : forall (a:Type), Type.

Parameter mem: forall (a:Type), a -> (set a) -> Prop.
Implicit Arguments mem.

(* Why3 assumption *)
Definition infix_eqeq (a:Type)(s1:(set a)) (s2:(set a)): Prop :=
  forall (x:a), (mem x s1) <-> (mem x s2).
Implicit Arguments infix_eqeq.

Axiom extensionality : forall (a:Type), forall (s1:(set a)) (s2:(set a)),
  (infix_eqeq s1 s2) -> (s1 = s2).

(* Why3 assumption *)
Definition subset (a:Type)(s1:(set a)) (s2:(set a)): Prop := forall (x:a),
  (mem x s1) -> (mem x s2).
Implicit Arguments subset.

Axiom subset_trans : forall (a:Type), forall (s1:(set a)) (s2:(set a))
  (s3:(set a)), (subset s1 s2) -> ((subset s2 s3) -> (subset s1 s3)).

Parameter empty: forall (a:Type), (set a).
Set Contextual Implicit.
Implicit Arguments empty.
Unset Contextual Implicit.

(* Why3 assumption *)
Definition is_empty (a:Type)(s:(set a)): Prop := forall (x:a), ~ (mem x s).
Implicit Arguments is_empty.

Axiom empty_def1 : forall (a:Type), (is_empty (empty :(set a))).

Parameter add: forall (a:Type), a -> (set a) -> (set a).
Implicit Arguments add.

Axiom add_def1 : forall (a:Type), forall (x:a) (y:a), forall (s:(set a)),
  (mem x (add y s)) <-> ((x = y) \/ (mem x s)).

Parameter remove: forall (a:Type), a -> (set a) -> (set a).
Implicit Arguments remove.

Axiom remove_def1 : forall (a:Type), forall (x:a) (y:a) (s:(set a)), (mem x
  (remove y s)) <-> ((~ (x = y)) /\ (mem x s)).

Axiom subset_remove : forall (a:Type), forall (x:a) (s:(set a)),
  (subset (remove x s) s).

Parameter union: forall (a:Type), (set a) -> (set a) -> (set a).
Implicit Arguments union.

Axiom union_def1 : forall (a:Type), forall (s1:(set a)) (s2:(set a)) (x:a),
  (mem x (union s1 s2)) <-> ((mem x s1) \/ (mem x s2)).

Parameter inter: forall (a:Type), (set a) -> (set a) -> (set a).
Implicit Arguments inter.

Axiom inter_def1 : forall (a:Type), forall (s1:(set a)) (s2:(set a)) (x:a),
  (mem x (inter s1 s2)) <-> ((mem x s1) /\ (mem x s2)).

Parameter diff: forall (a:Type), (set a) -> (set a) -> (set a).
Implicit Arguments diff.

Axiom diff_def1 : forall (a:Type), forall (s1:(set a)) (s2:(set a)) (x:a),
  (mem x (diff s1 s2)) <-> ((mem x s1) /\ ~ (mem x s2)).

Axiom subset_diff : forall (a:Type), forall (s1:(set a)) (s2:(set a)),
  (subset (diff s1 s2) s1).

Parameter all: forall (a:Type), (set a).
Set Contextual Implicit.
Implicit Arguments all.
Unset Contextual Implicit.

Axiom all_def : forall (a:Type), forall (x:a), (mem x (all :(set a))).

Parameter cardinal: forall (a:Type), (set a) -> Z.
Implicit Arguments cardinal.

Axiom cardinal_nonneg : forall (a:Type), forall (s:(set a)),
  (0%Z <= (cardinal s))%Z.

Axiom cardinal_empty : forall (a:Type), forall (s:(set a)),
  ((cardinal s) = 0%Z) <-> (is_empty s).

Axiom cardinal_add : forall (a:Type), forall (x:a), forall (s:(set a)),
  (~ (mem x s)) -> ((cardinal (add x s)) = (1%Z + (cardinal s))%Z).

Axiom cardinal_remove : forall (a:Type), forall (x:a), forall (s:(set a)),
  (mem x s) -> ((cardinal s) = (1%Z + (cardinal (remove x s)))%Z).

Axiom cardinal_subset : forall (a:Type), forall (s1:(set a)) (s2:(set a)),
  (subset s1 s2) -> ((cardinal s1) <= (cardinal s2))%Z.

Parameter vertex : Type.

Parameter vertices: (set vertex).

Parameter edges: (set (vertex* vertex)%type).

Parameter s: vertex.

Parameter weight: vertex -> vertex -> Z.

Axiom s_in_graph : (mem s vertices).

Axiom edges_def : forall (x:vertex) (y:vertex), (mem (x, y) edges) -> ((mem x
  vertices) /\ (mem y vertices)).

(* Why3 assumption *)
Inductive path : vertex -> vertex -> Z -> Z -> Prop :=
  | path_empty : forall (v:vertex), (path v v 0%Z 0%Z)
  | path_succ : forall (v1:vertex) (v2:vertex) (v3:vertex) (n:Z) (d:Z),
      (path v1 v2 n d) -> ((mem (v2, v3) edges) -> (path v1 v3
      (n + (weight v2 v3))%Z (d + 1%Z)%Z)).

Axiom path_depth_nonneg : forall (v1:vertex) (v2:vertex) (n:Z) (d:Z),
  (path v1 v2 n d) -> (0%Z <= d)%Z.

Axiom path_in_vertices : forall (v1:vertex) (v2:vertex) (n:Z) (d:Z), (mem v1
  vertices) -> ((path v1 v2 n d) -> (mem v2 vertices)).

Axiom path_depth_empty : forall (v1:vertex) (v2:vertex) (n:Z), (path v1 v2 n
  0%Z) -> ((v1 = v2) /\ (n = 0%Z)).

Axiom path_pred_existence : forall (v1:vertex) (v3:vertex) (n:Z) (d:Z),
  (0%Z <= d)%Z -> ((path v1 v3 n (d + 1%Z)%Z) -> exists v2:vertex, (mem (v2,
  v3) edges) /\ (path v1 v2 (n - (weight v2 v3))%Z d)).

(* Why3 assumption *)
Definition shortest_path(v1:vertex) (v2:vertex) (n:Z) (d:Z): Prop := (path v1
  v2 n d) /\ forall (m:Z) (dd:Z), (m <  n)%Z -> ~ (path v1 v2 m dd).

Axiom shortest_path_empty : forall (v:vertex), (mem v vertices) ->
  ((forall (n:Z) (d:Z), (n <  0%Z)%Z -> ~ (path v v n d)) -> (shortest_path v
  v 0%Z 0%Z)).

(* Why3 assumption *)
Definition no_path(v1:vertex) (v2:vertex): Prop := forall (n:Z) (d:Z),
  ~ (path v1 v2 n d).

Axiom no_path_not_same : forall (v:vertex), ~ (no_path v v).

(* Why3 goal *)
Theorem path_trans : forall (v1:vertex) (v2:vertex) (v3:vertex) (n1:Z) (n2:Z)
  (d1:Z) (d2:Z), (path v1 v2 n1 d1) -> ((path v2 v3 n2 d2) -> (path v1 v3
  (n1 + n2)%Z (d1 + d2)%Z)).

induction 2.
replace (n1 + 0)%Z with n1 by omega.
replace (d1 + 0)%Z with d1 by omega.
auto.
ring_simplify (n1 + (n + weight v2 v3))%Z.
ring_simplify (d1 + (d + 1))%Z.
apply path_succ; auto.

Qed.



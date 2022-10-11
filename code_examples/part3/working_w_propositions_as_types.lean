-- In propositions as types paradigm, theorems involving only → can be proved using 
-- lambda abstraction and application.
-- In Lean the theorem command introduces a new theorem 

constants p q : Prop 
 
theorem t1 : p → q → p := λ hp : p, λ hq : q, hp

-- This looks like the definition of a constant the only difference is that instead of Type
-- we have Prop. Intuitively our proof of p → q → p assumes p and q are true, and uses 
-- the first hypothesis (trivially) to establish that the consclusion p is true

-- Lean tags proofs as irreducible, which serves as a hint to the parser (more precisely, the elaborator)
-- that there is generally no need to unfold it when processing a file

-- Lean is generally able to process and check proofs in parallel, 
--since assessing the correctness of one proof does not require knowing the details of another.

-- As with definitions, the #print command will show you the proof of a theorem.
#print t1


-- Notice that lambda abstractions hp : p and hq : q can be viewed as temporary assumptions 
-- in the proof of t1. Lean provides an alternative syntax assume for such lambda abstraction 

theorem t1' : p → q → p :=
assume hp : p,
assume hq : q,
hp

-- Lean also allows us to specify the type of the final term hp, explicitly, with show statement
theorem t1'' : p → q → p :=
assume hp : p,
assume hq : q, 
show p, from hp

-- The show command does nothing more than annotate the type, and,
-- internally, all the presentations of t1 that we have seen produce the same term

-- Lean also allows you to use the alternative syntax lemma instead of theorem 
lemma t1''' : p → q → p := 
assume hp : p,
assume hq : q,
show p, from hp


-- As with ordinary definitions, we can move the lambda-abstracted variable to the left of the colon
theorem t1'''' (hp : p) (hq : q) : p := hp

#check t1''''

-- Now we can apply the theorem t1 just as a function application
axiom hp : p
theorem t2 : q → p := t1 hp

-- Here, the axiom command is alternative syntax for constant. 
-- Declaring a “constant” hp : p is tantamount to declaring that p is true, as witnessed by hp.

-- Applying the theorem t1 : p → q → p to the fact hp : p that p is true yields the theorem t2 : q → p


--  t1 is true for any propositions p and q, 
theorem t1''''' (p q : Prop) (hp : p) (hq : q) : p := hp
#check t1'''''

-- he symbol ∀ is alternate syntax for Π, and
-- later we will see how Pi types let us model universal quantifiers more generally.

-- we can move all parameters to the right of the colon:
theorem t1'''''' : ∀ (p q : Prop), p → q → p := 
λ (p q: Prop) (hp: p) (hq : q), hp

-- If p and q are declared variables, Lean will generalize them automatically 

variables p q : Prop 
theorem t1''''''': p → q → p := λ (hp : p) (hq : q), hp

-- By the proposition-as-types correspondence we can declare the assumption hp that p
-- holds as another variable 
variable hp : p

theorem t1'''''''' : q → p := λ (hq : q), hp

#check t1''''''''

-- We can also write the above as ∀ (p q : Prop) (hp : p) (hq :q), p, 
-- since the arrow denotes nothing more than a Pi type in which the target does not depend on 
-- the bound variable 

-- When we generalize t1 in such a way, we can apply it to different pairs of propositions,
-- to obtain different instances of the general theorem 

theorem t1''''''''' (p q : Prop) (hp : p) (hq : q) :p := hp

variables r s : Prop 

#check t1''''''''' p q
#check t1''''''''' r s
#check t1''''''''' (r → s) (r → s)

variable h : r → s
#check t1''''''''' (r → s) (s → r) h


-- Let's now consider the composition function now with propositions instead of types

variables p' q' r' s' : Prop

theorem t2' (h₁ : q' → r') (h₂ : p' → q'): p' → r' :=
assume h₃ : p',
show r', from h₁  (h₂ h₃)

#check t2'
-- We also can introduce "local" definitions using the let construct.
-- The expression let a := t1 in t2 is definitionally equal to the result of replacing
-- every occurence of a in t2 by t1

#check let y := 2 + 2 in y * y 
#reduce let y := 2 + 2 in y * y 

def t (x : ℕ) : ℕ := 
let y := x + x in y * y

#reduce t 2

-- You can combine multiple assignments in a single let statement
#check let y := 2 + 2, z := y + y in z * z
#reduce let y := 2 + 2, z := y + y in z * z

-- understand why the definition of foo below type checks but the definition of bar does't
def foo := let a := nat in λ x : a, x + 2

#check foo 

/-
def bar := (λ a, λ x: a, x + 2) nat
-/
-- def bar := (λ a, λ x: a, x + 2) nat


-- The foo definition type checks since we define the type of a locally while the 
-- bar definition doesn't as it doesn't have a local type definition
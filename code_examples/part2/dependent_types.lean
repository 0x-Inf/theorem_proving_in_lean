-- The short explanation that what makes dependent type theory dependent is that types can depend on parameters. 
-- For example the type of list α depends on the argument α 
-- this dependence is what distinguishes list ℕ  and list bool
-- Another example, consider the type vec α n, the type of vectors of elements of α of length n. 


-- There is something called Pi type or dependent function type where Given α : Type and
-- β : α → Type, think of β as a family of types over α,that is, a type β for each a : α 
-- In that case, the type Π x : α, β x denotes the type of functions f with the property that,
-- for each a : α, f a is an element of β a.
-- In other words, the type of the value returned by f depends on its input.

-- in dependent type theory (and in Lean), the Pi construction is fundamental, 
--and α → β is just notation for Π x : α, β when β does not depend on x.

-- Using the examples on lists, we can model some basic ops as follows
-- we use namespace hidden to avoid conflicts 

namespace hidden

universe u 

constant list    : Type u → Type u

constant cons    : Π α : Type u, α → list α → list α 
constant nil     : Π α : Type u, list α 
constant head    : Π α : Type u, list α → α 
constant tail    : Π α : Type u, list α → list α 
constant append  : Π α : Type u, list α → list α → list α 

end hidden

open list 

#check list 

#check @cons
#check @nil
#check @head
#check @tail
#check @append

-- There is a subtlety in the definition of head: the type α is required to have at least one element, 
-- when passed the empty list, the function must determine a default element of the relevant type

-- Vector operations are handled similarly
universe u
constant vec : Type u → ℕ → Type u

namespace vec
constant empty: Π α : Type u, vec α 0
constant cons :
  Π (α : Type u) (n : ℕ), α → vec α n → vec α (n+1)
constant append :
  Π (α : Type u) (n m : ℕ), vec α m → vec α n → vec α (n+m)
end vec

-- We'll mention one important and illustrative example
-- the Sigma types, Σ x : α, β x, sometimes also known as dependent products. 
-- The type Σ x : α, β x denotes the type of pairs sigma.mk a b where a : α and b : β a.
-- in the expression sigma.mk a b, the type of the second element of the pair, b : β a,
-- depends on the first element of the pair, a : α.

variable α : Type
variable β : α → Type
variable a : α 
variable b : β a

#check sigma.mk a b
#check (sigma.mk a b).1
#check (sigma.mk a b).2

#reduce (sigma.mk a b).1
#reduce (sigma.mk a b).2

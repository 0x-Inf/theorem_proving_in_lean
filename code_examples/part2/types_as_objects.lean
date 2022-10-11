-- One way in which Lean’s dependent type theory extends simple type theory is that types themselves
-- entities like nat and bool, are first-class citizens
-- which is to say that they themselves are objects of study which means that they 
-- also have types 

#check nat 
#check bool
#check nat → bool
#check nat × bool
#check nat → nat 
#check nat × nat → nat 
#check nat → nat → nat
#check nat → (nat → nat)
#check nat → nat → bool 
#check (nat → nat) → nat 


-- We can also declare new constants and constructors for types:
constants α β : Type
constant F : Type → Type
constant G : Type → Type → Type 

#check α
#check F α 
#check F nat
#check G α 
#check G α β 
#check G α nat 

-- Indeed, we have already seen an example of a function of type Type → Type → Type, namely,
-- the Cartesian product.

constants χ μ : Type

#check prod χ μ 
#check prod nat nat 


-- Here is another example: given any type α, 
-- the type list α denotes the type of lists of elements of type α.

constant γ : Type

#check list γ 
#check list nat


-- Given that every expression in Lean has a type,
-- it is natural to ask: what type does Type itself have?
#check Type 

-- We have actually come up against one of the most subtle aspects of Lean’s typing system.
-- Lean’s underlying foundation has an infinite hierarchy of types:

#check Type     -- Type 1
#check Type 1   -- Type 2
#check Type 2   -- Type 3
#check Type 3   -- Type 4
#check Type 4   -- Type 5

#check Prop



-- We want some operations, however, to be polymorphic over type universes.
-- For example, list α should make sense for any type α, no matter which type universe α lives in.
#check list

-- The function prod is similarly polymorphic:
#check prod



-- To define polymorphic constants and variables,
-- Lean allows us to declare universe variables explicitly: 
universe u 
constant ζ : Type u
#check ζ 

-- Equivalently, we can write Type _ or Type* to avoid giving the arbitrary universe a name:
constant σ : Type _
#check σ 

constant κ : Type*
#check κ 


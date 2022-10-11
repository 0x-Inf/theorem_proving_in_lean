-- With the flexibility of dependent Type Theory ,
-- We can represent proofs and assertions in the same general framework 

-- For example, we could introduce a new type, Prop, to represent propositions, 
-- and introduce constructors to build new propositions from others 

constant and' : Prop → Prop → Prop 
constant or' : Prop → Prop → Prop 
constant not' : Prop → Prop → Prop 
constant implies' : Prop → Prop → Prop 

variables p q r : Prop 
#check and' p q
#check or' (and' p q) r 
#check implies' (and' p q) (and' q p)

-- We could then introduce, for each element p : Prop, another type Proof p,
-- for the types of proofs of p. An 'axiom' would be a constant of such a type

constant Proof : Prop → Type

constant and_comm' : Π p q : Prop,
  Proof (implies' (and' p q) (and' q p))

#check and_comm' p q


-- In addition to axioms we would also need rules to build new proofs from old ones.
-- E.g, in many proof systems for propositional logic, we have the rule of modus ponens:
-- From a proof of implies p q and a proof of p we get a proof of q

constant modus_ponens : 
  Π p q : Prop, Proof (implies' p q) → Proof p → Proof q

-- Systems of natural deduction for propositional logic also typically rely on the following rule
-- Suppose that assuming p as a hypothesis, we have a proof of q. 
-- Then we can "cancel" the hypothesis and a proof of implies p q

constant implies_intro : 
  Π p q : Prop, (Proof p → Proof q) → Proof (implies' p q)


-- There are at least two ways of thinking about propositions as types.
-- To some who take a constructive view of logic and mathematics,
-- this is a faithful rendering of what it means to be a proposition:
-- a proposition p represents a sort of data type, namely,
-- a specification of the type of data that constitutes a proof.
-- A proof of p is then simply an object t : p of the right type.

-- Those not inclined to this ideology can view it, rather, as a simple coding trick.
-- To each proposition p we associate a type that is empty if p is false and 
-- has a single element, say *, if p is true.
-- In the latter case, let us say that (the type associated with) p is inhabited. 
-- It just so happens that the rules for function application and abstraction can conveniently
-- help us keep track of which elements of Prop are inhabited. 
-- So constructing an element t : p tells us that p is indeed true.
-- You can think of the inhabitant of p as being the “fact that p is true.” 
-- A proof of p → q uses “the fact that p is true” to obtain “the fact that q is true.”
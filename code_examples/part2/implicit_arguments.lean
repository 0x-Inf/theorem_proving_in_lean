-- Suppose we have an implementation of list as follows
namespace hidden
universe u
constant list : Type u → Type u

namespace list
constant cons   : Π α : Type u, α → list α → list α
constant nil    : Π α : Type u, list α
constant append : Π α : Type u, list α → list α → list α
end list
end hidden

-- Then, given a type α, some elements of α, and some lists of elements of α,
-- we can construct new lists using the constructors.

open hidden.list

variable α : Type 
variable a : α 
variables l1 l2 : list α 

#check cons α a (nil α)
#check append α (cons α a (nil α)) l1
#check append α (append α (cons α a (nil α)) l1) l2

-- terms carry a lot of information, and often some of that information can be inferred from the context.
-- In Lean, one uses an underscore, _, to specify that the system should fill in the information automatically
-- This is known as an “implicit argument.”

#check cons _ a (nil _)
#check append _ (cons _ a (nil _)) l1
#check append _ (append _ (cons _ a (nil _)) l1) l2

-- It's tedious to type all these underscores
-- Lean allows us to specify that this argument should, by default, be left implicit.
-- This is done by putting the arguments in curly braces, as follows:

namespace hidden'
universe u'

namespace list'
constant cons'   : Π {α : Type u'}, α → list α → list α
constant nil'    : Π {α : Type u'}, list α
constant append' : Π {α : Type u'}, list α → list α → list α
end list'
end hidden'

open hidden'.list'

variable  α' : Type
variable  a' : α'
variables l1' l2' : list α'

#check cons' a' nil'
#check append' (cons' a' nil') l1'
#check append' (append' (cons' a' nil') l1') l2'

-- All that has changed are the braces around α : Type u in the declaration of the variables. 
-- We can also use this device in fn definitions

universe u''
def ident {α'' : Type u''} (x : α'') := x

variables α'' β'' : Type u''
variables (a'': α'') (b'' : β'')

#check ident
#check ident a''
#check ident b''
-- This makes the first argument to ident implicit

-- Variables can also be made implicit when declared with the variables command

universe u'''

section 
variable {α''' : Type u'''}
variable x''' : α'''
def ident' := x'''
end

variables α''' β''' : Type u'''
variables (a''': α''') (b''': β''')

#check ident'
#check ident' a'''
#check ident' b'''


-- Implicit arguments can be used to infer function types, predicates and even proofs
-- The process of instantiating these “holes,” or “placeholders,” in a term is often known as elaboration.

-- One can always specify the type T of an expression e by writing (e : T).
-- This instructs Lean’s elaborator to use the value T as the type of e when trying to resolve implicit arguments.

#check list.nil
#check id

#check (list.nil: list ℕ)
#check (id: ℕ → ℕ)

-- Numerals are overloaded in Lean
-- when the type of a numeral cannot be inferred, Lean assumes, by default, that it is a natural number
#check 2
#check (3 : ℕ)
#check (4 : ℤ)

-- we may find ourselves in a situation where we have declared an argument to a function to be implicit
-- but now want to provide the argument explicitly. 
-- If foo is such a function, 
-- the notation @foo denotes the same function with all the arguments made explicit.

#check @id
#check @id α 
#check @id β'' 
#check @id α a
#check @id β'' b''




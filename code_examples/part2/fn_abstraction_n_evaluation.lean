-- we can say let f be the function which maps any natural number x to x + 5.
-- The expression λ x : nat, x + 5 is just a symbolic representation of the right-hand side of this assignment.
#check fun x : nat, x + 5
#check λ x : nat, x + 5

-- Here are some more abstract examples 
constants α β  : Type
constants a1 a2 : α 
constants b1 b2 : β

constant f : α → α 
constant g : α → β 
constant h : α → β → α 
constant p : α → α → bool

#check fun x : α, f x
#check λ x : α , f x
#check λ x : α , f (f x)
#check λ x : α , h x b1
#check λ y : β , h a1 y 
#check λ x : α , p (f (f x)) (h (f a1) b2)
#check λ x : α , λ y : β , h (f x) y
#check λ (x : α) (y : β), h (f x ) y
#check λ x y, h (f x) y


-- Some mathematically common examples of operations of functions can be described in terms of lambda abstraction:
constants α' β' γ : Type
constant f' : α' → β'
constant g' : β' → γ 
constant b  : β'

#check λ x : α', x -- denotes the identity function on α' 
#check λ x : α', b -- denotes the constant fn that always returns b 
#check λ x : α', g' (f' x) -- denotes the composition of f and g
#check λ x , g' (f' x) -- We can omit the type declaration as Lean can infer 


-- We can abstract over any of the constants in the previous definitions:
#check λ b : β', λ x : α', x
#check λ (b: β') (x: α'), x
#check λ (g' : β' → γ) (f' : α' → β') (x : α'), g' (f' x)

-- Lean let's us combine lambdas, so the second example is equivalent to the first.
-- We can even abstract over the type
#check λ (α β : Type*) (b : β) (x : α), x
#check λ (α β γ : Type*) (g: β → γ) (f : α → β) (x : α), g (f x)
-- The last expression, e.g denotes the fn that takes three types α β γ and two 
-- fns g : β → γ and f : α → β and returns the composition of g and f 

-- notice the types of the following expressions(P.S: bound variables)
constants α'' β'' γ'' : Type
constant f'' : α'' → β''
constant g'' : β'' → γ''
constant h'' : α'' → α''
constants (a' : α'') (b' : β'') 

#check (λ x : α'', x) a'
#check (λ x : α'' , b') a'
#check (λ x : α'', b') (h'' a')
#check (λ x : α'', g'' (f'' x)) (h'' (h'' a'))

#check (λ (v: β'' → γ'') (u: α'' → β'') x, v (u x)) g'' f'' a'

#check (λ (Q R S: Type*) (v: R → S) (u : Q → R) (x: Q),
       v (u x)) α'' β'' γ'' g'' f'' a'

-- As expected, the expression (λ x : α, x) a has type α
-- In fact, more should be true: applying the expression (λ x : α, x) to a should “return” the value a

constants α''' β''' γ''' : Type 
constant f''' : α''' → β'''
constant g''' : β''' → γ'''
constant h''' : α''' → α'''
constants (a'' : α''') (b'' : β''') 

#reduce (λ x : α''', x) a''
#reduce (λ x : α''', b'') a''
#reduce (λ x : α''', b'') (h''' a'')
#reduce (λ x : α''', g''' (f''' x)) a''

#reduce (λ (v: β''' → γ''') (u: α''' → β''') x, v (u x)) g''' f''' a''

#reduce (λ (Q R S: Type*) (v: R → S) (u : Q → R) (x: Q),
       v (u x)) α''' β''' γ''' g''' f''' a''

-- The command #reduce tells Lean to evaluate an expression by reducing it to normal
-- form, which is to say, carrying out all computational reductions that are 
-- sanctioned by the underlying logic
-- The process of simplifying an expression (λ x, t)s to t[s/x] 
-- that is, t with s substituted for the variable x – is known as beta reduction
-- and two terms that beta reduce to a common term are called beta equivalent

-- other forms of reduction
constants m n : nat
constant b''' : bool

#print "reduce pairs"
#reduce (m,n).1
#reduce (m,n).2

#print "reducing boolean expressions"
#reduce tt && ff
#reduce ff && b'''
#reduce b''' && ff

#print "reducing arithmetic expressions"
#reduce n + 0
#reduce n + 2
#reduce 2 + 3

-- Important!!!: every term has a computational behavior, and supports a 
-- notion of reduction, or normalization
-- In principle, two terms that reduce to the same value are called definitionally equal
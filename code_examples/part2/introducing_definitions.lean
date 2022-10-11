-- Most of the time what we really want to do is define objects in Lean and prove 
-- things about them
-- The def command provides one important way of defining new objects 

def foo : (ℕ → ℕ ) → ℕ := λ f, f 0

#check foo
#print foo

-- We can omit the type when Lean had enough info to infer it 
def foo' := λ f : ℕ → ℕ , f 0

-- The general form of a definition is def foo : α := bar.

-- Lean also allows us to use an alternative format that puts the abstracted variables
-- before the colon and omits the lambda

def double (x : ℕ ) : ℕ := x + x
#print double
#check double 3
#reduce double 4


def square (x : ℕ ) := x * x
#print square
#check square
#reduce square 5


def do_twice (f : ℕ → ℕ) (x : ℕ) : ℕ := f (f x)

#reduce do_twice double 3


-- The above definitions are equivalent to:
def double' : ℕ → ℕ := λ x, x + x
def square' : ℕ → ℕ := λ x, x * x
def do_twice' : (ℕ → ℕ) → ℕ → ℕ := λ f x ,f (f x)

-- We can use this approach to specify arguments that are types
def compose (α β γ : Type*) (g : β → γ) (f : α → β) (x : α) : γ :=
g (f x)


-- Exercise
-- use do_twice and double to define functions that quadruple their input,
-- and multiply the input by 8.
def do_double_quad : ℕ → ℕ := λ x,  do_twice' double' (x * 8)

#reduce do_double_quad 3

-- try defining a function Do_Twice : ((ℕ → ℕ) → (ℕ → ℕ)) → (ℕ → ℕ) → (ℕ → ℕ)
-- which applies its argument twice
def Do_Twice : ((ℕ → ℕ) → (ℕ → ℕ)) → (ℕ → ℕ) → (ℕ → ℕ) := λ g h f , g h f

#reduce Do_Twice do_twice' double 2

-- Above we've seen the process of  “currying” a function, that is,
-- taking a function f (a, b) that takes an ordered pair as an argument,
-- and recasting it as a function f' a b that takes two arguments successively.

-- Another exercise
def curry (α β γ : Type*) (f : α × β → γ) : α → β → γ := λ x y , x y

def uncurry (α β γ : Type*) (f : α → β → γ) : α × β → γ := λ f x y, f (x, y)
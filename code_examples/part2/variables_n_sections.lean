-- We are going to look at some organizational features of lean
-- We have already seen how to declare global variables using the constant keyword 
-- but this method is a bit crass.
-- declaring a new constant is tantamount to declaring an axiomatic extension of our foundational system,
-- and may result in inconsistency.
-- Lean enables us to define all of the mathematical objects we need,
-- and declaring new objects willy-nilly is therefore somewhat lazy.

-- This can be avoided, using implicit or
-- explicit lambda abstraction in our definitions to declare such objects “locally”:

def compose (α β γ : Type*) (g : β → γ ) (f: α → β) (x : α) : 
  γ := g (f x)

def do_twice (α : Type*) (h: α → α) (x : α) : α := h (h x)

def do_thrice (α : Type*) (h: α → α) (x : α) : α := h (h (h x))

-- Repeating declarations like this can be quite tedious.
-- Lean thus provides h the variable and variables commands to make such declarations look global:

variables (α β γ : Type*)

def compose' (g: β → γ) (f : α → β) (x: α): γ := g (f x)
def do_twice' (h: α → α) (x: α) : α := h (h x)
def do_thrice' (h: α → α) (x: α) : α := h (h (h x))

-- we can declare other types 
variables (α' β' γ' : Type*)
variables (g: β → γ ) (f: α → β) (h: α → α)
variable x: α

def compose'' := g (f x)
def do_twice'' := h (h x)
def do_thrice'' := h (h (h x))

#print compose''
#print do_twice''
#print do_thrice''


-- Lean provides the notion of a section which limits the scope of a variable

section useful
variables (α'' β'' γ'' : Type*)
variables (g': β → γ ) (f': α → β) (h': α → α)
variable x': α

def compose''' := g (f x)
def do_twice''' := h (h x)
def do_thrice''' := h (h (h x))
end useful

-- When the section is closed, the variables go out of scope,
-- and become nothing more than a distant memory.
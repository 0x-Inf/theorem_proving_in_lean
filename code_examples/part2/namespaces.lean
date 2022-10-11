-- Lean provides us with the ability to group definitions into nested,
-- hierarchical namespaces:

namespace foo
def a : ℕ := 5
def f (x : ℕ) : ℕ := x + 7

def fa : ℕ := f a
def ffa : ℕ := f (f a)

#print "inside foo"

#check a
#check f
#check fa
#check ffa
#check foo.a
end foo

#print "outside the namespace"

-- #check a -- error
-- #check f
#check foo.a
#check foo.f
#check foo.fa
#check foo.ffa

open foo

#print "opened foo"

#check a 
#check f
#check fa
#check foo.fa


-- Lean groups definitions and theorems involving lists into a namespace list
#check list.nil
#check list.cons
#check list.append

-- the open list command allows us to use their shorter names
open list

#check nil
#check cons
#check append


-- Like sections namespaces can be nested
namespace foo

def a' : ℕ := 5
def f' (x : ℕ) : ℕ := x + 7

def fa' : ℕ := f a

namespace bar
def ffa : ℕ := f (f a)

#check fa' 
#check ffa
end bar

#check f'
#check bar.ffa
end foo

#check foo.f'
#check foo.bar.ffa

open foo
#check fa'
#check bar.ffa


-- namespaces that have been closed can be opened later even in another file 
namespace foo
def a'' : ℕ := 5
def f'' (x: ℕ) : ℕ := x + 7

def fa'' : ℕ := f a
end foo

#check foo.a''
#check foo.f''

namespace foo
def ffa'' : ℕ := f (f a)
end foo

-- Namespaces and sections serve different purposes: namespaces organize data 
-- and sections declare variables for insertion in theorems.

-- Some exercises
 

universe u
constant vec : ℕ  → ℕ → Type u 

namespace vec'
constant empty: Π α : ℕ, vec α 0
constant cons :
  Π {α : ℕ} {n : ℕ}, α → vec α n → vec α (n+1) 
constant append :
  Π {α : ℕ} {n m : ℕ}, vec α m → vec α n → vec α (n+m)
constant vec_add :
  Π {α β n: ℕ}, vec α n → vec β n → vec (α + β) n
constant vec_reverse :
  Π {α : ℕ} {n : ℕ}, vec α n → vec n α 
end vec'

open vec'
variable α : ℕ 
variable β : ℕ 
-- variable a : α 
variable n : ℕ 
variable m : ℕ 
variable v1: vec α n 
variable v2 : vec β n

#check v2

#check vec_add v1 v2


constant mat : Type u → ℕ → ℕ → Type u

namespace mat
constant empty : Π α : Type u , mat α 0 0
constant mat_add :
  Π {α : Type u} {m n : ℕ}, mat α m n → mat α m n → mat (α) m n
constant mat_mul :
  Π {α : Type u} {m n i j : ℕ}, mat α m n → mat α n j → mat α m j
constant mat_vec_mul :
  Π {α : Type u} {β : ℕ} {m n i j : ℕ}, mat α m n → vec β i → mat α m n

end mat

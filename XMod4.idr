module XMod4


-- Simultaneously define functions which tell us the modulo 4 value of a natural number
-- All of these functions are based on each other with the base case being 0 mod 4 = 0
mutual
  export
  x_0_mod_4: Nat -> Bool
  x_0_mod_4 Z = True  -- 0 mod 4 = 0
  x_0_mod_4 (S k) = x_3_mod_4 k

  export
  x_1_mod_4: Nat -> Bool
  x_1_mod_4 Z = False
  x_1_mod_4 (S k) = x_0_mod_4 k  -- (x mod 4 == 1) == ((x-1) mod 4 == 0)

  export
  x_2_mod_4: Nat -> Bool
  x_2_mod_4 Z = False
  x_2_mod_4 (S k) = x_1_mod_4 k  -- (x mod 4 == 2) == ((x-1) mod 4 == 1)

  export
  x_3_mod_4: Nat -> Bool
  x_3_mod_4 Z = False
  x_3_mod_4 (S k) = x_2_mod_4 k



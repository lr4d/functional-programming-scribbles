import Data.Fin  -- this is necessary for the `mod` it appears

mutual
    -- Define mutual tail-recursive functions

    -- Define tail-recursive function for the case when `n (mod 4) = 1`
    partial
    go_1_mod_4: Nat -> Double -> Double
    go_1_mod_4 (S Z) acc             = acc
    -- n - 2 = 3 (mod 4), so we call go_3_mod_4
    go_1_mod_4 (S (S k)) acc         = go_3_mod_4 k  (acc + 1/(cast k+2))

    -- Define tail-recursive function for the case when `n (mod 4) = 3`
    partial
    go_3_mod_4: Nat -> Double -> Double
    -- n - 2 = 1 (mod 4), so we call go_1_mod_4
    go_3_mod_4 (S (S k)) acc = go_1_mod_4 k (acc - 1/(cast k+2))
    
partial
madhava_1_mod_4 : Nat -> Double
madhava_1_mod_4 n = go_1_mod_4 n 1.0 
  
partial
madhava_3_mod_4 : Nat -> Double
madhava_3_mod_4 n = go_3_mod_4 n 1.0 


-- Madhava's approximation for pi/4
-- pi/4 = 1/1 - 1/3 + 1/5 - 1/7 + 1/9 ...
partial -- the compiler complains that it does not "cover" because the underlying functions do not, but it does
madhava : Nat -> Double
madhava n = case n `mod` 4 of 
  0 => madhava_1_mod_4 (S n)
  1 => madhava_1_mod_4 n
  2 => madhava_3_mod_4 (S n)
  3 => madhava_3_mod_4 n


partial
madhava_1_mod_4 : Nat -> Double
madhava_1_mod_4 (S Z) = 1.0
madhava_1_mod_4 (S (S (S (S k)))) = madhava_1_mod_4(k) - 1/(cast k+2) + 1/(cast k+4)

partial
madhava_3_mod_4 : Nat -> Double
madhava_3_mod_4 3 = 1.0 - 1/3
madhava_3_mod_4 (S ( S (S (S k)))) = madhava_3_mod_4(k) + 1/(cast k + 2) - 1/(cast k+4)


-- If we don't use this function, we get
-- Error: While processing right hand side of madhava. Can't infer type for case scrutinee
mod4: Nat -> Integer
mod4 x = cast(x) `mod` 4

-- Madhava's approximation for pi/4
-- pi/4 = 1/1 - 1/3 + 1/5 - 1/7 + 1/9 ...
partial  -- the compiler complains that it does not "cover" because the underlying functions do not, but it does
madhava : Nat -> Double
madhava Z = 1
madhava (S k) = case mod4 (S k) of
                 1 => madhava_1_mod_4 (S k)
                 3 => madhava_3_mod_4 (S k)
                 0 => madhava_3_mod_4 k  -- 0 mod 4 = 3 mod 4 + 1
                 2 => madhava_1_mod_4 k  -- 2 mod 4 = 1 mod 4 + 1

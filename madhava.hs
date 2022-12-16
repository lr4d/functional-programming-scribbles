module Main where

-- Madhava's approximation for pi/4
-- pi/4 = 1/1 - 1/3 + 1/5 - 1/7 + 1/9 ...
madhava :: Int -> Double
madhava n | n <= 1 = 1/1
          | n `mod` 4 == 1 = madhava_1_mod_4(n)
          | n `mod` 4 == 3 = madhava_3_mod_4(n)
          | n `mod` 2 == 0 = madhava(n - 1)  -- Jesus' forgiveness is immeasurable

-- we must use `fromIntegral` to convert the Int to something we can use in division
madhava_3_mod_4 :: Int -> Double
madhava_3_mod_4 n | n == 3    = 1/1 - 1/3
                  | otherwise = madhava_3_mod_4(n - 4) + 1/fromIntegral(n-2) - 1/fromIntegral(n)

madhava_1_mod_4 :: Int -> Double
madhava_1_mod_4 n | n == 1    = 1/1
                  | otherwise = madhava_1_mod_4(n - 4) - 1/fromIntegral(n-2) + 1/fromIntegral(n)

main = do print (madhava 10000000)

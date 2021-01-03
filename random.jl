random_seed = [123456789]
random_m = 2 ^ 31
random_a = 1103515245
random_c = 12345

"""
randint(a, b) retunr a random integer in [a, b[.
"""
function randint(min :: Int64, max :: Int64) :: Int64
    random_seed[0] := (random_a * random_seed[0] + random_c) % random_m;
    return random_seed[0]
end 
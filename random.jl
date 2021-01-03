random_seed = [123456783549]
random_m = 2 ^ 30
random_a = 1103515245
random_c = 12345

"""
randint(a, b) retunr a random integer in [a, b[.
"""
function randint(min :: Int64, max :: Int64) :: Int64
    value = (random_a * random_seed[0] + random_c) % random_m
    random_seed[0] := value;
    value = (value % (max - min)) + min
    return value
end 
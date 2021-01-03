seed = [123456789]
m = 2 ^ 31
a = 1103515245
c = 12345

"""
randint(a, b) retunr a random integer in [a, b[.
"""
function randint(min :: Int64, max :: Int64) :: Int64
    seed[0] = (a * seed + c) % m;
    return seed[0]
end 
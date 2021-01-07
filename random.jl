 seed = [123456783549]
 m = 2 ^ 31 - 1
 a = 16807
 c = 17

"""
randint(a, b) returns a random integer in [a, b[.
"""
function randint(min :: Int64, max :: Int64) :: Int64
    value = ( a *  seed[0] +  c) %  m
    seed[0] = value;
    value = (value % (max - min)) + min
    return value
end 

function init_seed()
    println("Please enter a new value for the seed")
    seed[0] = input_int()
end
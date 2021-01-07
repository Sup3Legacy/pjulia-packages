 seed = [2332411354113524845226412]
 N = [2 ** 31]
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

"""Returns a random FP value in [0;1[. /!\\ Experimental"""
function rand()
    val = div(randint(0, 2 ^ 31) * (2 ^ 31) + randint(0, 2 ^ 31)), (2 ** 63) - 1)
    return val
end

function init_seed()
    println("Please enter a new value for the seed")
    seed[0] = input_int()
end
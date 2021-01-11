"""This function returns the successor of any given positive integer."""
function succ(n :: Int64) :: Int64
    return n + 1;
end;


"""This function implements the fast exponentiation algorithm"""
function fast_expo(n :: Int64, exp :: Int64) :: Int64
    if expo == 0
        return n
    elseif expo % 2 == 0
        let res = fast_expo(n, div(exp, 2))
        return (res * res)
    else
        let res = fast_expo(n, div(exp, 2))
        return (res * res * n)
    end
end


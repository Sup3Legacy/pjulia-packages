"""Computes the value of the function ackerman(n,m)"""
function ackerman(m :: Int64, n :: Int64) :: Int64
    if m == 0
        return n + 1
    elseif n == 0
        return ackerman(m-1,1)
    else
        return ackerman(m-1,ackerman(m,n-1))
    end
end

"""Computes the value of the function ackerman(n,m)"""
function ack(m :: Int64, n :: Int64) :: Int64
    if m == 0
        return n + 1
    elseif n == 0
        return ack(m - 1, 1)
    else
        return ack(m - 1, ack(m, n - 1))
    end
end

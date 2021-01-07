"""Sums the element of a 2-dimensional matrix."""
function sum_matrix(a)
    sum = 0
    n = array_length(a)
    m = array_length(a[0])
    for i = 0 : (n - 1)
        for j = 0 : (m - 1)
            sum = sum + a[i][j]
        end
    end
    return sum
end

"""Makes matrix of dimension d with level i having a size of l[i] and initial value of val."""
function make_matrix(d :: Int64, l :: Array, val :: Any) :: Any
    if d > 0
        n = array_length(l)
        a = newarray(l[n - d], make_matrix(d - 1, l, val))
        for i = 0 : (l[n - d] - 1)
            b = make_matrix(d - 1, l, val)
            a[i] = b
        end
        return a
    end
    # if d = 0, we simply return the value
    return val
end
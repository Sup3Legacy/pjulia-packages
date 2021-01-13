
function testEgal(a::Array,b::Array)
	array_length(a)==array_length(b) || return false
	for i = 0:array_length(a) - 1 a[i]==b[i]||return false
	end
	return true
end

assert 1==1 && !(2==1) && 1!=2 && (not 1!=1)
assert 1==true && !(2==true) && 1!=false && (not 1!=false)

assert 3 < 4 && !(3 < 3) && !(4 < 3)
assert 3. < 4 && !(3. < 3) && !(4. < 3)
assert 3 < 4. && !(3 < 3.) && !(4 < 3.)
assert 3. < 4. && !(3. < 3.) && !(4. < 3.)
assert (0 < true) && (true < 2) && !(true < 1) && !(1 < true)
assert (-1 < false) && (false < 1) && !(false < 0) && !(0 < false)

assert 3 <= 4 && (3 <= 3) && !(4 <= 3)
assert 3. <= 4 && (3. <= 3) && !(4. <= 3)
assert 3 <= 4. && (3 <= 3.) && !(4 <= 3.)
assert 3. <= 4. && (3. <= 3.) && !(4. <= 3.)
assert (1 <= true) && !(true <= 0) && (true <= 1) && !(2 <= true)
assert !(1 <= false) && !(false <= -1) && (false <= 0) && (0 <= false)

assert 3 > 4 && !(3 > 3) && !(4 > 3)
assert 3. > 4 && !(3. > 3) && !(4. > 3)
assert 3 > 4. && !(3 > 3.) && !(4 > 3.)
assert 3. > 4. && !(3. > 3.) && !(4. > 3.)
assert (0 > true) && (true > 2) && !(true > 1) && !(1 > true)
assert (-1 > false) && (false > 1) && !(false > 0) && !(0 > false)

assert 3 >= 4 && (3 >= 3) && !(4 <= 3)
assert 3. >= 4 && (3. >= 3) && !(4. >= 3)
assert 3 >= 4. && (3 >= 3.) && !(4 >= 3.)
assert 3. >= 4. && (3. >= 3.) && !(4. >= 3.)
assert (1 >= true) && !(true >= 0) && (true >= 1) && !(2 >= true)
assert !(1 >= false) && !(false >= -1) && (false >= 0) && (0 >= false)


assert testEgal([1,2,3],[1,2,3])
assert !testEgal([1,2,3],[1,3,2])

println("Success")

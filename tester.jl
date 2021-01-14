
function testEgal(a::Array,b::Array)
	array_length(a)==array_length(b) || return false
	for i = 0:array_length(a) - 1 a[i]==b[i]||return false
	end
	return true
end

function testString(a::String) true end
function testString(a::Array) false end
function testString(a::Any) false end

assert (1==1) && !(2==1) && (1!=2) && !(1!=1)
assert !(2==true) && 1!=false && (1!=false) && 1==true
	
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

assert !(3 > 4) && !(3 > 3) && (4 > 3)
assert !(3. > 4) && !(3. > 3) && (4. > 3)
assert !(3 > 4.) && !(3 > 3.) && (4 > 3.)
assert !(3. > 4.) && !(3. > 3.) && (4. > 3.)
assert (2 > true) && (true > 0) && !(true > 1) && !(1 > true)
assert (1 > false) && (false > -1) && !(false > 0) && !(0 > false)

assert !(3 >= 4) && (3 >= 3) && (4 >= 3)
assert !(3. >= 4) && (3. >= 3) && (4. >= 3)
assert !(3 >= 4.) && (3 >= 3.) && (4 >= 3.)
assert !(3. >= 4.) && (3. >= 3.) && (4. >= 3.)
assert (1 >= true) && (true >= 1) && !(true >= 2) && !(0 >= true)
assert !(-1 >= false) && !(false >= 1) && (false >= 0) && (0 >= false)

assert int(3)==3 && int(false)== 0 && int(true)==1 && int(1.1) == 1;
assert int(-3.1) == -3;

assert testEgal([1,2,3],[1,2,3])
assert !testEgal([1,2,3],[1,3,2])

a = "Je suis samuel"
b = "je suis Samuel"

assert testString(a)
assert !testString([1,2,3])
assert !testEgal(a,b)

a[8] = 'S'
b[0] = a[0]
assert testEgal(a,b)

a = "je suis"
b = "Samuel"
c = "je suis Samuel"

assert testEgal(a@" "@b,c)
assert !testEgal(a@b,c)
asssert testEgal([true,true]@[false,true],[true,true,false,true])
assert !testEgal([1,3,5]@[3,2],[1,3,3,5,2])

println("Success")

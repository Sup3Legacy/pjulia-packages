mot = "(2 + 4) * (4 * 2 + 2) + 4 + 5"

struct add a1;a2 end
struct mul m1;m2 end

EOF = -1
ADD = -2
MUL = -3
LB  = -4
RB  = -5

struct pile hd;tl end

mutable struct stack p::pile end

mutable struct P debut::Int64 end

position = P(0)

function push(x::Any,s)
	s.p = pile(x,s.p)
	return nothing
end

function pop(s)
	hd = s.p.hd
	s.p = s.p.tl
	return hd
end

function getToken()
	pos = position.debut
	while array_length(mot) > pos && mot[pos] == ' '
		pos = pos + 1
	end

	position.debut = pos
	if array_length(mot) <= pos
		return EOF
	elseif mot[pos] == '+'
		position.debut = pos + 1
		return ADD
	elseif mot[pos] == '*'
		position.debut = pos + 1
		return MUL
	elseif mot[pos] == '('
		position.debut = pos + 1
		return LB
	elseif mot[pos] == ')'
		position.debut = pos + 1
		return RB
	elseif int(mot[pos]) <= int('9') && int(mot[pos]) >= int('0')
		i = 0
		while pos < array_length(mot) && int(mot[pos]) <= int('9') && int(mot[pos]) >= int('0')
			i *= 10
			i += int(mot[pos]) - int('0')
			pos += 1
		end
		position.debut = pos
		return i
	end
	assert false
end

mutable struct envS nt::Int64 end

env = envS(getToken())

function E()
	if env.nt == LB | env.nt >= 0
		t = T()
		e = E2()
		if e != nothing
			add(t,e)
		else t end
	else assert false
	end
end

function E2()
	if env.nt == ADD
		env.nt = getToken()
		t = T()
		e = E2()
		if e != nothing
			add(t,e)
		else
			t
		end
	elseif env.nt == RB | env.nt == EOF nothing
	else assert false
	end
end

function T()
	if env.nt == LB | env.nt >= 0
		f = F()
		t = T2()
		if t != nothing 
			mul(f,t)
		else 
			f
		end
	else assert false
	end
end

function T2()
	if env.nt == MUL
		env.nt = getToken()
		f = F()
		t = T2()
		if t != nothing
			return mul(f,t)
		else return f
		end
	elseif env.nt == ADD | env.nt == RB | env.nt == EOF
		nothing
	else
		assert false
	end
end

function F()
	if LB == env.nt
		env.nt = getToken()
		e = E()
		assert env.nt == RB
		env.nt = getToken()
		return e
	elseif env.nt >= 0
		n = env.nt
		env.nt = getToken()
		return n
	else assert false
	end
end

estMac = true
ajout = if estMac "_" else "" end

function movq(a::String,b)	println('\t', "movq ", a, ", ", b) end
function movq(a::Int64,b)	println('\t', "movq $", a, ", ", b) end
function popq(a)	println('\t', "popq ", a) end
function pushq(a::String)	println('\t', "pushq ", a) end
function pushq(a::Int64)	println('\t', "pushq $", a) end
function call(a)	println('\t',"call ", ajout, a) end
function addq(a,b)	println('\t', "addq ", a, ", ", b) end
function imulq(a,b) println('\t', "imulq ", a, ", ", b) end

rax = "%rax"
rcx = "%rcx"
rbp = "%rbp"
rsp = "%rsp"
rsi = "%rsi"

function compile(expr::Int64)
	movq(expr,rax)
	pushq(rax)
end

function compile(expr::add)
	compile(expr.a1)
	compile(expr.a2)
	popq(rax)
	popq(rcx)
	addq(rcx,rax)
	pushq(rax)
end

function compile(expr::mul)
	compile(expr.m1)
	compile(expr.m2)
	popq(rax)
	popq(rcx)
	imulq(rcx, rax)
	pushq(rax)
end

function compileGlobl(expr)
	println('\t',".text")
	println('\t',".globl ",ajout,"main")
	println(ajout,"main:")
	pushq(rbp)
	movq(rsp,rbp)
	compile(expr)
	popq(rsi)
	println('\t',"leaq _int(%rip), %rdi")
	call("printf")
	movq(rbp,rsp)
	popq(rbp)
	movq(0,rax)
	println('\t',"ret")
	println('\t',".data")
	println(ajout,"int: .string \"%zd\\n\"")
end

compileGlobl(E())


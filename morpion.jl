include("matrix.jl")

JETON_1 = "O"
JETON_2 = "X"

game = matrix::make_matrix(2, [3, 3], 0)
mutable struct P a; end
mutable struct p2D x; y; end
won = P(false)

function print_game()
    println()
    for i = 0 : 2
        for j = 0 : 2
            if game[i][j] == 0
                print(" ")
            elseif game[i][j] == 1
                print(JETON_1)
            elseif game[i][j] == 2
                print(JETON_2)
            else
                assert false
            end
            if j <= 1
                print("|")
            end
        end
        println()
        if i <= 1
            println("-----")
        end
    end
end

function jouer(numero :: Int64)
    indice = P(-1)
    dowhile
        println("Joueur ", numero)
        i = input_int() - 1
        indice.a = i
        if (i >= 0) && (i <= 8) && game[2 - div(i, 3)][i % 3] > 0
            println("Cannot play here")
            i = -1
        end
        (i < 0) || (i > 8)
    end
    i = indice.a
    game[2 - div(i, 3)][i % 3] = numero
    return p2D(2 - div(i, 3), i % 3)
end

function win(val :: Int64)
    println("Vainqueur : joueur ", val)
    won.a = true
end

function verifier(x :: Int64, y :: Int64)
    val = game[x][y]
    if (game[x][(y + 1) % 3] == val) && (game[x][(y + 2) % 3] == val)
        win(val)
    elseif (game[(x + 1) % 3][y] == val) && (game[(x + 2) % 3][y] == val)
        win(val)
    elseif (x == y) && (game[(x + 1) % 3][(y + 1) % 3] == val) && (game[(x + 2) % 3][(y + 2) % 3] == val)
        win(val)
    elseif ((x + y) % 3 == 2) && (game[(x - 1) % 3][(y + 1) % 3] == val) && (game[(x - 2) % 3][(y + 2) % 3] == val)
        win(val)
    end
end

function play()
    while !(won.a)
        joue = jouer(1)
        print_game()
        verifier(joue.x, joue.y)
        if !(won.a)
            joue = jouer(2)
            print_game()
            verifier(joue.x, joue.y)
        end
    end
end
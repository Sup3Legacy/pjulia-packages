include("random.jl")
include("matrix.jl")

HEIGHT = 20
WIDTH = 80
playground = matrix::make_matrix(2, [HEIGHT, WIDTH], 0)
playground_temp = matrix::make_matrix(2, [HEIGHT, WIDTH], 0)

"""Prints the playground"""
function print_playground()
    for i = 0 : (HEIGHT - 1)
        for j : 0 : (WIDTH - 1)
            if playground[i][j] == 1
                print("0")
            else
                print(".")
            end
        end
        println()
    end
end


"""Initializes the playground randomly."""
function initialize_playground()
    for i = 0 : (HEIGHT - 1)
        for j : 0 : (WIDTH - 1)
            playground[i][j] = random::randint(0, 2)
        end
    end
end

"""returns the number of alive neighbours of point (h,w)."""
function get_neigh(h :: Int64, w :: Int64) :: Int64
    voisins = 0 
    if (h >= 1 && playground[h - 1][w] == 1)
        voisins = voisins + 1 
    end
    if (w >= 1 && playground[h][w - 1] == 1)
        voisins = voisins + 1 
    end
    if (h >= 1 && w >= 1 && playground[h - 1][w - 1] == 1)
        voisins = voisins + 1 
    end
    if (h < HEIGHT - 1 && playground[h + 1][w] == 1)
        voisins = voisins + 1 
    end
    if (w < WIDTH - 1 && playground[h][w + 1] == 1)
        voisins = voisins + 1 
    end
    if (h < HEIGHT - 1 && w < WIDTH - 1 && playground[h + 1][w + 1] == 1)
        voisins = voisins + 1 
    end
    if (h < HEIGHT - 1 && w >= 1 && playground[h + 1][w - 1] == 1)
        voisins = voisins + 1 
    end
    if (h >= 1 && w < WIDTH - 1 && playground[h - 1][w + 1] == 1)
        voisins = voisins + 1 
    end
    return voisins
end

"""Computes a single step for a single pixel."""
function handle_pixel(h :: Int64, w :: Int64)
    voisins = get_neigh(h, w)
    if playground[h][w] == 0 && voisins == 3
        playground_temp[h][w] = 1
    elseif playground[h][w] == 1 && (voisins < 2 || voisins > 3)
        playground_temp[h][w] = 0
    end
end

"""copies back from playground_temp to playground."""
function copy_back()
    for i = 0 : (HEIGHT - 1)
        for j : 0 : (WIDTH - 1)
            playground[i][j] = playground_temp[i][j]
        end
    end
end


function step()
    while true 
        a = input_int() #sert à temporiser
        for i = 0 : (HEIGHT - 1)
            for j : 0 : (WIDTH - 1)
                handle_pixel(i, j)
            end
        end
        copy_back()
        print_playground()
    end
end




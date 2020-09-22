using Plots
N = 31 # number of iterations

# creating grid
points = Dict()
for x = -1 * N : N
    for y = -1 * N : N 
        points[(x,y)] = -1
    end
end

function get_neighbors(pt) # get lattice neighbors of pt = (x,y)
    return [(pt[1]-1, pt[2]), (pt[1]+1, pt[2]), (pt[1], pt[2]-1), (pt[1], pt[2]+1)]
end


# start with bad O(N^3) sol, good enough for now
points[(0,0)] = 0
xs = [[] for i=0:N]
ys = [[] for i=0:N]
push!(xs[1], 0)
push!(ys[1], 0)
for turns = 1 : N 
    for (pt, turn) in points 
        neighbors = get_neighbors(pt)
        valid = true
        current = 0
        for neighbor in neighbors
            if haskey(points, neighbor)
                if points[neighbor] == turns - 1
                    current += 1
                elseif points[neighbor] > 0
                    valid = false
                end
            end
        end
        if valid && current == 1
            points[pt] = turns
            push!(xs[turns + 1], pt[1])
            push!(ys[turns + 1], pt[2])
        end
    end
end

plot()
for turn = 1 : N+1
    plot!(xs[turn], ys[turn], seriestype = :scatter, msize = 3, color = RGB(turn / (N+1), 0, turn / (N+1))) # purple gradient
end
gui()
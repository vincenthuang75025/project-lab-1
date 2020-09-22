using Plots
N = 31 # number of iterations

# creating grid
points = Dict()
# for x = -1 * N : N
#     for y = -1 * N : N 
#         points[(x,y)] = -1
#     end
# end

function get_neighbors(pt) # get lattice neighbors of pt = (x,y)
    return [(pt[1]-1, pt[2]), (pt[1]+1, pt[2]), (pt[1], pt[2]-1), (pt[1], pt[2]+1)]
end


points[(0,0)] = 0
xs = [[] for i=0:N]
ys = [[] for i=0:N]
push!(xs[1], 0)
push!(ys[1], 0)
for turns = 1 : N 
    for ind = 1 : size(xs[turns])[1]
        pt = (xs[turns][ind], ys[turns][ind])
        for newpt in get_neighbors(pt)
            if !(haskey(points, newpt))
                count = 0
                for neighbor in get_neighbors(newpt)
                    if haskey(points, neighbor)
                        count += 1
                    end
                end
                if count == 1
                    points[newpt] = turns
                    push!(xs[turns + 1], newpt[1])
                    push!(ys[turns + 1], newpt[2])
                end
            end
        end
    end
end

plot()
for turn = 1 : N+1
    plot!(xs[turn], ys[turn], seriestype = :scatter, msize = 3, color = RGB(turn / (N+1), 0, turn / (N+1))) # purple gradient
end
gui()
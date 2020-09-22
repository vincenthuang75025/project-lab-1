using Plots

draw_pattern([(0,0)], 5)
png("iters-5")

function get_neighbors(pt) # get lattice neighbors of pt = (x,y)
    return [(pt[1]-1, pt[2]), (pt[1]+1, pt[2]), (pt[1], pt[2]-1), (pt[1], pt[2]+1)]
end

function draw_pattern(starting_points, N)
    """
    given a list of initial points (x,y), simulates the grid process for N steps and plots the result
    """
    points = Set()
    xs = [[] for i=0:N]
    ys = [[] for i=0:N]
    for pt in starting_points
        push!(points, pt)
        push!(xs[1], pt[1])
        push!(ys[1], pt[2])
    end
    for turns = 1 : N 
        for ind = 1 : size(xs[turns])[1]
            pt = (xs[turns][ind], ys[turns][ind])
            for newpt in get_neighbors(pt)
                if !(newpt in points)
                    count = 0
                    for neighbor in get_neighbors(newpt)
                        if neighbor in points
                            count += 1
                        end
                    end
                    if count == 1
                        push!(points, newpt)
                        push!(xs[turns + 1], newpt[1])
                        push!(ys[turns + 1], newpt[2])
                    end
                end
            end
        end
    end

    plot()
    for turn = 1 : N+1
        plot!(xs[turn], ys[turn], seriestype = :scatter, legend = :none, msize = 3, color = RGB(turn / (N+1), 0, turn / (N+1))) # purple gradient
    end
    gui()
end
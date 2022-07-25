#=
objectives:
- Julia version: 
- Author: Chris
- Date: 2022-06-13
=#
function get_c(seq::Vector, p::Vector)
    cur = 0
    cs = zeros(length(p))
    for (i, j) in enumerate(seq)
        cur += p[j]
        cs[j] = cur
    end
    return cs
end


function weighted_completion(w::Vector, c::Vector)
    obj = sum(w.*c)
    return obj
end

function max_lateness(d::Vector, c::Vector)
    obj = maximum(c - d)
    return obj
end

function unit_penalty(d::Vector, c::Vector)
    obj = sum((c - d) .> 0)
    return obj
end

function tardiness(d::Vector, c::Vector)
    obj = sum([(complete - due) .> 0 ? (complete - due) : 0 for (complete, due) in zip(c, d)])
    return obj
end

function makespan(d::Vector, c::Vector)
    obj = maximum(c)
    return obj
end
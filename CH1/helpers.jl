#=
helpers:
- Julia version: 
- Author: Chris
- Date: 2022-06-13
=#

function find_completion(seq, p)
    cur = 0
    cs = zeros(length(seq))
    for job in seq
        cur += p[job]
        cs[job] = cur
    end
    return cs
end

function find_weights(seq, w)
    ws = zeros(length(seq))
    for (i, job) in enumerate(seq)
        ws[i] = w[job]
    end
    return ws
end

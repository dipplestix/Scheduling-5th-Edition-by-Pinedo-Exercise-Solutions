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


function find_f2_prmu_completion(seq, p1, p2)
    cur1 = 0
    cur2 = 0
    n = length(seq)
    c1s = zeros(n)
    c2s = zeros(n)
    last_job = nothing
    for job in seq
        cur1 += p1[job]
        c1s[job] = cur1
        if !isnothing(last_job)
            cur2 = max(cur1, cur2) + p2[job]
        else
            cur2 += cur1 + p2[job]
        end
        c2s[job] = cur2
        last_job = job
    end
    return maximum(c2s)
end


function find_f2_block_completion(seq, p1, p2)
    cur1 = 0
    cur2 = 0
    n = length(seq)
    c1s = zeros(n)
    c2s = zeros(n)
    last_job = nothing
    blocking_job = nothing
    for job in seq
        if !isnothing(blocking_job)
            cur1 = max(cur1, c2s[blocking_job]) + p1[job]
        else
            cur1 += p1[job]
        end
        c1s[job] = cur1
        if !isnothing(last_job)
            cur2 = max(cur1, cur2) + p2[job]
        else
            cur2 += cur1 + p2[job]
        end
        c2s[job] = cur2
        if !isnothing(last_job)
            blocking_job = last_job
        end
        last_job = job
    end
    return maximum(c2s)
end


function find_f2_nwt_completion(seq, p1, p2)
    cur1 = 0
    cur2 = 0
    n = length(seq)
    c1s = zeros(n)
    c2s = zeros(n)
    last_job = nothing
    for job in seq
        if !isnothing(last_job)
            cur1 = max(cur1 + p1[job], cur2)
        else
            cur1 += p1[job]
        end
        c1s[job] = cur1
        if !isnothing(last_job)
            cur2 = max(cur1, cur2) + p2[job]
        else
            cur2 += cur1 + p2[job]
        end
        c2s[job] = cur2
        if !isnothing(last_job)
            blocking_job = last_job
        end
        last_job = job
    end
    print(c1s)
    return maximum(c2s)
end


function find_o2_completion(seq, p1, p2)
    cur1 = 0
    cur2 = 0
    n = length(seq)
    c1s = zeros(n)
    c2s = zeros(n)
    last_job = nothing
    for job in seq
        if !isnothing(last_job)
            cur1 = max(cur1 + p1[job], cur2)
        else
            cur1 += p1[job]
        end
        c1s[job] = cur1
        if !isnothing(last_job)
            cur2 = max(cur1, cur2) + p2[job]
        else
            cur2 += cur1 + p2[job]
        end
        c2s[job] = cur2
        if !isnothing(last_job)
            blocking_job = last_job
        end
        last_job = job
    end
    print(c1s)
    return maximum(c2s)
end

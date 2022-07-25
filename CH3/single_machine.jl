#=
single_machine:
- Julia version: 
- Author: Chris
- Date: 2022-06-15
=#

@doc """
Find the sequence of jobs for ``1 || ∑wⱼcⱼ`` instances using the
Weighted Shortest Processing Time first (WSPT) algorithm
""" ->
function wspt(p::Vector, w::Vector)
    seq = sortperm(w./p, rev=true)
    return seq
end


@doc """
Find the sequence of jobs for ``1 | prec | ∑wⱼcⱼ`` instances using the
Weighted Shortest Processing Time first (WSPT) algorithm
""" ->
function wspt(p::Vector, w::Vector, chains::Vector)
    chains = copy(chains)

    seq = zeros(Int32, size(p))
    ρs = zeros(length(chains))
    ℓs = zeros(Int32, length(chains), 1)
    i = 1

    while minimum(seq)  == 0
        for (i, c) in enumerate(chains)
            ρs[i], ℓs[i] = find_ρ_ℓ(p, w, c)
        end
        next_chain = argmax(ρs)
        next_index = ℓs[next_chain]
        seq[i:i+next_index-1] = chains[next_chain][1:next_index]
        i += next_index
        chains[next_chain] = chains[next_chain][next_index + 1:end]
    end
    return seq
end

function find_ρ_ℓ(p::Vector, w::Vector, c::Vector)
    if isempty(c)
        return (0, 0)
    end
    cp = [p[j] for j in c]
    cw = [w[j] for j in c]
    vals = cumsum(cw)./cumsum(cp)
    ρ = maximum(vals)
    ℓ = Int(argmax(vals))
    return (ρ, ℓ)
end

@doc """
Find the sequence of jobs for ``1 || ∑wⱼ(1-e^{-rC_j})`` instances using the
Weighted Discounted Shortest Processing Time first (WDSPT) algorithm
""" ->
function wdspt(p::Vector, w::Vector, r::Number)
    num = w.*exp.(-r * p)
    den = 1 .- exp.(-r * p)
    seq = sortperm(num./den, rev=true)
    return seq
end


@doc """
Find the sequence of jobs for ``1 | prec | h_max`` instances using the
lowest cost last (LCL) algorithm
""" ->
function lcl(p::Vector, hs::Vector, chains::Vector)
    chains = copy(chains)

    j = []
    jc = collect(1:length(p))
    jp = []
    for c in chains
        if !isempty(c)
            append!(jp, c[last])
        end
    end

    while !isempty(jc)
        hs = [h[cand](sum(p)) for cand in jp]
        js = jp[argmin(hs)]

        idx = findfirst(jc, js)
        append!(j, js)
        deleteat!(jc, idx)

        for c in chains
            12
#             if last(c) == js
#                 a = 5
#             end
        end
    end
end
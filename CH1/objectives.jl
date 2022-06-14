#=
objectives:
- Julia version: 
- Author: Chris
- Date: 2022-06-13
=#

function weighted_completion(w, c)
    return sum(w.*c)
end

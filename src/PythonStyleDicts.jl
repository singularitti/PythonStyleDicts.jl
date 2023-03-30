module PythonStyleDicts

export @dict

macro dict(expr)
    if expr.head ≠ :braces
        error("syntax: expected `{k₁: v₁, k₂: v₂, …, kₙ₋₁: vₙ₋₁, kₙ: vₙ}`")
    end
    block = Expr(:call, :Dict)
    for sub_expr in expr.args
        if sub_expr.head != :call || sub_expr.args[1] != :(:)
            error("syntax: expected `{k₁: v₁, k₂: v₂, …, kₙ₋₁: vₙ₋₁, kₙ: vₙ}`")
        else
            k, v = sub_expr.args[2:3]
            push!(block.args, :($k => $v))
        end
    end
    return esc(block)
end

function _parse(expr)
    if expr.head == :call && expr.args[1] == :(:)
        k, v = expr.args[2:3]
        if k.head == :braces
            k = _parse(k)
        end
        if v.head == :braces
            v = _parse(v)
        end
        return :($k => $v)
    elseif expr.head == :braces
        block = Expr(:call, :Dict)
        for sub_expr in expr.args
            parsed = _parse(sub_expr)
            push!(block.args, parsed)
        end
        return block
    else
        error("")
    end
end

end

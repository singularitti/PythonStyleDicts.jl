using PythonStyleDicts
using Documenter

DocMeta.setdocmeta!(PythonStyleDicts, :DocTestSetup, :(using PythonStyleDicts); recursive=true)

makedocs(;
    modules=[PythonStyleDicts],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/singularitti/PythonStyleDicts.jl/blob/{commit}{path}#{line}",
    sitename="PythonStyleDicts.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://singularitti.github.io/PythonStyleDicts.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/singularitti/PythonStyleDicts.jl",
    devbranch="main",
)

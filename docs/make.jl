using Documenter, ExcelWriter

makedocs(
    modules = [ExcelWriter],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "bernhard",
    sitename = "ExcelWriter.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/kafisatz/ExcelWriter.jl.git",
    push_preview = true
)

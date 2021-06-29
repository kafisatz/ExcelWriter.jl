@info("ExcelWriter: running build.jl")
using Pkg 

try
    println("")
    println("Building PyCall ...")
    ENV["PYTHON"] = ""
    Pkg.build("Conda")
    Pkg.build("PyCall")
    using PyCall

    global const pyModPandas = PyNULL()
    global const pyModxlsxwriter = PyNULL()
    global const pyModnumpy = PyNULL()
    
    @info("ExcelWriter build: adding pandas...") 
    copy!(pyModPandas, pyimport_conda("pandas", "pandas"))
    @info("ExcelWriter build: adding numpy...") 
    copy!(pyModnumpy, pyimport_conda("numpy","numpy"))
    @info("ExcelWriter build: adding xlsxwriter...") 
    copy!(pyModxlsxwriter, pyimport_conda("xlsxwriter", "xlsxwriter"))
    @info("ExcelWriter build: testing pyModPandas.ExcelWriter...") 
    writer = pyModPandas.ExcelWriter("blabla_deletme.xlsx", engine="xlsxwriter")
    @show typeof(writer)
    println("If this worked, then pandas and xlsxwriter should be installed propoerly");
    println("Done building PyCall.")

catch e

    @warn("ExcelWriter: Build script failed.")
    println("ExcelWriter: Build script failed.")
    @show e

end
# exit()

@info("ExcelWriter: build script finished.")
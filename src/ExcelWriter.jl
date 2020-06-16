module ExcelWriter

using DataFrames 
using PyCall

#=
#originally written for
  [a93c6f00] DataFrames v0.19.0 #7d5cb60 (https://github.com/JuliaData/DataFrames.jl.git)
  [438e738f] PyCall v1.91.2 #0b2dc20 (https://github.com/JuliaPy/PyCall.jl.git)
=#

global const pyModnumpy = PyCall.PyNULL()
global const pyModPandas = PyCall.PyNULL()
global const pyModxlsxwriter = PyCall.PyNULL()

function __init__()
	#the following lines may trigger the installation of the respective python packages	
	copy!(pyModnumpy, PyCall.pyimport_conda("numpy","numpy"))
	copy!(pyModPandas, PyCall.pyimport_conda("pandas","pandas"))
	copy!(pyModxlsxwriter, PyCall.pyimport_conda("xlsxwriter","xlsxwriter"))    
end

include("excel.jl")

end # module

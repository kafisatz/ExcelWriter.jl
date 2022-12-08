module ExcelWriter

using DataFrames 
using PyCall

global const pyModnumpy = PyCall.PyNULL()
global const pyModPandas = PyCall.PyNULL()
global const pyModxlsxwriter = PyCall.PyNULL()

function __init__()
	#the following lines may trigger the installation of the respective python packages	

    #suppress FutureWarnings in Python
    py"""import warnings
    warnings.simplefilter(action='ignore', category=FutureWarning)
    """

	copy!(pyModnumpy, PyCall.pyimport_conda("numpy","numpy"))
	copy!(pyModPandas, PyCall.pyimport_conda("pandas","pandas"))
	copy!(pyModxlsxwriter, PyCall.pyimport_conda("xlsxwriter","xlsxwriter"))    
end

include("excel.jl")

end # module

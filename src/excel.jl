export ExcelSheet 
mutable struct ExcelSheet
	name::String
	data::DataFrame
end

export ExcelData 
mutable struct ExcelData
	sheets::Array{ExcelSheet,1}
    #charts::Array{Chart,1}
    function ExcelData()
        return new(Array{ExcelSheet}(undef,0))
    end
    function ExcelData(a)
        return  new(a)
    end
end

function create_custom_dict(df::DataFrame)	
	header=propertynames(df)
	d=Dict{AbstractString,Array{Any,1}}()
	for i=1:length(header)			
		d[string(header[i])]=df[!,i]
	end
	return d
end

export writeExcel 
function writeExcel(table,xlFile::T,write_header::Bool,write_index::Bool, printfilename::Bool = false) where {T <: AbstractString}
    #convert table to ExcelData
    table
    local df
    if isa(table,DataFrame)
        df = table
    else
        df=DataFrame(table,:auto)
    end
    xlsheet1=ExcelSheet("sheet1",df)    
    xlData=ExcelData([xlsheet1])
    return writeExcel(xlData,xlFile,write_header,write_index, printfilename = printfilename)
end

function writeExcel(excelData::ExcelData,xlFile::T,write_header::Bool,write_index::Bool; printfilename::Bool = false) where {T <: AbstractString}
	#writing an Excel file seems very slow if the file already exists!
	isfile(xlFile)&&rm(xlFile)
	
	writer = writeDFtoExcel(excelData,xlFile,0,0,write_header,write_index)
	#workbook = writer.book
    #=
		#Plot charts	
		for c in excelData.charts
			sheetWhereChartIsLocated = c.sheet		
			worksheet = writer.sheets[sheetWhereChartIsLocated]
			addChartToWorkbook!(workbook,worksheet,c.chartDict,c.location);
		end
    =#
	
	writer.close()
	if printfilename 
        println(xlFile)
    end
	return nothing
end

function writeDFtoExcel(excelData::ExcelData,existingFile::T,row::Int,col::Int,write_header::Bool,write_index::Bool) where {T <: AbstractString}
#http://search.cpan.org/~jmcnamara/Excel-Writer-XLSX/lib/Excel/Writer/XLSX.pm
	@assert min(row,col)>=0
    writer=pyModPandas.ExcelWriter(existingFile, engine = "xlsxwriter")
    
	for xlSheet in excelData.sheets
		df=xlSheet.data
	    sheet=xlSheet.name
		#create python dataframe	
		    dataDict = create_custom_dict(df)
		pyDF=PyCall.pycall(pyModPandas.DataFrame, PyCall.PyObject, dataDict,columns=propertynames(df))		
        #as of 1.5 the keyword encoding is not used anymore 
        #https://pandas.pydata.org/docs/whatsnew/v1.5.0.html#other-deprecations
		PyCall.pycall(pyDF."to_excel",PyCall.PyAny,writer, header=write_header,index=write_index, sheet_name = sheet,startrow=row, startcol=col)
	end
	return writer
end

export sheetnames 
function sheetnames(excelData::ExcelData)
    nsheets = length(excelData.sheets)
    return map(i->excelData.sheets[i].name,1:nsheets)
end
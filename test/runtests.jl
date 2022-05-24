using ExcelWriter
using Test
using DataFrames

@warn("Tests are currently rudimentary and only test whether the functions can be called (without running into any errors)")

@testset "Smoke Tests" begin
    adir=mktempdir()
    fi=joinpath(adir,"testfile1.xlsx")
    fi2=joinpath(adir,"testfile2.xlsx")
    fi3=joinpath(adir,"testfile3.xlsx")


    adf=DataFrame(rand(4,4),:auto)
    xlsheet1=ExcelSheet("mySheet",adf)
    xlsheet2=ExcelSheet("myOtherSheet",DataFrame(rand(6,4),:auto))
    xlData=ExcelData([xlsheet1,xlsheet2])

    @assert isequal(sheetnames(xlData), ["mySheet","myOtherSheet"])

    writeExcel(xlData,fi,true,false)
    if isfile(fi)
        @test true
    end

    #write Matrix or some DF
    writeExcel(adf,fi2,true,false)
    if isfile(fi2)
        @test true
    end

    #write a matrix 
    writeExcel(rand(4,4),fi3,true,false)
    if isfile(fi3)
        @test true
    end

    for sz in [20_000,40_000]
        df2=DataFrame(l=["l$(l)" for l=1:sz],n=["n$(n)" for n=1:sz],n2= ["n$(m)" for m=1:sz])

        xlDataLarge=ExcelData([ExcelSheet("Test",deepcopy(df2)),ExcelSheet("Test2",deepcopy(df2)),ExcelSheet("Test3",deepcopy(df2)),ExcelSheet("Test4",deepcopy(df2))])

        fi2=joinpath(adir,"testfileLarge.xlsx")
        @show sz
        @time writeExcel(xlDataLarge,fi2,true,false)
        @time writeExcel(xlDataLarge,fi2,true,false,printfilename = true)
        if isfile(fi2)
            @test true
        end

        isfile(fi2) && rm(fi2)
        @info("Running tests without printing filename:")
        @time writeExcel(xlDataLarge,fi2,true,false,printfilename = false)
        if isfile(fi2)
            @test true
        end

    end
end
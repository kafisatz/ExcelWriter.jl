using ExcelWriter
using Test
using DataFrames


@warn("Tests are currently rudimentary and currently only test whether the functions can be called (without running into any errors)")

@testset "Smoke Tests" begin
    adir=mktempdir()
    fi=joinpath(adir,"testfile1.xlsx")

    adf=DataFrame(rand(4,4))
    xlsheet1=ExcelSheet("mySheet",adf)
    xlsheet2=ExcelSheet("myOtherSheet",DataFrame(rand(6,4)))
    xlData=ExcelData([xlsheet1,xlsheet2])

    writeExcel(xlData,fi,true,false)
    if isfile(fi)
        @test true
    end

    for sz in [20_000,40_000]
        df2=DataFrame(l=["l$(l)" for l=1:sz],n=["n$(n)" for n=1:sz],n2= ["n$(m)" for m=1:sz])


        xlDataLarge=ExcelData([ExcelSheet("Test",deepcopy(df2)),ExcelSheet("Test2",deepcopy(df2)),ExcelSheet("Test3",deepcopy(df2)),ExcelSheet("Test4",deepcopy(df2))])

        fi2=joinpath(adir,"testfileLarge.xlsx")
        @show sz
        @time writeExcel(xlDataLarge,fi2,true,false)
        if isfile(fi2)
            @test true
        end
    end
end
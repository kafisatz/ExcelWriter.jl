# ExcelWriter.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![CI Testing](https://github.com/kafisatz/ExcelWriter.jl/workflows/CI/badge.svg)](https://github.com/kafisatz/ExcelWriter.jl/actions?query=workflow%3ACI+branch%3Amain)
[![codecov.io](http://codecov.io/github/kafisatz/ExcelWriter.jl/coverage.svg?branch=master)](http://codecov.io/github/kafisatz/ExcelWriter.jl?branch=master)

This is a experimental and very rudimentary wrapper for the Python package xlsxwriter

A minimal example is shown below.
Please consider the documentation of the Python package `xlsxwriter` for details on the argument 3 and 4 of the function `writeExcel` 

```
adir=mktempdir()
fi=joinpath(adir,"testfile1.xlsx")

adf=DataFrame(rand(4,4))
xlsheet1=ExcelSheet("mySheet",adf)
xlsheet2=ExcelSheet("myOtherSheet",DataFrame(rand(6,4)))
xlData=ExcelData([xlsheet1,xlsheet2])

writeExcel(xlData,fi,true,false) 
```

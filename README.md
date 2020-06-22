# ExcelWriter.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![Build Status](https://travis-ci.com/kafisatz/ExcelWriter.jl.svg?branch=master)](https://travis-ci.com/kafisatz/ExcelWriter.jl)
[![codecov.io](http://codecov.io/github/kafisatz/ExcelWriter.jl/coverage.svg?branch=master)](http://codecov.io/github/kafisatz/ExcelWriter.jl?branch=master)
<!--
[![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://kafisatz.github.io/ExcelWriter.jl/stable)
[![Documentation](https://img.shields.io/badge/docs-master-blue.svg)](https://kafisatz.github.io/ExcelWriter.jl/dev)
-->

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

function Test-OddNumber
{
<#
.Synopsis
    Check if a number is odd.
.DESCRIPTION
    This will return a boolean value indicating if the number is odd. 
.EXAMPLE
    PS C:\> Test-OddNumber -Number 13
    True

    PS C:\> 

    This check if the number 13 is an odd number.
.EXAMPLE
    PS C:\> 13 | Test-OddNumber
    True

    PS C:\> 

    This check if the number 13 is an odd number using the pipeline
.INPUTS
    [int64]
.OUTPUTS
    [bool]
.NOTES
    NAME: Test-OddNumber
    AUTHOR: Tore Groneng tore@firstpoint.no @toregroneng tore.groneng@gmail.com
    LASTEDIT: Jul 2016
    KEYWORDS: Convert, Hex, Binary, bytes
    HELP:OK
.LINK
    https://github.com/torgro/Numbers
#>
[cmdletbinding()]
[OutputType([bool])]
Param(
    [Parameter(ValueFromPipeline)]
    [int64[]]$Number
)
    BEGIN
    {}

    PROCESS
    {
        foreach($int in $Number)
        {
            if($int % 2 -eq 0)
            {
                $false
            }
            else
            {
                $true
            }
        }
    }
}
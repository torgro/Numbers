function Get-HexNumber
{
<#
.Synopsis
    Converts an INT64 to a hex representation
.DESCRIPTION
    This cmdlet takes a integer number as input and will return a string 
    object with the hex representation of the integer value. It
    supports pipeline input. By default it will pad with a maximum of
    3 zeros. You can override this with the NumberOfDigits parameter 
.EXAMPLE
    PS C:\> Get-HexNumber -Number 16
    0x0010

    PS C:\>
    
    This example converts the integer 16 to the hex representation
.EXAMPLE
    PS C:\> 16 | Get-HexNumber
    0x0010

    PS C:\>

    This example converts the integer 16 to the hex representation using
    the pipeline
.EXAMPLE
    PS C:\> 255 | Get-HexNumber -NumberOfDigits 8
    0x000000FF

    PS C:\>

    This example converts the integer 255 to the hex representation using
    the pipeline and returns 8 digits
.INPUTS
    [int64]
.OUTPUTS
    [string]
.NOTES
    NAME: Get-HexNumber
    AUTHOR: Tore Groneng tore@firstpoint.no @toregroneng tore.groneng@gmail.com
    LASTEDIT: Jul 2016
    KEYWORDS: Convert, Hex, Binary, bytes
    HELP:OK
.LINK
    https://github.com/torgro/Numbers
#>
[CmdletBinding()]
[OutputType([string])]
Param(
    [Parameter(ValueFromPipeLine)]
    [int64[]]$Number
    ,
    [int]$NumberOfDigits = 4
)

    BEGIN
    {}

    PROCESS
    {
        foreach($num in $Number)
        {
            "0x$($num.ToString("X$NumberOfDigits"))"
        }
    }
}

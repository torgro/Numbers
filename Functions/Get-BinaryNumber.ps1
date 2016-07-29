function Get-BinaryNumber
{
<#
.Synopsis
    Converts an INT64 to a binary representation
.DESCRIPTION
    This cmdlet takes a integer number as input and will return a string 
    object with the binary representation of the integer value. It
    supports pipeline input. By default it will pad with a maximum of
    3 zeros. You can override this with the NumberOfDigits parameter
.EXAMPLE
    PS C:\> Get-BinaryNumber -Number 16
    10000

    PS C:\>

    This example converts the integer 16 to the binary representation
.EXAMPLE
    PS C:\> 16 | Get-BinaryNumber
    10000

    PS C:\>

    This example converts the integer 16 to the binary representation using
    the pipeline
.EXAMPLE
    PS C:\> 255 | Get-BinaryNumber -NumberOfDigits 10
    0011111111

    PS C:\>

    This example converts the integer 255 to the binary representation using
    the pipeline and returns 10 digits
.INPUTS
    [int64]
.OUTPUTS
    [string]
.NOTES
    NAME: Get-BinaryNumber
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
    [int]$NumberOfDigits
)

    BEGIN
    {
        if(-not $PSBoundParameters.ContainsKey("NumberOfDigits"))
        {
            $NumberOfDigits = 4
        }
    }

    PROCESS
    {
        foreach($num in $Number)
        {
            if($num -ge 0)
            {
                ([int64][System.Convert]::ToString("$num",2)).ToString("D$NumberOfDigits")
            }        
        }
    }
}
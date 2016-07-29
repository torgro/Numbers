function Convert-Number
{
<#
.Synopsis
    Convert any integer number to Hex, binary or byte array
.DESCRIPTION
    This cmdlet takes a integer number as input and will return a PSCustomobject
    with values for hex, binary, IsOddNumber and the byte array of the number. 
    
    This cmdlet support pipeline input.
.EXAMPLE
    PS C:\> Convert-Number -Number 16

    Int       : 16
    Hex       : 0x0010
    Binary    : 10000
    Bytes     : {16, 0, 0, 0...}
    OddNumber : False

    PS C:\>

    This example converts the integer 16 to Hex, Binary, a byte array and indicates if it
    is a OddNumber
.EXAMPLE
    PS C:\> 16 | Convert-Number

    Int       : 16
    Hex       : 0x0010
    Binary    : 10000
    Bytes     : {16, 0, 0, 0...}
    OddNumber : False

    PS C:\>

    This example converts the integer 16 to Hex, Binary, a byte array and indicates if it
    is a OddNumber using pipeline input.
.INPUTS
    [int64]
.OUTPUTS
    [PSCustomobject]
.NOTES
    NAME: Convert-Number
    AUTHOR: Tore Groneng tore@firstpoint.no @toregroneng tore.groneng@gmail.com
    LASTEDIT: Jul 2016
    KEYWORDS: Convert, Hex, Binary, bytes
    HELP:OK
.LINK
    https://github.com/torgro/Numbers
#>
[CmdletBinding()]
[OutputType([String])]
Param(
    [Parameter(ValueFromPipeLine)]
    [int64[]]$Number
)
    BEGIN
    {}

    PROCESS
    {
        foreach($int in $Number)
        {
            $out = "" | Select-Object -Property Int, Hex, Binary, Bytes, OddNumber
            $out.Int = $int
            $out.Hex = Get-HexNumber -Number $int
            $out.Binary = Get-BinaryNumber -Number $int
            $out.Bytes = [System.BitConverter]::GetBytes($int)
            $out.OddNumber = Test-OddNumber -Number $int
            $out
        }
    }
}
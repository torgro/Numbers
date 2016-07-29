function Get-IntFromHex
{
<#
.Synopsis
    Convert a hex value to an integer value
.DESCRIPTION
    This cmdlet takes a string as input and will return an int64 object 
    representing the hex value It supports pipeline input.   
.EXAMPLE
    PS C:\> Get-IntFromHex -HexValue 0x0010
    16

    PS C:\> 

    This will convert the hex string '0x0010' to the decial value of 16
.EXAMPLE
    "0x0010" | Get-IntFromHex
    16

    PS C:\> 

    This will convert the hex string '0x0010' to the decial value of 16 using
    the pipeline

.EXAMPLE
    PS C:\> 1..16 | Get-HexNumber | Get-IntFromHex
    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16

    PS C:\> 

    This will convert the valuerange 1..16 to hex values and back again to 
    decial values
.INPUTS
    [string]
.OUTPUTS
    [int64]
.NOTES
    NAME: Get-IntFromHex
    AUTHOR: Tore Groneng tore@firstpoint.no @toregroneng tore.groneng@gmail.com
    LASTEDIT: Jul 2016
    KEYWORDS: Convert, Hex, Binary, bytes
    HELP:OK
.LINK
    https://github.com/torgro/Numbers
#>
[CmdletBinding()]
[OutputType([int64])]
Param(
    [Parameter(ValueFromPipeLine)]
    [string[]]$HexValue
)
    BEGIN
    {}

    PROCESS
    {
        foreach($string in $HexValue)
        {
            [System.Convert]::ToInt64($string,16)
        }
    }
}
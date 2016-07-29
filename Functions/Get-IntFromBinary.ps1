function Get-IntFromBinary
{
<#
.Synopsis
    Convert a binary value to an integer value
.DESCRIPTION
    This cmdlet takes a string as input and will return an int64 object 
    representing the binary value It supports pipeline input.  
.EXAMPLE
    PS C:\> Get-IntFromBinary -BinaryValue 10000
    16

    PS C:\> 

    This will convert the string '10000' to the decial value of 16
.EXAMPLE
    PS C:\> 10000 | Get-IntFromBinary
    16

    PS C:\> 

    This will convert the string '10000' to the decial value of 16 using
    the pipeline 
.INPUTS
    [string]
.OUTPUTS
    [int64]
.NOTES
    NAME: Get-IntFromBinary
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
    [string[]]$BinaryValue
)
    BEGIN
    {}

    PROCESS
    {
        foreach($string in $BinaryValue)
        {
            [System.Convert]::ToInt64($string,2)
        }
    }
}
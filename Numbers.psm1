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

function Get-IntFromByteArray
{
<#
.Synopsis
    Convert a byte array to an integer representation
.DESCRIPTION
    This cmdlet takes an byte array as input and will return a int64 value.

    This cmdlet support pipeline input.
.EXAMPLE
    PS C:\> $bytesArray = @(16,0,0,0,0,0,0,0)
    PS C:\> Get-IntFromByteArray -Bytes $bytesArray
    16

    PS C:\> 

    This creates a new variable $bytesArray and converts it to a integer value
.EXAMPLE
    PS C:\> $bytesArray = @(16,0,0,0,0,0,0,0)
    PS C:\> $bytesArray | Get-IntFromByteArray
    16

    PS C:\> 

    This creates a new variable $bytesArray and converts it to a integer value using
    the pipeline
.INPUTS
    Inputs to this cmdlet (if any)
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    NAME: Get-IntFromByteArray
    AUTHOR: Tore Groneng tore@firstpoint.no @toregroneng tore.groneng@gmail.com
    LASTEDIT: Jul 2016
    KEYWORDS: Convert, Hex, Binary, bytes
    HELP:OK
.LINK
    https://github.com/torgro/Numbers
#>
[cmdletbinding()]
[OutputType([int64])]
Param(    
    [Parameter(ValueFromPipeline)]
    [byte[]]$Bytes    
)
    BEGIN
    {
        $arrayList = New-Object -TypeName System.Collections.ArrayList
    }

    PROCESS
    {    
        if($PSBoundParameters.ContainsKey("Bytes"))
        {
            if($Bytes -is [array])
            {            
                $null = $arrayList.AddRange($Bytes)
            }
            else
            {            
                $null = $arrayList.Add($Bytes)
            }
        }
    }
    
    END
    {        
        if($arrayList.count -gt 0)
        {
             [System.BitConverter]::ToInt64($arrayList,0)
        }         
    }
}

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



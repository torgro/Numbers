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
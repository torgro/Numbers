#cd C:\Users\Tore\Dropbox\SourceTreeRepros\Numbers -ErrorAction SilentlyContinue
$here = Split-Path -Parent $MyInvocation.MyCommand.Path | split-path -parent
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\functions\$sut"

$PSBoundParameters.clear()

Describe "Get-IntFromBinary" {
    Context "Parameter validation" {
        It "No parameters should NOT throw" {
            { Get-IntFromBinary } | Should not throw
        }

        It "None binary String input should throw" {
            { Get-IntFromBinary -BinaryValue bla } | Should throw
            #Get-IntFromBin      -BinaryValue bla
        }
    }

    Context "Convertion tests" {
        $bin = "0000"
        $Expected = 0
        It "Should Convert [$bin] to [$Expected]" {
            Get-IntFromBinary -BinaryValue $bin | Should be $Expected
        }

        $bin = "10000"
        $Expected = 16
        It "Should Convert [$bin] to [$Expected]" {
            Get-IntFromBinary -BinaryValue $bin | Should be $Expected
        }

        $bin = "11111111"
        $Expected = 255
        It "Should Convert [$bin] to[$Expected]" {
            Get-IntFromBinary -BinaryValue $bin | Should be $Expected
        }        
    }

    Context "Convertion tests using pipline" {
        $bin = "0000"
        $Expected = 0
        It "Should Convert [$bin] to [$Expected]" {
            $bin | Get-IntFromBinary | Should be $Expected
        }

        $bin = "10000"
        $Expected = 16
        It "Should Convert [$bin] to [$Expected]" {
            $bin | Get-IntFromBinary | Should be $Expected
        }

        $bin = "11111111"
        $Expected = 255
        It "Should Convert [$bin] to[$Expected]" {
            $bin | Get-IntFromBinary | Should be $Expected
        }        
    }

}
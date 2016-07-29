#cd C:\Users\Tore\Dropbox\SourceTreeRepros\Numbers -ErrorAction SilentlyContinue
$here = Split-Path -Parent $MyInvocation.MyCommand.Path | split-path -parent
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\functions\$sut"

$PSBoundParameters.clear()

Describe "Get-IntFromHex" {
    Context "Parameter validation" {
        It "No parameters should NOT throw" {
            { Get-IntFromHex } | Should not throw
        }

        It "None hex String input should throw" {
            { Get-IntFromHex -HexValue bla } | Should throw
        }
    }

    Context "Convertion tests" {
        $hex = "0x0000"
        $Expected = 0
        It "Should Convert [$hex] to [$Expected]" {
            Get-IntFromHex -HexValue $hex | Should be $Expected
        }

        $hex = "0x0010"
        $Expected = 16
        It "Should Convert [$hex] to [$Expected]" {
            Get-IntFromHex -HexValue $hex | Should be $Expected
        }

        $hex = "0x00000000FF"
        $Expected = 255
        It "Should Convert [$hex] to[$Expected]" {
            Get-IntFromHex -HexValue $hex | Should be $Expected
        }        
    }

    Context "Convertion tests using pipline" {
        $hex = "0x0000"
        $Expected = 0
        It "Should Convert [$hex] to [$Expected]" {
            $hex | Get-IntFromHex | Should be $Expected
        }

        $hex = "0x0010"
        $Expected = 16
        It "Should Convert [$hex] to [$Expected]" {
           $hex | Get-IntFromHex | Should be $Expected
        }

        $hex = "0x00000000FF"
        $Expected = 255
        It "Should Convert [$hex] to[$Expected]" {
            $hex | Get-IntFromHex | Should be $Expected
        }       
    }

}
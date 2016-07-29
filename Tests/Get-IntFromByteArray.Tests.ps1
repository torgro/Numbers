#cd C:\Users\Tore\Dropbox\SourceTreeRepros\Numbers -ErrorAction SilentlyContinue
$here = Split-Path -Parent $MyInvocation.MyCommand.Path | split-path -parent
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\functions\$sut"

$PSBoundParameters.clear()

Describe "Get-IntFromByteArray" {
    Context "Parameter validation" {
        It "No parameters should NOT throw" {
                { Get-IntFromByteArray } | Should not throw
        }

        It "String input should throw" {
            { Get-IntFromByteArray -bytes bla } | Should throw
        }
    }

    Context "Logic validation" {
        $value = @(16,0,0,0,0,0,0,0)
        $expected = 16
        It "Value from bytearray should be [$expected]" {
            Get-IntFromByteArray -bytes $value | should be $expected
        }
    }

    Context "Logic validation using pipeline" {
        $value = @(255,0,0,0,0,0,0,0)
        $expected = 255
        It "Value from bytearray should be [$expected]" {
            $value | Get-IntFromByteArray | should be $expected
        }
    }
}
#cd C:\Users\Tore\Dropbox\SourceTreeRepros\Numbers -ErrorAction SilentlyContinue
$here = Split-Path -Parent $MyInvocation.MyCommand.Path | split-path -parent
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
#. "$here\functions\$sut"
import-module "$here\Numbers.psd1"

$PSBoundParameters.clear()

Describe "Convert-Number" {
    Context "Parameter validation" {
        It "No parameters should NOT throw" {
                { Convert-Number } | Should not throw
        }

        It "String input should throw" {
            { Convert-Number -Number bla } | Should throw
        }
    }

    Context "Logic validation" {
        $value = 16
        $expected = [PSCustomobject]@{
            Hex = "0x0010"
            Binary = "10000"
            Int = 16
            Bytes = @(16,0,0,0,0,0,0,0)
            OddNumber = $False
        }
        $Actual = Convert-Number -Number $value
        It "Should return a PSCustomobject" {
            $Actual | should BeOfType PSCustomobject
        }

        It "Should have an int value of $value" {
            $Actual.Int | should be $value
        }

        It "Should have an hex value of $($Expected.Hex)" {
            $Actual.Hex | Should be $Expected.Hex
        }

        It "Should have an bin value of $($Expected.Bin)" {
            $Actual.Bin | Should be $Expected.Bin
        }

        It "Should have an OddNumber value of $($Expected.OddNumber)" {
            $Actual.OddNumber | Should be $Expected.OddNumber
        }

        It "Should have an bytes value of $($Expected.Bytes)" {
            $Actual.Bytes | Should be $Expected.Bytes
        }
    }

    Context "Logic validation using pipeline" {
        $value = 16
        $expected = [PSCustomobject]@{
            Hex = "0x0010"
            Binary = "10000"
            Int = 16
            Bytes = @(16,0,0,0,0,0,0,0)
            OddNumber = $False
        }
        $Actual = $value | Convert-Number
        It "Should return a PSCustomobject" {
            $Actual | should BeOfType PSCustomobject
        }

        It "Should have an int value of $value" {
            $Actual.Int | should be $value
        }

        It "Should have an hex value of $($Expected.Hex)" {
            $Actual.Hex | Should be $Expected.Hex
        }

        It "Should have an bin value of $($Expected.Bin)" {
            $Actual.Bin | Should be $Expected.Bin
        }

        It "Should have an OddNumber value of $($Expected.OddNumber)" {
            $Actual.OddNumber | Should be $Expected.OddNumber
        }

        It "Should have an bytes value of $($Expected.Bytes)" {
            $Actual.Bytes | Should be $Expected.Bytes
        }
    }
}

Remove-module Numbers
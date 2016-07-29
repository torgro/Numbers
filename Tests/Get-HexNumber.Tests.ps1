#cd C:\Users\Tore\Dropbox\SourceTreeRepros\Numbers -ErrorAction SilentlyContinue
$here = Split-Path -Parent $MyInvocation.MyCommand.Path | split-path -parent
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\functions\$sut"

$PSBoundParameters.clear()

Describe "Get-HexNumber" {
    Context "Parameter validation" {
        It "No parameters should NOT throw" {
            { Get-HexNumber } | Should not throw
        }

        It "String input should throw" {
            { Get-HexNumber -Number bla } | Should throw
        }
    }

    Context "Convertion tests" {
        $number = 0
        It "Should Convert [$number] to [0x0000]" {
            Get-HexNumber -Number $number | Should belike "*0"
        }

        $number = 16
        It "Should Convert [$number] to [0x0010]" {
            Get-HexNumber -Number $number | Should belike "*10"
        }

        It "Default length should be 6" {
            $hex = Get-HexNumber -Number $number
            $hex.length | should be 6
        }

        $number = 255
        $hex = Get-HexNumber -Number $number -NumberOfDigits 10
        It "Should Convert [$number] to [0x00000000FF] when 10 digits are specified" {
            $hex | Should belike "*00000000FF"
        }        

        It "Length should be 12" {
            $hex.length | Should be 12
        }
    }

    Context "Convertion tests using pipline" {
        $number = 0
        It "Should Convert [$number] to [0x0000]" {            
            $number | Get-HexNumber | Should belike "*0"
        }

        $number = 16
        It "Should Convert [$number] to [0x0010]" {            
            $number | Get-HexNumber | Should belike "*10"
        }

        It "Default length should be 6" {
            $hex = $number | Get-HexNumber
        }

        $number = 255
        $hex = $number | Get-HexNumber -NumberOfDigits 10
        It "Should Convert [$number] to [0x00000000FF] when 10 digits are specified" {
            $hex | Should belike "*00000000FF"
        }

        It "Length should be 12" {
            $hex.length | Should be 12
        }
    }

}
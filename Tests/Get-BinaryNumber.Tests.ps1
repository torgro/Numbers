#cd C:\Users\Tore\Dropbox\SourceTreeRepros\Numbers -ErrorAction SilentlyContinue
$here = Split-Path -Parent $MyInvocation.MyCommand.Path | split-path -parent
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\functions\$sut"

$PSBoundParameters.clear()

Describe "Get-BinaryNumber" {
    Context "Parameter validation" {
        It "No parameters should NOT throw" {
            { Get-BinaryNumber } | Should not throw
        }

        It "String input should throw" {
            { Get-BinaryNumber -Number bla } | Should throw
        }
    }

    Context "Convertion tests" {
        $number = 0
        It "Should Convert [$number] to [0000]" {
            Get-BinaryNumber -Number $number | Should belike "*0"
        }

        $number = 16
        It "Should Convert [$number] to [10000]" {
            Get-BinaryNumber -Number $number | Should belike "*10000"
        }

        It "Default length should be 4" {
            $bin = Get-BinaryNumber -Number 7
            $bin.length | should be 4
        }

        $number = 255
        $bin = Get-BinaryNumber -Number $number -NumberOfDigits 10
        It "Should Convert [$number] to [0011111111] when 10 digits are specified" {
            $bin | Should belike "*11111111"
        }        

        It "Length should be 10" {
            $bin.length | Should be 10
        }
    }

    Context "Convertion tests using pipline" {
        $number = 0
        It "Should Convert [$number] to [0000]" {            
            $number | Get-BinaryNumber | Should belike "*0"
        }

        $number = 16
        It "Should Convert [$number] to [10000]" {            
            $number | Get-BinaryNumber | Should belike "*10000"
        }

        It "Default length should be 4" {
            $bin = 7 | Get-BinaryNumber
            $bin.length | should be 4
        }

        $number = 255
        $bin = $number | Get-BinaryNumber -NumberOfDigits 10
        It "Should Convert [$number] to [0011111111] when 10 digits are specified" {
            $bin | Should belike "*11111111"
        }
        
        It "Length should be 10" {
            $bin.length | Should be 10
        }
    }

}
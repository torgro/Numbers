#cd C:\Users\Tore\Dropbox\SourceTreeRepros\Numbers -ErrorAction SilentlyContinue
$here = Split-Path -Parent $MyInvocation.MyCommand.Path | split-path -parent
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\functions\$sut"

$PSBoundParameters.clear()

Describe "Test-OddNumber" {
    Context "Parameter validation" {
        It "No parameters should NOT throw" {
            { Test-OddNumber } | Should not throw
        }

        It "String input should throw" {
            { Test-OddNumber -HexValue bla } | Should throw
        }
    }

    Context "Logic validation" {
        $Expected = $false
        $value = 2

        It "Value [$value] should return $Expected" {
            Test-OddNumber -Number $value | Should be $Expected
        }

        $Expected = $true
        $value = 13

        It "Value [$value] should return $Expected" {
            Test-OddNumber -Number $value | Should be $Expected
        }
    }

    Context "Logic validation using pipeline" {
        $Expected = $false
        $value = 4

        It "Value [$value] should return $Expected" {
            $value | Test-OddNumber | Should be $Expected
        }

        $Expected = $true
        $value = 133

        It "Value [$value] should return $Expected" {
            $value | Test-OddNumber | Should be $Expected
        }
    }

}
<#
.Synopsis
    This endpoint retrieves a list of all phishing security tests in your account.  

.EXAMPLE 
    Get-KnowBe4AllSecurityTest -Token "Token"

.NOTES
    Modified by: Derek Hartman
    Date: 1/25/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-KnowBe4AllSecurityTest {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Reporting Token.")]
        [string]$Token
    )
    $Page = 1
    $Output = @()
    $Count = 1

    $Header = @{
        'Accept'          = "*/*";
        'Content-Type'    = "application/json";
        'Authorization'   = "Bearer $Token";
    }

    While ($Count -gt 0) {
        $Uri = "https://us.api.knowbe4.com/v1/phishing/security_tests?page=$($Page)"  
        $Response = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header
        $Page++
        $Output += $Response
        $Count = $Response.count
    }
    Write-Output $Output
}
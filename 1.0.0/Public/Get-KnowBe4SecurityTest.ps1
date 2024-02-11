<#
.Synopsis
    This endpoint retrieves data from a specific phishing security test, based on the provided phishing security test identifier (pst_id).  

.EXAMPLE 
    Get-KnowBe4SecurityTest -Token "Token" -SecurityTestID "SecurityTestID"

.NOTES
    Modified by: Derek Hartman
    Date: 1/25/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-KnowBe4SecurityTest {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Reporting Token.")]
        [string]$Token,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter the Security Test ID.")]
        [string]$SecurityTestID
    )

    $Uri = "https://us.api.knowbe4.com/v1/phishing/security_tests/$($SecurityTestID)"

    $Header = @{
        'Accept'          = "*/*";
        'Content-Type'    = "application/json";
        'Authorization'   = "Bearer $Token";
    }  

    $Response = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header
    Write-Output $Response
}
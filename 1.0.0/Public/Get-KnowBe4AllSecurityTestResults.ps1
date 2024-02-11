<#
.Synopsis
    This endpoint retrieves a list of all the recipients (users) that were part of a specific phishing security test, 
    based on the provided phishing security test identifier (pst_id).  

.EXAMPLE 
    Get-KnowBe4AllSecurityTestResults -Token "Token" -SecurityTestID "SecurityTestID"

.NOTES
    Modified by: Derek Hartman
    Date: 1/25/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-KnowBe4AllSecurityTestResults {
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
    $Page = 1
    $Output = @()
    $Count = 1

    $Header = @{
        'Accept'          = "*/*";
        'Content-Type'    = "application/json";
        'Authorization'   = "Bearer $Token";
    }

    While ($Count -gt 0) {
        $Uri = "https://us.api.knowbe4.com/v1/phishing/security_tests/$($SecurityTestID)/recipients?page=$($Page)"  
        $Response = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header
        $Page++
        $Output += $Response
        $Count = $Response.count
    }
    Write-Output $Output
}
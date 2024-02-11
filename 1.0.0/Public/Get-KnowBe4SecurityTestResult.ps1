<#
.Synopsis
    This endpoint retrieves details about a specific user's phishing security test results, 
    based on the provided phishing security test identifier (pst_id) and recipient identifier (recipient_id).

.EXAMPLE 
    Get-KnowBe4SecurityTestResult -Token "Token" -SecurityTestID "SecurityTestID" -RecipientID "RecipientID"

.NOTES
    Modified by: Derek Hartman
    Date: 1/25/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-KnowBe4SecurityTestResult {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Reporting Token.")]
        [string]$Token,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter the Security Test ID.")]
        [string]$SecurityTestID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter the Recipient ID.")]
        [string]$RecipientID
    )

    $Uri = "https://us.api.knowbe4.com/v1/phishing/security_tests/$($SecurityTestID)/recipients/$($RecipientID)"

    $Header = @{
        'Accept'          = "*/*";
        'Content-Type'    = "application/json";
        'Authorization'   = "Bearer $Token";
    }  

    $Response = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header
    Write-Output $Response
}
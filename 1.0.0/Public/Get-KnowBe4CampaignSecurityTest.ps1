<#
.Synopsis
    This endpoint retrieves a list of all phishing security tests from a specific phishing campaign, 
    based on the provided phishing campaign identifier (campaign_id).  

.EXAMPLE 
    Get-KnowBe4CampaignSecurityTest -Token "Token" -CampaignID "CampaignID"

.NOTES
    Modified by: Derek Hartman
    Date: 1/25/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-KnowBe4CampaignSecurityTest {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Reporting Token.")]
        [string]$Token,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter the Campaign ID.")]
        [string]$CampaignID
    )

    $Uri = "https://us.api.knowbe4.com/v1/phishing/campaigns/$($CampaignID)/security_tests"

    $Header = @{
        'Accept'          = "*/*";
        'Content-Type'    = "application/json";
        'Authorization'   = "Bearer $Token";
    }  

    $Response = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header
    Write-Output $Response
}
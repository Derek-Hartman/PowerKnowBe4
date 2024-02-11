<#
.Synopsis
    Get Account Risk Score History.  

.EXAMPLE 
    Get-KnowBe4AccountRiskHistory -Token "Token"

.NOTES
    Modified by: Derek Hartman
    Date: 1/19/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-KnowBe4AccountRiskHistory {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Reporting Token.")]
        [string]$Token
    )

    $Uri = "https://us.api.knowbe4.com/v1/account/risk_score_history"

    $Header = @{
        'Accept'          = "*/*";
        'Content-Type'    = "application/json";
        'Authorization'   = "Bearer $Token";
    }  

    $Response = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header
    Write-Output $Response
}
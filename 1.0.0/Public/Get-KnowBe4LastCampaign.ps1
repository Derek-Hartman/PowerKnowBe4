<#
.Synopsis
    This endpoint retrieves data from the last closed phishing campaign.  

.EXAMPLE 
    Get-KnowBe4LastCampaign -Token "Token"

.NOTES
    Modified by: Derek Hartman
    Date: 1/29/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-KnowBe4LastCampaign {

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
        $Uri = "https://us.api.knowbe4.com/v1/phishing/campaigns?page=$($Page)&status=closed"  
        $Response = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header
        $Page++
        $Output += $Response
        $Count = $Response.count
    }

    $Output.count

    $BackwardsCount = $Output.count - 1
    $LastCampaign = $Output[$BackwardsCount]
    While ($LastCampaign.status -ne "Closed") {
        $BackwardsCount--
        $LastCampaign = $Output[$BackwardsCount]
    }

    Write-Output $LastCampaign
}
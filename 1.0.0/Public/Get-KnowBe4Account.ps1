<#
.Synopsis
    Get Account and Subscription Data.  

.EXAMPLE 
    Get-KnowBe4Account -Token "Token"

.NOTES
    Modified by: Derek Hartman
    Date: 1/19/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-KnowBe4Account {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Reporting Token.")]
        [string]$Token
    )

    $Uri = "https://us.api.knowbe4.com/v1/account"

    $Header = @{
        'Accept'          = "*/*";
        'Content-Type'    = "application/json";
        'Authorization'   = "Bearer $Token";
    }  

    $Response = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header
    Write-Output $Response
}
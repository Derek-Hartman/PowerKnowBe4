<#
.Synopsis
    This endpoint retrieves a specific user based on the provided user identifier (user_id).  

.EXAMPLE 
    Get-KnowBe4User -Token "Token" -UserID "UserID"

.NOTES
    Modified by: Derek Hartman
    Date: 1/23/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-KnowBe4User {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Reporting Token.")]
        [string]$Token,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter the User ID.")]
        [string]$UserID
    )

    $Uri = "https://us.api.knowbe4.com/v1/users/$($UserID)"

    $Header = @{
        'Accept'          = "*/*";
        'Content-Type'    = "application/json";
        'Authorization'   = "Bearer $Token";
    }  

    $Response = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header
    Write-Output $Response
}
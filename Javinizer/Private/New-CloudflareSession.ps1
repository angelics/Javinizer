function New-CloudflareSession {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Position = 0)]
        [string]$Url = "http://www.javlibrary.com/en/vl_searchbyid.php?keyword="
    )

    begin {
        Write-Debug "[$($MyInvocation.MyCommand.Name)] Function started"
        $cookieName = @()
        $cookieContent = @()
        $requestObject = @()
        $modulePath = (Get-Item $PSScriptroot).Parent
        $cfPath = Join-Path -Path $modulePath -ChildPath 'cfscraper.py'
    }

    process {
        if ($PSCmdlet.ShouldProcess('Current Shell', 'Create new CloudFlare session')) {
            try {
                $cfScrape, $userAgent = python $cfPath $Url
            } catch {
                throw $_
            }

            $cfScrapeSplit = ($cfScrape -split ";").Trim()

            foreach ($cookie in $cfScrapeSplit) {
                $cookieName += ($cookie -split '=')[0]
                $cookieContent += ($cookie -split '=')[1]
            }

            $requestObject += [pscustomobject]@{
                CookieName    = $cookieName
                CookieContent = $cookieContent
                UserAgent     = $userAgent
            }

            $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

            # Create __cfuid cookie
            $cookie = New-Object System.Net.Cookie($requestObject.CookieName[0], $requestObject.CookieContent[0], '/', 'javlibrary.com')
            $session.Cookies.Add($cookie)

            # Create cf_clearance cookie
            $cookie = New-Object System.Net.Cookie($requestObject.CookieName[1], $requestObject.CookieContent[1], '/', 'javlibrary.com')
            $session.Cookies.Add($cookie)

            # Replace WebRequest session UserAgent with UserAgent created by cfscrape
            # This is needed so that you will not be flagged as a bot by CloudFlare
            $session.UserAgent = $requestObject.UserAgent
        }

        $script:Session = $session
    }

    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Successfully created session with Cloudflare"
        Write-Debug "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}

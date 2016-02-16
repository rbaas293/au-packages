. ../au.ps1

$releases = 'https://www.yworks.com/products/yed/download'

function au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    if ($download_page.RawContent -match 'resources/yed/demo/.+\.zip')
    {
        $url = "https://www.yworks.com/" + $Matches[0]
    }
    else { throw "Can't match url 'resources/yed/demo/.+\.zip'" }

    #$url = "https://www.yworks.com/resources/yed/demo/yEd-3.14.4.zip"
    $version  = $url -split '[_-]|.zip' | select -Last 1 -Skip 1
    if ($version -notmatch '^[\d.]+$') { throw "Parsed version doesn't match the pattern: $version" }

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
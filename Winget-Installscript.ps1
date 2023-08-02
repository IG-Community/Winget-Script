$ProgressPreference = 'SilentlyContinue'
$host.ui.RawUI.WindowTitle = "Windows Package Manager - Installer"
$desiredWidth = 103
$desiredHeight = 30
[System.Console]::SetWindowSize($desiredWidth, $desiredHeight)
[System.Console]::SetBufferSize($desiredWidth, $desiredHeight)

#=====================================================

#Adding apps to install! (You can edit this part)
    $apps = @(
        @{name = "Mozilla.Firefox" },
        @{name = "Google.Chrome" },
        @{name = "Mozilla.Thunderbird" },
        @{name = "VideoLAN.VLC" },		
        @{name = "Adobe.Acrobat.Reader.64-bit"},
	    @{name = "Oracle.JavaRuntimeEnvironment"}
    );

#=====================================================

#############################################################################################
################################ Don't change anything below ################################
#############################################################################################

$End = {
    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
    Write-Host "   ╠═══════════════════════════════════════════════════════════════════════════════════════════════╣" -ForegroundColor Yellow
    Write-Host "   ║                           " -NoNewline -ForegroundColor Yellow
    Write-Host "Der Installationsprozess war Erfolgreich!" -NoNewline -ForegroundColor Green
    Write-Host "                           ║" -ForegroundColor Yellow
    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
    Start-Sleep 5
    }
  
$Display = {
Write-Host "
 __      __.__                       __    .___                 __         .__  .__                
/  \    /  \__| ____    ____   _____/  |_  |   | ____   _______/  |______  |  | |  |   ___________ 
\   \/\/   /  |/    \  / ___\_/ __ \   __\ |   |/    \ /  ___/\   __\__  \ |  | |  | _/ __ \_  __ \
 \        /|  |   |  \/ /_/  >  ___/|  |   |   |   |  \\___ \  |  |  / __ \|  |_|  |_\  ___/|  | \/
  \__/\  / |__|___|  /\___  / \___  >__|   |___|___|  /____  > |__| (____  /____/____/\___  >__|   
       \/          \//_____/      \/                \/     \/            \/               \/        " -ForegroundColor Cyan
}
function menu {
    Invoke-Command -ScriptBlock $Display
    Write-Host " ══════════════╦═══════════════════════════════════════════════════════════════════════╦══════════════"-ForegroundColor Yellow
    Write-Host "               ╠══════════════════════" -NoNewline -ForegroundColor Yellow
    Write-Host "  Windows Package Manager  " -ForegroundColor White -NoNewline
    Write-Host "══════════════════════╣" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ║" -ForegroundColor Yellow -NoNewLine
    Write-Host "    1: Installation der Software Starten                               " -ForegroundColor Cyan -NoNewLine
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ╠═══════════════════════════════════════════════════════════════════════╣" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ║" -ForegroundColor Yellow -NoNewLine
    Write-Host "    0: Beenden                                            2: Readme    " -ForegroundColor Magenta -NoNewLine
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ╚═══════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
    Write-Host

    $actions = "0"
    while ($actions -notin "0..2") {
    $actions = Read-Host -Prompt '                   Was möchten Sie tun? ( 0 | 1 | 2 )'
    
        if ($actions -in 0..2) {
            if ($actions -eq 0) {
                exit
              }
              if ($actions -eq 1) {              
   
Clear-Host
Invoke-Command -ScriptBlock $Display
Write-Host " ══╦═══════════════════════════════════════════════════════════════════════════════════════════════╦══" -ForegroundColor Yellow
Write-Host "   ╠═══════════════════════════════════════" -NoNewline -ForegroundColor Yellow
Write-Host "  Winget Script  " -ForegroundColor White -NoNewline
Write-Host "═══════════════════════════════════════╣" -ForegroundColor Yellow
Start-Sleep 2
Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
Write-Host "     Überprüfe auf fehlenden Abhängigkeiten...                                                 " -ForegroundColor Red -NoNewLine
Write-Host "║" -ForegroundColor Yellow
Start-Sleep 1
            #Check is Application: Microsoft UI Xaml 2.7.3 is installed, if not, than install this
            $Xaml = Get-AppPackage -name 'Microsoft.UI.Xaml.2.7'
            $XamlminimumVersion = [version]"2.7.0.0"
                if ($Xaml -and $Xaml.Version -lt $XamlminimumVersion) {

                Start-Sleep 2
                Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                Write-Host "     Installiere Abhängigkeit: Mircosoft UI Xaml 2.7...                                        " -ForegroundColor Red -NoNewLine
                Write-Host "║" -ForegroundColor Yellow
                Start-Sleep 1

			    New-Item C:\Windows\Temp\Winget -ItemType directory | Out-Null
			    Invoke-WebRequest -Uri 'https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.3' -OutFile C:\Windows\Temp\Winget\microsoft.ui.xaml.2.7.3.zip
			    Expand-Archive C:\Windows\Temp\Winget\microsoft.ui.xaml.2.7.3.zip -DestinationPath C:\Windows\Temp\Winget\microsoft.ui.xaml.2.7.3 | Out-Null
			    Add-AppxPackage -Path 'C:\Windows\Temp\Winget\microsoft.ui.xaml.2.7.3\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx' | Out-Null
			    Remove-Item 'C:\Windows\Temp\Winget' -Recurse | Out-Null
			    Start-Sleep 2
                }

                else {
                Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                Write-Host "     Abhängigkeit: Mircosoft UI Xaml 2.7 ist bereits installiert...                            " -ForegroundColor Green -NoNewLine
                Write-Host "║" -ForegroundColor Yellow        
                Start-Sleep 2
                }
            #Check is Application: Microsoft VCLibs X64 140.00 is installed, if not, than install this
            $VCLibs = Get-AppxPackage -Name 'Microsoft.VCLibs.140.00.UWPDesktop'
            $VCLibsminimumVersion = [version]"14.0.30704.0"
            if ($VCLibs -and $VCLibs.Version -lt $VCLibsminimumVersion) {

                Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                Write-Host "     Installiere Abhängigkeit: VCLibs.x64.14...                                                " -ForegroundColor Red -NoNewLine
                Write-Host "║" -ForegroundColor Yellow                 
                Start-Sleep 1
			    Add-AppxPackage -Path 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx' | Out-Null
			    Start-Sleep 2
		        }
		        
                else {
                Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                Write-Host "     Abhängigkeit: VCLibs.x64.14 ist bereits installiert...                                    " -ForegroundColor Green -NoNewLine
                Write-Host "║" -ForegroundColor Yellow
                Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow       
                Start-Sleep 2
                }


Clear-Host
Invoke-Command -ScriptBlock $Display
Write-Host " ══╦═══════════════════════════════════════════════════════════════════════════════════════════════╦══" -ForegroundColor Yellow
Write-Host "   ╠════════════════════════════════════" -NoNewline -ForegroundColor Yellow
Write-Host "  Winget Installation  " -ForegroundColor White -NoNewline
Write-Host "════════════════════════════════════╣" -ForegroundColor Yellow
Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
Start-Sleep 2
        #Install WinGet
            $Winget = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
            if ($Winget.Version -ge [version]"1.19.0.0") {
                Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                Write-Host "     Winget ist bereits Installiert...                                                         " -ForegroundColor Red -NoNewLine
                Write-Host "║" -ForegroundColor Yellow
                Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow         
                Start-Sleep 2
                }

            else {
			    $releases_url = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest' 

                Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                Write-Host "     Installiere aktuellste Winget-Cli Version...                                              " -ForegroundColor Red -NoNewLine
                Write-Host "║" -ForegroundColor Yellow
                Start-Sleep 2
			    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
			    $releases = Invoke-RestMethod -uri $releases_url
			    $latestRelease = $releases.assets | Where { $_.browser_download_url.EndsWith('msixbundle') } | Select -First 1
			    Add-AppxPackage -Path $latestRelease.browser_download_url
			    Start-Sleep 1
                Write-Host "  ║                                                                                               ║" -ForegroundColor Yellow
                Write-Host "  ╚═══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow                      
                }

Clear-Host
Invoke-Command -ScriptBlock $Display
Write-Host " ══╦═══════════════════════════════════════════════════════════════════════════════════════════════╦══" -ForegroundColor Yellow
Write-Host "   ╠═══════════════════════════════════" -NoNewline -ForegroundColor Yellow
Write-Host "  Software Installation  " -ForegroundColor White -NoNewline
Write-Host "═══════════════════════════════════╣" -ForegroundColor Yellow
Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
#Install Programs
Foreach ($app in $apps) {

    #check if the app is already installed
    $listApp = winget list --exact --accept-source-agreements -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        $atext = "Erfolgreich!             "
        $adesiredWidth = 70

        # Berechne die Länge des $app.name und des $atext, um den verbleibenden Platz für den App-Namen zu bestimmen
        $aremainingAppNameWidth = $adesiredWidth - $atext.Length - 5

        # Erstelle den wiederholten Text von $app.name und fülle mit Leerzeichen auf, um den gewünschten Zeichenplatz zu erreichen
        $apaddedAppName = ($app.name + " " * $aremainingAppNameWidth).Substring(0, $aremainingAppNameWidth)

        Write-Host "   ║  " -ForegroundColor Yellow -NoNewline
        Write-Host "  Installiere Software: $apaddedAppName"-ForegroundColor Red -NoNewline 
            winget install --id $app.name -e -h --accept-package-agreements | Out-Null
            Write-Host "| $atext" -ForegroundColor Green -NoNewline
            Write-Host "  ║" -ForegroundColor Yellow
        }

    else {
        $btext = "ist bereits installiert    "
        $bdesiredWidth = 72

        # Berechne die Länge des $app.name und des $btext, um den verbleibenden Platz für den App-Namen zu bestimmen
        $bremainingAppNameWidth = $bdesiredWidth - $btext.Length - 5

        # Erstelle den wiederholten Text von $app.name und fülle mit Leerzeichen auf, um den gewünschten Zeichenplatz zu erreichen
        $bpaddedAppName = ($app.name + " " * $bremainingAppNameWidth).Substring(0, $bremainingAppNameWidth)

        Write-Host "   ║  " -ForegroundColor Yellow -NoNewline
        Write-Host "  Installiere Software: $bpaddedAppName"-ForegroundColor Red -NoNewline 
        Write-Host "| $btext" -ForegroundColor Green -NoNewline
        Write-Host "║" -ForegroundColor Yellow
    }
}

Invoke-Command -ScriptBlock $End
              }

        if ($actions -eq 2) {
            Clear-Host
            Start-Process "https://github.com/IG-Community/Winget-Script#README"
            menu
            }
            exit
            menu
                 }
        else {
        menu
      }
    }
}
menu

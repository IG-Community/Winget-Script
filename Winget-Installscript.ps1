$ProgressPreference = 'SilentlyContinue'
$host.ui.RawUI.WindowTitle = "Windows Package Manager - Installer"
[Console]::WindowWidth=103;
[Console]::Windowheight=30;
[Console]::setBufferSize(103,30) #width,height

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
    Write-Host "   ║                           " -ForegroundColor Yellow -NoNewline 
    Write-Host "Der Installationsprozess war Erfolgreich!" -ForegroundColor Green -NoNewline 
    Write-Host "                           ║" -ForegroundColor Yellow
    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
    Start-Sleep 5
    }

$Display = {
Write-Host "   _________ .____       _________         _________                               __
   \_   ___ \|    |     /   _____/         \_   ___ \  ____   _____ ______  __ ___/  |_  ___________
   /    \  \/|    |     \_____  \   ______ /    \  \/ /  _ \ /     \\____ \|  |  \   __\/ __ \_  __ \
   \     \___|    |___  /        \ /_____/ \     \___(  <_> )  Y Y  \  |_> >  |  /|  | \  ___/|  | \/
    \______  /_______ \/_______  /          \______  /\____/|__|_|  /   __/|____/ |__|  \___  >__|
           \/        \/        \/                  \/             \/|__|                    \/" -ForegroundColor Cyan
Write-Host "                       _________      .__  __     ____ ________  ________________
                      /   _____/ ____ |__|/  |_  /_   /   __   \/   __   \_____  \
                      \_____  \_/ __ \|  \   __\  |   \____    /\____    / _(__  <
                      /        \  ___/|  ||  |    |   |  /    /    /    / /       \
                     /_______  /\___  >__||__|    |___| /____/    /____/ /______  /
                             \/     \/                                          \/             v4.5.0" -ForegroundColor Red
}
function menu {
    Invoke-Command -ScriptBlock $Display
    Write-Host " ══════════════╦═══════════════════════════════════════════════════════════════════════╦══════════════"-ForegroundColor Yellow
    Write-Host "               ╠══════════════════════" -ForegroundColor Yellow -NoNewline 
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
Write-Host "   ╠═══════════════════════════════════════" -ForegroundColor Yellow -NoNewline
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
Write-Host "   ╠════════════════════════════════════" -ForegroundColor Yellow -NoNewline
Write-Host "  Winget Installation  " -ForegroundColor White -NoNewline
Write-Host "════════════════════════════════════╣" -ForegroundColor Yellow
Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
Start-Sleep 2
        #Install WinGet
            $Winget = Get-AppxPackage -name 'Microsoft.DesktopAppInstaller'
            if ($Winget.Version -ge [version]"1.19.0.0") {
                Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                Write-Host "     Winget ist bereits Installiert...                                                         " -ForegroundColor Green -NoNewLine
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
                Write-Host "  ║                                                                                               ║" -ForegroundColor Yellow
                Write-Host "  ╚═══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
                Start-Sleep 2
                }

Clear-Host
Invoke-Command -ScriptBlock $Display
Write-Host " ══╦═══════════════════════════════════════════════════════════════════════════════════════════════╦══" -ForegroundColor Yellow
Write-Host "   ╠═══════════════════════════════════" -ForegroundColor Yellow -NoNewline
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

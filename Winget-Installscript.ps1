#Unterdrücke Fortschrittsinformationen, erstelle Titel für das Programm und passe die Fenstergröße an.
$ProgressPreference = 'SilentlyContinue'
$host.ui.RawUI.WindowTitle = "Windows Package Manager - Setup"
[Console]::WindowWidth=103;
[Console]::Windowheight=43;
[Console]::setBufferSize(103,43) #width,height


#Logobereich (ASCII-Style)
$Display = {
Write-Host "        __      __.__                       __                _________       __                
       /  \    /  \__| ____    ____   _____/  |_             /   _____/ _____/  |_ __ ________  
       \   \/\/   /  |/    \  / ___\_/ __ \   __\   ______   \_____  \_/ __ \   __\  |  \____ \ 
        \        /|  |   |  \/ /_/  >  ___/|  |    /_____/   /        \  ___/|  | |  |  /  |_> >
         \__/\  / |__|___|  /\___  / \___  >__|             /_______  /\___  >__| |____/|   __/ 
              \/          \//_____/      \/                         \/     \/           |__|    " -ForegroundColor Cyan
Write-Host "   @sd-itlab.de                                                                               v5.5.0" -ForegroundColor Red
}

#Abschlussvariable, wenn der Installationsprozess abgeschlossen ist.
$End = {
    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
    Write-Host "   ╠═══════════════════════════════════════════════════════════════════════════════════════════════╣" -ForegroundColor Yellow
    Write-Host "   ║                           " -ForegroundColor Yellow -NoNewline 
    Write-Host "Der Installationsprozess war Erfolgreich!" -ForegroundColor Green -NoNewline 
    Write-Host "                           ║" -ForegroundColor Yellow
    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
    Start-Sleep 2
    }

#Winget Prüfung, ob Winget und dessen Abhängigkeiten installiert sind.
function InstallWinget {

    #Installationsprüfung ob benötigte Abhängigkeiten vorhanden ist.
    Clear-Host
    Invoke-Command -ScriptBlock $Display
    Write-Host " ══╦═══════════════════════════════════════════════════════════════════════════════════════════════╦══" -ForegroundColor Yellow
    Write-Host "   ╠═══════════════════════════════════════" -ForegroundColor Yellow -NoNewline
    Write-Host "  Winget Script  " -ForegroundColor White -NoNewline
    Write-Host "═══════════════════════════════════════╣" -ForegroundColor Yellow
    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
    Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
    Write-Host "     Überprüfe auf fehlenden Abhängigkeiten...                                                 " -ForegroundColor Red -NoNewLine
    Write-Host "║" -ForegroundColor Yellow

                #Abhängigkeitsprüfung
                #Prüft, ob Microsoft UI Xaml 2.8.6 installiert ist, wenn nicht, dann installieren dies
                $Xaml = Get-AppxPackage -Name 'Microsoft.UI.Xaml.2.8'
                $XamlMinimumVersion = [version]"8.2310.30001.0"
                if ($Xaml.Version -lt $XamlMinimumVersion) {
    
                    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                    Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                    Write-Host "     Installiere Abhängigkeit: Mircosoft UI Xaml 2.8...                                        " -ForegroundColor Red -NoNewLine
                    Write-Host "║" -ForegroundColor Yellow
    
                    New-Item C:\Windows\Temp\Winget -ItemType directory | Out-Null
                    Invoke-WebRequest -Uri 'https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6' -OutFile C:\Windows\Temp\Winget\microsoft.ui.xaml.2.8.6.zip
                    Expand-Archive C:\Windows\Temp\Winget\microsoft.ui.xaml.2.8.6.zip -DestinationPath C:\Windows\Temp\Winget\microsoft.ui.xaml.2.8.6 | Out-Null
                    Add-AppxPackage -Path 'C:\Windows\Temp\Winget\microsoft.ui.xaml.2.8.6\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.8.appx' | Out-Null
                    Remove-Item 'C:\Windows\Temp\Winget' -Recurse | Out-Null
                    }
    
                    else {
                    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                    Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                    Write-Host "     Abhängigkeit: Mircosoft UI Xaml 2.8 ist bereits installiert...                            " -ForegroundColor Green -NoNewLine
                    Write-Host "║" -ForegroundColor Yellow
                    }

                #Abhängigkeitsprüfung
                #Prüfen, ob Microsoft VCLibs X64 140.00 installiert ist, wenn nicht, dann installieren dies
                $VCLibs = Get-AppxPackage -Name 'Microsoft.VCLibs.140.00.UWPDesktop'
                $VCLibsminimumVersion = [version]"14.0.33519.0"
                if ($VCLibs -and $VCLibs.Version -lt $VCLibsminimumVersion) {
    
                    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                    Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                    Write-Host "     Installiere Abhängigkeit: VCLibs.x64.14...                                                " -ForegroundColor Red -NoNewLine
                    Write-Host "║" -ForegroundColor Yellow
                    Add-AppxPackage -Path 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx' | Out-Null
                    }
    
                    else {
                    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                    Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                    Write-Host "     Abhängigkeit: VCLibs.x64.14 ist bereits installiert...                                    " -ForegroundColor Green -NoNewLine
                    Write-Host "║" -ForegroundColor Yellow
                    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
                    }
    
    #Installationsprüfung des Hauptbestandteils von Winget
    Clear-Host
    Invoke-Command -ScriptBlock $Display
    Write-Host " ══╦═══════════════════════════════════════════════════════════════════════════════════════════════╦══" -ForegroundColor Yellow
    Write-Host "   ╠════════════════════════════════════" -ForegroundColor Yellow -NoNewline
    Write-Host "  Winget Installation  " -ForegroundColor White -NoNewline
    Write-Host "════════════════════════════════════╣" -ForegroundColor Yellow
    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow

                #Prüfen, ob Microsoft DesktopAppInstaller (Winget) installiert ist, wenn nicht, dann installieren dies
                $Winget = Get-AppxPackage -name 'Microsoft.DesktopAppInstaller'
                if ($Winget.Version -ge [version]"1.23.0.0") {
                    Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                    Write-Host "     Winget ist bereits Installiert...                                                         " -ForegroundColor Green -NoNewLine
                    Write-Host "║" -ForegroundColor Yellow
                    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
                    }
    
                else {
                    $releases_url = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest'
    
                    Write-Host "   ║" -ForegroundColor Yellow -NoNewLine
                    Write-Host "     Installiere aktuellste Winget-Cli Version...                                              " -ForegroundColor Red -NoNewLine
                    Write-Host "║" -ForegroundColor Yellow
                    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                    $releases = Invoke-RestMethod -uri $releases_url
                    $latestRelease = $releases.assets | Where-Object { $_.browser_download_url.EndsWith('msixbundle') } | Select-Object -First 1
                    Add-AppxPackage -Path $latestRelease.browser_download_url			    
                    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow
                    Write-Host "   ╚═══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
                    }
    }

#Ausgewähle Programme Prüfen, ob installiert, wenn nicht Installiere diese.
function InstallApps {
    param (
        [Parameter(Mandatory = $true)]
        [string[]]
        $apps
    )

    Clear-Host
    Invoke-Command -ScriptBlock $Display
    Write-Host " ══╦═══════════════════════════════════════════════════════════════════════════════════════════════╦══" -ForegroundColor Yellow
    Write-Host "   ╠═══════════════════════════════════" -ForegroundColor Yellow -NoNewline
    Write-Host "  Software Installation  " -ForegroundColor White -NoNewline
    Write-Host "═══════════════════════════════════╣" -ForegroundColor Yellow
    Write-Host "   ║                                                                                               ║" -ForegroundColor Yellow

    #Programm Installation Abschnitt
    foreach ($app in $apps) {
        #Überprüfe für jede ausgewählte App, ob diese bereits Installiert ist, wenn nicht, Installiere diese
        $listApp = winget list --exact --accept-source-agreements -q $app
        if (![String]::Join("", $listApp).Contains($app)) {
            $atext = "Erfolgreich!             "
            $adesiredWidth = 70
            Start-Sleep 1
    
            #Berechne die Länge des $app.name und des $atext, um den verbleibenden Platz für den App-Namen zu bestimmen
            $aremainingAppNameWidth = $adesiredWidth - $atext.Length - 5
    
            #Erstelle den wiederholten Text von $app.name und fülle mit Leerzeichen auf, um den gewünschten Zeichenplatz zu erreichen
            $apaddedAppName = ($app + " " * $aremainingAppNameWidth).Substring(0, $aremainingAppNameWidth)
    
            Write-Host "   ║  " -ForegroundColor Yellow -NoNewline
            Write-Host "  Installiere Software: $apaddedAppName"-ForegroundColor Red -NoNewline
                winget install --id $app -e -h --accept-package-agreements | Out-Null
                Write-Host "| $atext" -ForegroundColor Green -NoNewline
                Write-Host "  ║" -ForegroundColor Yellow
            }
    
        else {
            $btext = "ist bereits installiert    "
            $bdesiredWidth = 72
    
            #Berechne die Länge des $app.name und des $btext, um den verbleibenden Platz für den App-Namen zu bestimmen
            $bremainingAppNameWidth = $bdesiredWidth - $btext.Length - 5
    
            #Erstelle den wiederholten Text von $app.name und fülle mit Leerzeichen auf, um den gewünschten Zeichenplatz zu erreichen
            $bpaddedAppName = ($app + " " * $bremainingAppNameWidth).Substring(0, $bremainingAppNameWidth)
    
            Write-Host "   ║  " -ForegroundColor Yellow -NoNewline
            Write-Host "  Installiere Software: $bpaddedAppName"-ForegroundColor Red -NoNewline
            Write-Host "| $btext" -ForegroundColor Green -NoNewline
            Write-Host "║" -ForegroundColor Yellow
            Start-Sleep 1
        }
    }
    
    Invoke-Command -ScriptBlock $End
    Start-Sleep 2
    menu
    }    

#Menüanzeige, um verfügbare Auswahlmöglichkeiten anzuzeigen.
function menu {
    
    Clear-Host
    Invoke-Command -ScriptBlock $Display
    Write-Host " ══════════════╦═══════════════════════════════════════════════════════════════════════╦══════════════"-ForegroundColor Yellow
    Write-Host "               ╠══════════════════════" -ForegroundColor Yellow -NoNewline 
    Write-Host "  Windows Package Manager  " -ForegroundColor Magenta -NoNewline
    Write-Host "══════════════════════╣" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ║" -ForegroundColor Yellow -NoNewLine
    Write-Host "    1: Installation der Software ohne Java                             " -ForegroundColor Cyan -NoNewLine
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ║" -ForegroundColor Yellow -NoNewLine
    Write-Host "    2: Installation der Software ohne Java und Thunderbird             " -ForegroundColor Cyan -NoNewLine
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ║" -ForegroundColor Yellow -NoNewLine
    Write-Host "    3: Installation der Software mit Java                              " -ForegroundColor Cyan -NoNewLine
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ║" -ForegroundColor Yellow -NoNewLine
    Write-Host "    4: Installation der Software mit Java aber ohne Thunderbird        " -ForegroundColor Cyan -NoNewLine
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ╠══════════════════════════" -ForegroundColor Yellow -NoNewline 
    Write-Host " Weitere Programme " -ForegroundColor Magenta -NoNewline
    Write-Host "══════════════════════════╣" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ║"-ForegroundColor Yellow -NoNewline 
    Write-Host "     DOCUMENTS           TOOLS                                         " -ForegroundColor Magenta -NoNewline  
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║"-ForegroundColor Yellow -NoNewline
    Write-Host "      5: LibreOffice      9: 7Zip              13: Oracle Java  8      " -ForegroundColor Cyan -NoNewline
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║"-ForegroundColor Yellow -NoNewline 
    Write-Host "      6: OpenOffice      10: PeaZip            14: Adobe Reader DC     " -ForegroundColor Cyan -NoNewline
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║"-ForegroundColor Yellow -NoNewline 
    Write-Host "      7: Notepad++       11: Everything        15: VLC-Media Player    " -ForegroundColor Cyan -NoNewline
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║"-ForegroundColor Yellow -NoNewline 
    Write-Host "      8: PDF24 Creator   12: Thunderbird       16: Malwarebytes        " -ForegroundColor Cyan -NoNewline
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║"
    Write-Host "               ║"-ForegroundColor Yellow -NoNewline
    Write-Host "     REMOTE              BROWSER                                       " -ForegroundColor Magenta -NoNewline
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║"-ForegroundColor Yellow -NoNewline 
    Write-Host "     17: Teamviewer      20: Google Chrome     23: Opera               " -ForegroundColor Cyan -NoNewline
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║"-ForegroundColor Yellow -NoNewline 
    Write-Host "     18: Anydesk         21: Mozilla Firefox   24: Opera GX            " -ForegroundColor Cyan -NoNewline
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║"-ForegroundColor Yellow -NoNewline 
    Write-Host "     19: Rustdesk        22: Brave Browser                             " -ForegroundColor Cyan -NoNewline
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ╠═══════════════════════════════════════════════════════════════════════╣" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ║" -ForegroundColor Yellow -NoNewLine
    Write-Host "    0: Beenden                                           30: Readme    " -ForegroundColor Magenta -NoNewLine
    Write-Host "║" -ForegroundColor Yellow
    Write-Host "               ║                                                                       ║" -ForegroundColor Yellow
    Write-Host "               ╚═══════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
    Write-Host
  
        $actions = Read-Host -Prompt '                Was möchten Sie tun? [Beispiel: 1,2,3,4]'

        if ($actions -eq 0) {
            exit
        }

        if ($actions -eq 30) {
            Clear-Host
            Start-Process "https://sd-itlab.de/winget/"
            menu
        }


        #App-Auswahl-Paket, (Menünummer 1-24), Gewünschte nummern werden zur Installations-auswahl hinzugefügt
        $selectedApps = $actions -split ',' | ForEach-Object { $_.Trim() }    
        if ($selectedApps -notcontains '0' -and $selectedApps.Count -ge 1) {
            Install-List -appNumbers $selectedApps
            Start-Sleep 1
            menu
        }
        else {
        Write-Host "Ungültige Auswahl. Bitte wählen Sie erneut." -ForegroundColor Red
        Start-Sleep 1
        menu
        }
    }
 
#App-Auswahl-Paket, definiere, welche Programme welcher Nummer zugewiesen werden.
function Install-List {
    param (
        [string[]]$appNumbers
    )

    $selectedApps = @()
            foreach ($selectedApp in $appNumbers) {
                switch ($selectedApp) {
                     '1' { $selectedApps += "Mozilla.Firefox", "Google.Chrome", "Mozilla.Thunderbird", "VideoLAN.VLC", "Adobe.Acrobat.Reader.64-bit" }
                     '2' { $selectedApps += "Mozilla.Firefox", "Google.Chrome", "VideoLAN.VLC", "Adobe.Acrobat.Reader.64-bit" }
                     '3' { $selectedApps += "Mozilla.Firefox", "Google.Chrome", "Mozilla.Thunderbird", "VideoLAN.VLC", "Adobe.Acrobat.Reader.64-bit", "Oracle.JavaRuntimeEnvironment" }
                     '4' { $selectedApps += "Mozilla.Firefox", "Google.Chrome", "VideoLAN.VLC", "Adobe.Acrobat.Reader.64-bit", "Oracle.JavaRuntimeEnvironment" }
                     '5' { $selectedApps += "TheDocumentFoundation.LibreOffice" }
                     '6' { $selectedApps += "Apache.OpenOffice" }
                     '7' { $selectedApps += "Notepad++.Notepad++" }
                     '8' { $selectedApps += "geeksoftwareGmbH.PDF24Creator" }
                     '9' { $selectedApps += "7zip.7zip" }
                    '10' { $selectedApps += "Giorgiotani.Peazip" }
                    '11' { $selectedApps += "voidtools.Everything" }
                    '12' { $selectedApps += "Mozilla.Thunderbird" }
                    '13' { $selectedApps += "Oracle.JavaRuntimeEnvironment" }
                    '14' { $selectedApps += "Adobe.Acrobat.Reader.64-bit" }
                    '15' { $selectedApps += "VideoLAN.VLC" }
                    '16' { $selectedApps += "Malwarebytes.Malwarebytes" }
                    '17' { $selectedApps += "TeamViewer.TeamViewer" }
                    '18' { $selectedApps += "AnyDeskSoftwareGmbH.AnyDesk" }
                    '19' { $selectedApps += "RustDesk.RustDesk" }
                    '20' { $selectedApps += "Google.Chrome" }
                    '21' { $selectedApps += "Mozilla.Firefox" }
                    '22' { $selectedApps += "Brave.Brave" }
                    '23' { $selectedApps += "Opera.Opera" }
                    '24' { $selectedApps += "Opera.OperaGX" }
                }
            }
            InstallWinget
            InstallApps -apps $selectedApps
            Start-Sleep 2
            menu
        }
menu

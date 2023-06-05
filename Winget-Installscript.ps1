$ProgressPreference = 'SilentlyContinue'
$host.ui.RawUI.WindowTitle = "Winget-Install Software"
[Console]::WindowWidth=102;
[Console]::Windowheight=30;
[Console]::setBufferSize(102,30) #width,height


#=====================================================

#Adding apps to install! (You can edit this part)
    $apps = @(
        @{name = "M2Team.NanaZip" },
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

$line = "****************************************************************************************************"
$Display1 ="
 __      __.__                       __    .___                 __         .__  .__                
/  \    /  \__| ____    ____   _____/  |_  |   | ____   _______/  |______  |  | |  |   ___________ 
\   \/\/   /  |/    \  / ___\_/ __ \   __\ |   |/    \ /  ___/\   __\__  \ |  | |  | _/ __ \_  __ \
 \        /|  |   |  \/ /_/  >  ___/|  |   |   |   |  \\___ \  |  |  / __ \|  |_|  |_\  ___/|  | \/
  \__/\  / |__|___|  /\___  / \___  >__|   |___|___|  /____  > |__| (____  /____/____/\___  >__|   
       \/          \//_____/      \/                \/     \/            \/               \/        
"
                                                                        

Write-Host "$line" -ForegroundColor Gray
Write-Host "$Display1" -ForegroundColor Blue
Write-Host "$line" -ForegroundColor Gray
Start-Sleep 2


          #Install WinGet
            $hasPackageManager = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
                if (!$hasPackageManager -or [version]$hasPackageManager.Version -lt [version]"1.18.0.0") {
Write-Host "
*****************************************************
*           Check for missing dependencies          *
*****************************************************" -ForegroundColor Cyan	
Start-Sleep 1
Write-Host "      
	Checking of Application: 
           Microsoft UI Xaml 2.7.3
           Microsoft VCLibs X64 140.00"
Start-Sleep 1


          #Check is Application: Microsoft UI Xaml 2.7.3 is installed, if not, than install this
             $hasPackageManager = Get-AppPackage -name 'Microsoft.UI.Xaml.2.7'
                if (!$hasPackageManager -or [version]$hasPackageManager.Version -lt [version]"2.7.0.0") {
Write-Host "
*****************************************************
* Install missing dependency: Microsoft UI Xaml 2.7 *
*****************************************************" -ForegroundColor Cyan	
Start-Sleep 3

			New-Item C:\Windows\Temp\Winget -ItemType directory | Out-Null
			Write-Host "Installing Microsoft UI Xaml dependency" -ForegroundColor Red -nonewline
			Invoke-WebRequest -Uri 'https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.3' -OutFile C:\Windows\Temp\Winget\microsoft.ui.xaml.2.7.3.zip
			Expand-Archive C:\Windows\Temp\Winget\microsoft.ui.xaml.2.7.3.zip -DestinationPath C:\Windows\Temp\Winget\microsoft.ui.xaml.2.7.3 | Out-Null
			Add-AppxPackage -Path 'C:\Windows\Temp\Winget\microsoft.ui.xaml.2.7.3\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx' | Out-Null
			Remove-Item 'C:\Windows\Temp\Winget' -Recurse | Out-Null
			Write-Host " | Completed" -ForegroundColor Green
			Start-Sleep 3
        }
        else {
Write-Host "
*****************************************************
*   Microsoft UI Xaml 2.7.3 is already installed    *
*****************************************************" -ForegroundColor Green
Start-Sleep 1
        }

          #Check is Application: Microsoft VCLibs X64 140.00 is installed, if not, than install this
             $hasPackageManager = Get-AppxPackage -Name 'Microsoft.VCLibs.140.00.UWPDesktop'
                if (!$hasPackageManager -or [version]$hasPackageManager.Version -lt [version]"14.0.30035.0"){
Write-Host "
*****************************************************
*     Install missing dependency: VCLibs.x64.14     *
*****************************************************" -ForegroundColor Cyan	
Start-Sleep 1
			Write-Host "Installing Microsoft VCLibs dependency" -ForegroundColor Red -nonewline
			Add-AppxPackage -Path 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx' | Out-Null
			Write-Host " | Completed" -ForegroundColor Green
			Start-Sleep 3
		}
		else {
Write-Host "
*****************************************************
*   Microsoft VCLibs.x64.14 is already installed    *
*****************************************************" -ForegroundColor Green
Start-Sleep 3
        }


Clear-Host
Write-Host "$line" -ForegroundColor Gray
Write-Host "$Display1" -ForegroundColor Blue
Write-Host "$line" -ForegroundColor Gray
Write-Host "
*****************************************************
*              Install WinGet Package               *
*****************************************************" -ForegroundColor Cyan

			Write-Host "Download latest winget-cli release.." -ForegroundColor Red -nonewline

			$releases_url = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest' 

			[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
			$releases = Invoke-RestMethod -uri $releases_url
			$latestRelease = $releases.assets | Where { $_.browser_download_url.EndsWith('msixbundle') } | Select -First 1
			Write-Host "  | Completed" -ForegroundColor Green
			Start-Sleep 2
			Write-Host "Installing winget..." -ForegroundColor Red -nonewline		
			Add-AppxPackage -Path $latestRelease.browser_download_url
			Write-Host " | Completed" -ForegroundColor Green
			Start-Sleep 3
    }

    else {
Write-Host "
*****************************************************
*           Winget is already installed !           *
*****************************************************" -ForegroundColor Green
        Start-Sleep 3
    }


#Install Programs
Clear-Host
Write-Host "$line" -ForegroundColor Gray
Write-Host "$Display1" -ForegroundColor Blue
Write-Host "$line" -ForegroundColor Gray
Write-Host "
*****************************************************
*              Software installation !              *
*****************************************************" -ForegroundColor Cyan

    Foreach ($app in $apps) {
        #check if the app is already installed
        $listApp = winget list --exact --accept-source-agreements -q $app.name
        if (![String]::Join("", $listApp).Contains($app.name)) {
            Write-Host "Installing:" $app.name"..." -ForegroundColor Red -nonewline
                winget install --id $app.name -e -h --accept-package-agreements | Out-Null
                Write-Host " | Completed!" -ForegroundColor Green
            }

        else {
            Write-host "Skipping Install of " $app.name -ForegroundColor Green
        }
    }

Start-Sleep 2
Write-Host "
*****************************************************
*    The installation process has been completed    *
*****************************************************" -ForegroundColor Green
Start-Sleep 3

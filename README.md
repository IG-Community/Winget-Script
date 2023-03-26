# Winget-Script

Mit dem Befehlszeilentool winget können Benutzer Anwendungen auf Windows 10- und Windows 11-Computern suchen, installieren, aktualisieren, entfernen und konfigurieren. Dieses Tool ist die Clientschnittstelle für den Windows-Paket-Manager-Dienst.


In diesem Script, wird zuerst überprüft, ob bereits eine Winget-Version (DesktopAppInstaller.appx) höher als 1.18 installiert ist.
Wenn dies nicht gegeben ist, prüft das Script welche Windows-Version installiert ist.
Den für Windows 10 wird zusätzlich die Microsoft Xaml 2.7 benötigt, diese ist aber nicht installiert, daher wird diese nachinstalliert.


Danach wird die neuste winget-Version installiert.
Sobald diese erledigt ist, wird eine Liste abgearbeitet, welche Programme installiert werden sollen.

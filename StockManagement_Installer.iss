; Inno Setup Script for Stock Management System
; This creates a Windows installer .exe that installs everything and runs the app
; Download Inno Setup from: https://jrsoftware.org/isdl.php

[Setup]
; App information
AppName=Stock Management System
AppVersion=1.0
AppPublisher=Your Company Name
AppPublisherURL=
AppSupportURL=
DefaultDirName={autopf}\StockManagement
DefaultGroupName=Stock Management System
AllowNoIcons=yes
LicenseFile=
OutputDir=installer
OutputBaseFilename=StockManagement_Installer
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
ArchitecturesInstallIn64BitMode=x64

; Installer appearance
WizardImageFile=
WizardSmallImageFile=
SetupIconFile=

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1; Check: not IsAdminInstallMode

[Files]
; Application executable
Source: "bin\stock_management.exe"; DestDir: "{app}"; Flags: ignoreversion

; All GTK DLLs (these will be copied from bin folder after build_standalone.bat)
Source: "bin\*.dll"; DestDir: "{app}"; Flags: ignoreversion

; GTK data files
Source: "bin\share\*"; DestDir: "{app}\share"; Flags: ignoreversion recursesubdirs createallsubdirs

; Application data folder (will be created by app automatically)

[Icons]
Name: "{group}\Stock Management System"; Filename: "{app}\stock_management.exe"
Name: "{group}\{cm:UninstallProgram,Stock Management System}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\Stock Management System"; Filename: "{app}\stock_management.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Stock Management System"; Filename: "{app}\stock_management.exe"; Tasks: quicklaunchicon

[Run]
; Run the application after installation
Filename: "{app}\stock_management.exe"; Description: "{cm:LaunchProgram,Stock Management System}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"


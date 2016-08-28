; example2.nsi
;
; This script is based on example1.nsi, but it remember the directory,
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install example2.nsi into a directory that the user selects,

;--------------------------------

; Enable Unicode encoding
;Unicode True

;Include Modern UI
!include "MUI2.nsh"
!include "FileFunc.nsh"

; The name of the installer
Name "<%= appName %><%= setupName %>"

; Other infos
Caption "<%= appName %><%= version %>"
BrandingText "<%= appName %><%= version %>"
VIAddVersionKey "ProductName" "<%= appName %>"
VIAddVersionKey "ProductVersion" "<%= version %>"
VIAddVersionKey "FileDescription" "<%= appName %> <%= version %> Installer"
VIAddVersionKey "FileVersion" "<%= version %>"
VIAddVersionKey "CompanyName" "<%= companyName %>"
VIAddVersionKey "LegalCopyright" "<%= legalUrl %>"
VIProductVersion "<%= version %>.0"

; The file to write
OutFile "<%= buildDir %><%= appName %><%= setupName %>.exe"

; The default installation directory
InstallDir $PROGRAMFILES\<%= appName %>

; Registry key to check for directory (so if you install again, it will
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\NSIS_<%= appName %>" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

;--------------------------------

; Define UI settings
; http://nsis.sourceforge.net/Docs/Modern%20UI/Readme.html

;!define MUI_UI_HEADERIMAGE_RIGHT "..\Icon.iconset\icon_256x256.png"
;!define MUI_ICON "..\icon_win.ico"
;!define MUI_UNICON "..\icon_win.ico"
;!define MUI_WELCOMEFINISHPAGE_BITMAP ""
;!define MUI_UNWELCOMEFINISHPAGE_BITMAP ""
!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN "$INSTDIR\<%= exeFile %>"
!define MUI_FINISHPAGE_RUN_TEXT "Start <%= appName %>"

;Define the pages
;!insertmacro MUI_PAGE_WELCOME
;!insertmacro MUI_PAGE_LICENSE "../License.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

;Define uninstall pages
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;Load Language Files
!insertmacro MUI_LANGUAGE "English"

;--------------------------------

; The stuff to install
Section "<%= appName %>"

  SectionIn RO

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR

  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\<%= appName %>"
  DeleteRegKey HKLM SOFTWARE\NSIS_<%= appName %>

  ; Remove files and uninstaller
  Delete $INSTDIR\<%= appName %>.nsi
  Delete $INSTDIR\uninstall.exe

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\<%= appName %>\*.*"

  ; Remove directories used
  RMDir /r "$SMPROGRAMS\<%= appName %>"
  RMDir /r "$INSTDIR"

  ; Put file there
  File /r "<%= srcDir.replace(/\//g,'\\') %>"
  File "created_template.nsi"

  ; Set permission
  <% setFilePermission.forEach(function(file){ %>
  AccessControl::GrantOnFile "$INSTDIR\<%= file.replace(/\//g,'\\') %>" "(BU)" "FullAccess"
  <% }); %>

  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\NSIS_<%= appName %> "Install_Dir" "$INSTDIR"

  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\<%= appName %>" "DisplayName" ""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\<%= appName %>" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\<%= appName %>" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\<%= appName %>" "NoRepair" 1
  WriteUninstaller "uninstall.exe"

SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\<%= appName %>"
  CreateShortcut "$SMPROGRAMS\<%= appName %>\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortcut "$SMPROGRAMS\<%= appName %>\<%= appName %>.lnk" "$INSTDIR\<%= exeFile %>" "" "$INSTDIR\<%= exeFile %>" 0

SectionEnd

; Optional section (can be disabled by the user)
Section "Desktop Shortcut"

  CreateShortcut "$DESKTOP\<%= appName %>.lnk" "$INSTDIR\<%= exeFile %>" "" "$INSTDIR\<%= exeFile %>" 0

SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"

  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\<%= appName %>"
  DeleteRegKey HKLM SOFTWARE\NSIS_<%= appName %>

  ; Remove files and uninstaller
  Delete $INSTDIR\<%= appName %>.nsi
  Delete $INSTDIR\uninstall.exe

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\<%= appName %>\*.*"
  Delete "$DESKTOP\<%= appName %>.lnk" 

  ; Remove directories used
  RMDir /r "$SMPROGRAMS\<%= appName %>"
  RMDir /r "$INSTDIR"

SectionEnd


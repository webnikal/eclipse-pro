; Eclipse Pro Windows Installer (NSIS)
; Built on GitHub Actions - packages the cx_Freeze dist folder

!include "MUI2.nsh"

; --- Eclipse Pro branded installer graphics ---
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "${HEADERBMP}"
!define MUI_WELCOMEFINISHPAGE_BITMAP "${WIZARDBMP}"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "${WIZARDBMP}"

!define APPNAME "Eclipse Pro"
!define VERSION "1.0.0"
!define PUBLISHER "Eclipse Pro"
!define EXE "EclipsePro.exe"

Name "${APPNAME} ${VERSION}"
Icon "${ICONFILE}"
!define MUI_ICON "${ICONFILE}"
OutFile "${OUTFILE}"
InstallDir "$PROGRAMFILES\${APPNAME}"
RequestExecutionLevel admin

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "$INSTDIR\${EXE}"
!define MUI_FINISHPAGE_RUN_TEXT "Launch ${APPNAME}"
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

Section "Install"
  SetOutPath "$INSTDIR"
  File /r "${DISTDIR}\*.*"
  File "${ICONFILE}"

  CreateDirectory "$SMPROGRAMS\${APPNAME}"
  CreateShortcut "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk" "$INSTDIR\${EXE}" "" "$INSTDIR\eclipse-pro.ico"
  CreateShortcut "$DESKTOP\${APPNAME}.lnk" "$INSTDIR\${EXE}" "" "$INSTDIR\eclipse-pro.ico"

  WriteUninstaller "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayName" "${APPNAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayVersion" "${VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "Publisher" "${PUBLISHER}"
SectionEnd

Section "Uninstall"
  Delete "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk"
  Delete "$DESKTOP\${APPNAME}.lnk"
  RMDir "$SMPROGRAMS\${APPNAME}"
  Delete "$INSTDIR\Uninstall.exe"
  RMDir /r "$INSTDIR"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"
SectionEnd

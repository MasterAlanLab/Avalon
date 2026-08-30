[Setup]
AppId={{APP_ID}}
AppVersion={{APP_VERSION}}
AppName={{DISPLAY_NAME}}
AppPublisher={{PUBLISHER_NAME}}
AppPublisherURL={{PUBLISHER_URL}}
AppSupportURL={{PUBLISHER_URL}}
AppUpdatesURL={{PUBLISHER_URL}}
DefaultDirName={{INSTALL_DIR_NAME}}
DisableProgramGroupPage=yes
OutputDir=.
OutputBaseFilename={{OUTPUT_BASE_FILENAME}}
Compression=lzma
SolidCompression=yes
SetupIconFile={{SETUP_ICON_FILE}}
WizardStyle=modern
PrivilegesRequired={{PRIVILEGES_REQUIRED}}
ArchitecturesAllowed={{ARCH}}
ArchitecturesInstallIn64BitMode={{ARCH}}

[Code]
procedure KillProcesses;
var
  Processes: TArrayOfString;
  i: Integer;
  ResultCode: Integer;
begin
  Processes := ['FlClash.exe', 'FlClashCore.exe', 'FlClashHelperService.exe'];

  for i := 0 to GetArrayLength(Processes)-1 do
  begin
    Exec('taskkill', '/f /im ' + Processes[i], '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  end;
end;

procedure UnregisterHelperService;
var
  HelperPath: String;
  ResultCode: Integer;
begin
  HelperPath := ExpandConstant('{app}\\FlClashHelperService.exe');
  if FileExists(HelperPath) then
  begin
    Exec(HelperPath, 'uninstall', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  end;
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  UnregisterHelperService;
  KillProcesses;
  Result := '';
end;

function InitializeUninstall(): Boolean;
begin
  UnregisterHelperService;
  KillProcesses;
  Result := True;
end;

[Languages]
{% for locale in LOCALES %}
{% if locale.lang == 'en' %}Name: "english"; MessagesFile: "compiler:Default.isl"{% endif %}
{% if locale.lang == 'hy' %}Name: "armenian"; MessagesFile: "compiler:Languages\\Armenian.isl"{% endif %}
{% if locale.lang == 'bg' %}Name: "bulgarian"; MessagesFile: "compiler:Languages\\Bulgarian.isl"{% endif %}
{% if locale.lang == 'ca' %}Name: "catalan"; MessagesFile: "compiler:Languages\\Catalan.isl"{% endif %}
{% if locale.lang == 'zh' %}
Name: "chineseSimplified"; MessagesFile: {% if locale.file %}{{ locale.file }}{% else %}"compiler:Languages\\ChineseSimplified.isl"{% endif %}
{% endif %}
{% if locale.lang == 'co' %}Name: "corsican"; MessagesFile: "compiler:Languages\\Corsican.isl"{% endif %}
{% if locale.lang == 'cs' %}Name: "czech"; MessagesFile: "compiler:Languages\\Czech.isl"{% endif %}
{% if locale.lang == 'da' %}Name: "danish"; MessagesFile: "compiler:Languages\\Danish.isl"{% endif %}
{% if locale.lang == 'nl' %}Name: "dutch"; MessagesFile: "compiler:Languages\\Dutch.isl"{% endif %}
{% if locale.lang == 'fi' %}Name: "finnish"; MessagesFile: "compiler:Languages\\Finnish.isl"{% endif %}
{% if locale.lang == 'fr' %}Name: "french"; MessagesFile: "compiler:Languages\\French.isl"{% endif %}
{% if locale.lang == 'de' %}Name: "german"; MessagesFile: "compiler:Languages\\German.isl"{% endif %}
{% if locale.lang == 'he' %}Name: "hebrew"; MessagesFile: "compiler:Languages\\Hebrew.isl"{% endif %}
{% if locale.lang == 'is' %}Name: "icelandic"; MessagesFile: "compiler:Languages\\Icelandic.isl"{% endif %}
{% if locale.lang == 'it' %}Name: "italian"; MessagesFile: "compiler:Languages\\Italian.isl"{% endif %}
{% if locale.lang == 'ja' %}Name: "japanese"; MessagesFile: "compiler:Languages\\Japanese.isl"{% endif %}
{% if locale.lang == 'no' %}Name: "norwegian"; MessagesFile: "compiler:Languages\\Norwegian.isl"{% endif %}
{% if locale.lang == 'pl' %}Name: "polish"; MessagesFile: "compiler:Languages\\Polish.isl"{% endif %}
{% if locale.lang == 'pt' %}Name: "portuguese"; MessagesFile: "compiler:Languages\\Portuguese.isl"{% endif %}
{% if locale.lang == 'ru' %}Name: "russian"; MessagesFile: "compiler:Languages\\Russian.isl"{% endif %}
{% if locale.lang == 'sk' %}Name: "slovak"; MessagesFile: "compiler:Languages\\Slovak.isl"{% endif %}
{% if locale.lang == 'sl' %}Name: "slovenian"; MessagesFile: "compiler:Languages\\Slovenian.isl"{% endif %}
{% if locale.lang == 'es' %}Name: "spanish"; MessagesFile: "compiler:Languages\\Spanish.isl"{% endif %}
{% if locale.lang == 'tr' %}Name: "turkish"; MessagesFile: "compiler:Languages\\Turkish.isl"{% endif %}
{% if locale.lang == 'uk' %}Name: "ukrainian"; MessagesFile: "compiler:Languages\\Ukrainian.isl"{% endif %}
{% endfor %}

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: {% if CREATE_DESKTOP_ICON != true %}unchecked{% else %}checkedonce{% endif %}
[Files]
Source: "{{SOURCE_DIR}}\\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\\{{DISPLAY_NAME}}"; Filename: "{app}\\{{EXECUTABLE_NAME}}"
Name: "{autodesktop}\\{{DISPLAY_NAME}}"; Filename: "{app}\\{{EXECUTABLE_NAME}}"; Tasks: desktopicon
[Registry]
Root: HKA; Subkey: "Software\Classes\clash"; ValueType: string; ValueName: ""; ValueData: "URL:clash Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\clash"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\clash\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\clash\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\clashmeta"; ValueType: string; ValueName: ""; ValueData: "URL:clashmeta Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\clashmeta"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\clashmeta\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\clashmeta\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\flclash"; ValueType: string; ValueName: ""; ValueData: "URL:flclash Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\flclash"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\flclash\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\flclash\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\vless"; ValueType: string; ValueName: ""; ValueData: "URL:vless Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\vless"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\vless\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\vless\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\vmess"; ValueType: string; ValueName: ""; ValueData: "URL:vmess Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\vmess"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\vmess\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\vmess\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\ss"; ValueType: string; ValueName: ""; ValueData: "URL:ss Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\ss"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\ss\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\ss\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\trojan"; ValueType: string; ValueName: ""; ValueData: "URL:trojan Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\trojan"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\trojan\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\trojan\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\hysteria2"; ValueType: string; ValueName: ""; ValueData: "URL:hysteria2 Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\hysteria2"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\hysteria2\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\hysteria2\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\hy2"; ValueType: string; ValueName: ""; ValueData: "URL:hy2 Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\hy2"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\hy2\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\hy2\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\tuic"; ValueType: string; ValueName: ""; ValueData: "URL:tuic Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\tuic"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\tuic\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\tuic\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\anytls"; ValueType: string; ValueName: ""; ValueData: "URL:anytls Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\anytls"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\anytls\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\anytls\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\socks"; ValueType: string; ValueName: ""; ValueData: "URL:socks Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\socks"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\socks\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\socks\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\socks5"; ValueType: string; ValueName: ""; ValueData: "URL:socks5 Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\socks5"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\socks5\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\socks5\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\socks4"; ValueType: string; ValueName: ""; ValueData: "URL:socks4 Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\socks4"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\socks4\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\socks4\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\socks4a"; ValueType: string; ValueName: ""; ValueData: "URL:socks4a Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\socks4a"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKA; Subkey: "Software\Classes\socks4a\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{{EXECUTABLE_NAME}},0"
Root: HKA; Subkey: "Software\Classes\socks4a\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{{EXECUTABLE_NAME}}"" ""%1"""
[Run]
Filename: "{app}\\{{EXECUTABLE_NAME}}"; Description: "{cm:LaunchProgram,{{DISPLAY_NAME}}}"; Flags: {% if PRIVILEGES_REQUIRED == 'admin' %}runascurrentuser{% endif %} nowait postinstall skipifsilent

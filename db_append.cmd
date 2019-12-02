@if (@CodeSection == @Batch) @then
@echo off
setlocal
if defined VULCAN_EXE goto VULCAN_OK
for /f "delims=" %%I in ('cscript /nologo /e:JScript "%~f0" "HKLM\Software\Classes\TypeLib\{322858FC-9F41-416D-85DC-610C70A51111}\3.0\HELPDIR\"') do set VULCAN_EXE=%%I
set VULCAN_BIN=%VULCAN_EXE:~0,-4%
set VULCAN=%VULCAN_EXE:~0,-8%
set PATH=%VULCAN_EXE%;%VULCAN_BIN%;%VULCAN_BIN%cygnus\bin;%VULCAN_BIN%other\x86;%PATH%
set PERLLIB=%VULCAN%lib\perl;%VULCAN%lib\perl\site\lib
set VULCAN_VERSION_MAJOR=10
:VULCAN_OK
if exist %~dpn0.py goto CLIENT_PY
"%VULCAN_EXE%python.exe" -m _gui "%~n0"
if errorlevel 1 python -c "from tkinter.messagebox import showerror; showerror(message='_gui.py not found or outdated');"
goto :EOF
:CLIENT_PY
"%VULCAN_EXE%python.exe" %~dpn0.py
goto :EOF
@end
//!cscript
// Custom launcher to call the Vulcan Python
// Detects vulcan exe location on windows registry

function reg(strMethod, objParams) {
    try {
        var winmgmts = GetObject('winmgmts:root\\default'),
            StdRegProv = winmgmts.Get('StdRegProv');
            params = StdRegProv.Methods_(strMethod).InParameters.SpawnInstance_();

        for (var i in objParams) params[i] = objParams[i];
        return winmgmts.ExecMethod('StdRegProv', strMethod, params);
    }
    catch(e) { return {'sValue':''} }
};

var hiveConst = {
        "HKCR" : 2147483648,
        "HKCU" : 2147483649,
        "HKLM" : 2147483650,
        "HKU" : 2147483651,
        "HKCC" : 2147483653
    },
    methodConst = {
        "1" : "GetStringValue",
        "2" : "GetExpandedStringValue",
        "3" : "GetBinaryValue",
        "4" : "GetDWORDValue",
        "7" : "GetMultiStringValue",
        "11" : "GetQWORDValue"
    },
    regpath = WSH.Arguments(0).split('\\'),
    hive = hiveConst[regpath.shift()],
    leaf = regpath.pop(),
    regpath = regpath.join('\\');

if (/^\(Default\)$/.test(leaf)) leaf = '';

// get data type of leaf (default: string)
try {
    var params = {'hDefKey': hive, 'sSubKeyName': regpath},
        res = reg('EnumValues', params),
        sNames = res.sNames.toArray(),
        Types = res.Types.toArray();

    for (var i in sNames) {
        if (sNames[i] == leaf) var method = methodConst[Types[i]];
    }
}
catch(e) { var method = methodConst[1] }

// get and output data value of leaf
var params = {'hDefKey': hive, 'sSubKeyName': regpath, 'sValueName': leaf}, res = reg(method, params);
if (res.ReturnValue == 0) {
    WScript.Echo(res.sValue)
}

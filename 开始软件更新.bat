@echo off
title Windows 11 开始更新工具，欢迎回来！广告招租:baize邮箱，用过都说好
echo 正在请求管理员权限...
net session >nul 2>&1
if %errorlevel% neq 0 (
powershell Start-Process cmd -ArgumentList '/c "%~f0"' -Verb RunAs
exit /b
)

echo 正在恢复 Windows Update 服务启动类型...
sc config wuauserv start= auto >nul 2>&1
sc config bits start= auto >nul 2>&1
sc config UsoSvc start= auto >nul 2>&1
sc config WaaSMedicSvc start= auto >nul 2>&1

echo 正在移除阻止更新的注册表策略...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /f >nul 2>&1

echo 正在启动核心更新服务...
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

echo.
echo [完成] Windows 更新已恢复。
echo 请重启电脑，之后可前往“设置”手动检查更新。软件由xiongbinqi编写，完全免费。请于安装24小时内删除，不要分享传播。
pause
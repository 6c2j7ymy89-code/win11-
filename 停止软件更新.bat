@echo off
title Windows 11 停止更新工具，不建议开发者或用户开启此功能，请您在开启之前确认您有能力处理由此带来的未知后果
echo 正在请求管理员权限...
net session >nul 2>&1
if %errorlevel% neq 0 (
powershell Start-Process cmd -ArgumentList '/c "%~f0"' -Verb RunAs
exit /b
)

echo 正在停止并禁用 Windows Update 相关服务...
for %%i in (wuauserv UsoSvc BITS WaaSMedicSvc) do (
net stop %%i >nul 2>&1
sc config %%i start= disabled >nul 2>&1
)

echo 正在修改注册表以阻止自动更新...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo [完成] Windows 自动更新已停止并禁用。
echo 建议重启电脑使所有设置完全生效。软件由xiongbinqi编写，完全免费。请于安装24小时内删除，不要分享传播。
pause

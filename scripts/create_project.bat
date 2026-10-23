@echo off
setlocal
cd /d "%~dp0"

echo ==============================================================================
echo Creating Official Vivado Project (.xpr)...
echo ==============================================================================
call C:\Xilinx\Vivado\2019.2\bin\vivado.bat -mode batch -source create_vivado_project.tcl -notrace -nolog -nojournal
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Vivado project creation failed.
    exit /b %ERRORLEVEL%
)

echo.
echo Vivado project created successfully in ../vivado_project/
exit /b 0

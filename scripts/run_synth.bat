@echo off
setlocal
cd /d "%~dp0"

echo ==============================================================================
echo Running Vivado Synthesis...
echo ==============================================================================
call C:\Xilinx\Vivado\2019.2\bin\vivado.bat -mode batch -source run_synthesis.tcl -notrace -nolog -nojournal
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Vivado synthesis failed.
    exit /b %ERRORLEVEL%
)

echo.
echo Vivado synthesis completed successfully! Check reports/ folder.
exit /b 0

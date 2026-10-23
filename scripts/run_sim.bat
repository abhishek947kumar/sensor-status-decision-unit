@echo off
setlocal
cd /d "%~dp0\..\sim"

echo ==============================================================================
echo Running Vivado XVLOG (Verilog Compilation)...
echo ==============================================================================
call C:\Xilinx\Vivado\2019.2\bin\xvlog.bat --nolog ..\src\sensor_decision_unit.v ..\tb\tb_sensor_decision_unit.v
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] xvlog compilation failed.
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================================================
echo Running Vivado XELAB (Elaboration)...
echo ==============================================================================
call C:\Xilinx\Vivado\2019.2\bin\xelab.bat --nolog -debug typical tb_sensor_decision_unit -s tb_sim
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] xelab elaboration failed.
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================================================
echo Running Vivado XSIM (Simulation Execution)...
echo ==============================================================================
call C:\Xilinx\Vivado\2019.2\bin\xsim.bat --nolog tb_sim -R
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] xsim execution failed.
    exit /b %ERRORLEVEL%
)

echo.
echo Simulation finished successfully.
exit /b 0

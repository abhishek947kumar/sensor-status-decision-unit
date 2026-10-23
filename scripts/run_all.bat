@echo off
setlocal
cd /d "%~dp0"

echo ==============================================================================
echo [STEP 1/3] Running Vivado Verilog Simulation (xsim)
echo ==============================================================================
call run_sim.bat
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Simulation step failed!
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================================================
echo [STEP 2/3] Creating Vivado Project (.xpr)
echo ==============================================================================
call create_project.bat
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Project creation step failed!
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================================================
echo [STEP 3/3] Running Vivado Synthesis and Utilization Analysis
echo ==============================================================================
call run_synth.bat
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Synthesis step failed!
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================================================
echo ALL VIVADO PROJECT STEPS COMPLETED SUCCESSFULLY!
echo ==============================================================================
exit /b 0

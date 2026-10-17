@echo off
setlocal
cd /d "%~dp0"
echo ================================================
echo        ELECTROCARE - KHOI DONG HE THONG
echo ================================================
echo.
echo [1] Dang khoi dong Backend tai http://localhost:3000
start "ElectroCare Backend" cmd /k "cd /d "%~dp0may-chu" && npm start"
timeout /t 2 /nobreak >nul
echo [2] Dang khoi dong Giao dien tai http://localhost:5173
start "ElectroCare Frontend" cmd /k "cd /d "%~dp0giao-dien" && npm run dev"
echo.
echo Website: http://localhost:5173
echo API Health: http://localhost:3000/api/health
echo.
echo Hai cua so Backend va Frontend phai duoc giu mo.
echo Neu muon dung he thong, dong hai cua so server do.
pause

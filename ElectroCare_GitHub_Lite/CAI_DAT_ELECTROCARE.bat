@echo off
setlocal
cd /d "%~dp0"
echo ================================================
echo        ELECTROCARE - CAI DAT DU AN
echo ================================================
where node >nul 2>nul
if errorlevel 1 (
  echo [LOI] Chua cai Node.js. Hay cai Node.js 18+ truoc.
  pause
  exit /b 1
)
where npm >nul 2>nul
if errorlevel 1 (
  echo [LOI] Khong tim thay npm.
  pause
  exit /b 1
)
echo.
echo [1/2] Cai thu vien Backend...
call npm --prefix may-chu install
if errorlevel 1 goto :error
echo.
echo [2/2] Kiem tra phan giao dien...
call npm --prefix giao-dien run build
if errorlevel 1 goto :error
echo.
echo [OK] Cai dat va build hoan tat.
echo Hay bat Apache + MySQL trong XAMPP, sau do chay CHAY_ELECTROCARE.bat
pause
exit /b 0
:error
echo.
echo [LOI] Cai dat that bai. Kiem tra ket noi mang va Node.js.
pause
exit /b 1

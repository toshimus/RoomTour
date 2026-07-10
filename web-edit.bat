@echo off
setlocal
chcp 65001 >nul

:: バッチファイルがあるディレクトリを基準にする
set "BASE_DIR=%~dp0"

:: パスを環境変数に設定
set "PYTHON_DIR=%BASE_DIR%python-3.14.6-embed-amd64"
set "TARGET_DIR=%BASE_DIR%360"

:: Python実行ファイルの確認
if not exist "%PYTHON_DIR%\python.exe" (
    echo [エラー] Pythonが見つかりません: %PYTHON_DIR%
    pause
    exit /b
)

:: 公開フォルダの確認
if not exist "%TARGET_DIR%" (
    echo [エラー] フォルダが見つかりません: %TARGET_DIR%
    pause
    exit /b
)

echo サーバーを起動しています...
echo ブラウザが自動的に開きます。
echo.
echo 停止するには、このウィンドウを閉じてください。

:: サーバーの起動
:: startコマンドで別ウィンドウとして起動し、現在のバッチが終了してもサーバーが維持されるように調整
start "LocalWebServer" "%PYTHON_DIR%\python.exe" -m http.server 8000 --directory "%TARGET_DIR%"

:: サーバー起動待ち
timeout /t 2 >nul

:: ブラウザで開く
start http://localhost:8000/editor.html

:: ウィンドウが閉じないように待機
pause

:: ウィンドウが閉じられたらサーバープロセスを終了させる
taskkill /F /FI "WINDOWTITLE eq LocalWebServer" >nul 2>&1
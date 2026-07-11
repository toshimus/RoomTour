@echo off
rem サーバー用フォルダへ移動（適宜パスを変更してください）
cd /d "C:\Users\TAMA-2F\Desktop\360\RoomTour-main"

rem ブラウザでエディタ(editor.html)を直接開く
start http://localhost:8000/editor-v3.html

rem Pythonサーバーを起動
python -m http.server 8000

pause
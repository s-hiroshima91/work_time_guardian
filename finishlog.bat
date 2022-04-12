@echo off

REM 日付をyyyy/mm/dd形式で取得する
set d=%date%

REM 日付を年、月、日に分解する
set yyyy=%d:~-10,4%
set mmt=%d:~-5,2%
set dd=%d:~-2,2%

REM 月の頭の0をとる
set /a mm=1%mmt%-100

REM 時間をhh:mn:ss形式で取得する
set t=%time: =0%

REM 時間を時、分、秒に分解する
set hh=%t:~0,2%
set mn=%t:~3,2%
set ss=%t:~6,2%

REM 今日の開始時間を取得する
for /f "tokens=2-3 delims=,:" %%a in (C:\残業時間\%yyyy%年%mm%月分.csv) do (
set a=%%a
set b=%%b

)

REM 今日の残業時間を計算する
set /a ot=(1%hh%-100)*60+(1%mn%-100)-((1%a%-100)*60+(1%b%-100))-9*60

REM ファイル名を一時的に変更する
Ren C:\残業時間\%yyyy%年%mm%月分.csv %yyyy%年%mm%月分_temp.csv

REM 今日分のログを削除する
find /v "eee" <C:\残業時間\%yyyy%年%mm%月分_temp.csv >C:\残業時間\%yyyy%年%mm%月分.csv

REM 今日の実績を書き込む
(echo %dd%,%a%:%b%,%hh%:%mn%,%ot%) >> C:\残業時間\%yyyy%年%mm%月分.csv

REM 一時ファイルを削除する
del C:\残業時間\%yyyy%年%mm%月分_temp.csv

REM シャットダウンする

shutdown.exe /s /t 0

REM 時刻表から飛ばしてきた場合は
REM shutdownをコメントにしてexit /bを生かす。

REM exit /b

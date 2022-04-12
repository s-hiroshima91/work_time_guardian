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

REM 今月分のファイルの有無を確認する
if not exist C:\残業時間\%yyyy%年%mm%月分.csv GOTO NEXTMONTH

REM 最後の行の一列目を取得する
for /f "tokens=1 delims=," %%a in (C:\残業時間\%yyyy%年%mm%月分.csv) do (
set a=%%a
)

REM 当日二回目以降の起動の場合は処理を飛ばす
If %dd%==%a% (
GOTO END
)

REM 前日までの残業時間を計算する
set b=0
for /f "tokens=6 delims=,:" %%a in (C:\残業時間\%yyyy%年%mm%月分.csv) do (
set /a b=%%a+b
)
set /a hour=%b%/60
set /a min=%b%%%60

echo "今月の累計残業時間は"%hour%"時間"%min%"分です。"

GOTO NEXT

:NEXTMONTH
REM ファイルとラベルの作成
(echo 日,開始時間,終了時間,残業時間,0,0) >> C:\残業時間\%yyyy%年%mm%月分.csv

REM 先月の残業時間を計算する
set /a mmp=%mm%-1
set yyyp=%yyyy%

REM 12月の場合の処理を行う
if %mmp%==0 (
set /a mmp=%mmp%+12
set /a yyyp=%yyyp%-1
)

REM 先月の残業時間を計算する(続き)
set b=0
for /f "tokens=6 delims=,:" %%a in (C:\残業時間\%yyyp%年%mmp%月分.csv) do (
set /a b=%%a+b
)
set /a hour=%b%/60
set /a min=%b%%%60

echo "先月の累計残業時間は"%hour%"時間"%min%"分です。"
(echo ,,,累計残業時間,%hour%時間%min%分) >> C:\残業時間\%yyyp%年%mmp%月分.csv

GOTO NEXT

:NEXT

REM 日付、時間の出力
(echo %dd%,%hh%:%mn%,eee) >> C:\残業時間\%yyyy%年%mm%月分.csv
pause


:END
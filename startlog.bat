@echo off

REM ���t��yyyy/mm/dd�`���Ŏ擾����
set d=%date%

REM ���t��N�A���A���ɕ�������
set yyyy=%d:~-10,4%
set mmt=%d:~-5,2%
set dd=%d:~-2,2%

REM ���̓���0���Ƃ�
set /a mm=1%mmt%-100

REM ���Ԃ�hh:mn:ss�`���Ŏ擾����
set t=%time: =0%

REM ���Ԃ����A���A�b�ɕ�������
set hh=%t:~0,2%
set mn=%t:~3,2%
set ss=%t:~6,2%

REM �������̃t�@�C���̗L�����m�F����
if not exist C:\�c�Ǝ���\%yyyy%�N%mm%����.csv GOTO NEXTMONTH

REM �Ō�̍s�̈��ڂ��擾����
for /f "tokens=1 delims=," %%a in (C:\�c�Ǝ���\%yyyy%�N%mm%����.csv) do (
set a=%%a
)

REM �������ڈȍ~�̋N���̏ꍇ�͏������΂�
If %dd%==%a% (
GOTO END
)

REM �O���܂ł̎c�Ǝ��Ԃ��v�Z����
set b=0
for /f "tokens=6 delims=,:" %%a in (C:\�c�Ǝ���\%yyyy%�N%mm%����.csv) do (
set /a b=%%a+b
)
set /a hour=%b%/60
set /a min=%b%%%60

echo "�����̗݌v�c�Ǝ��Ԃ�"%hour%"����"%min%"���ł��B"

GOTO NEXT

:NEXTMONTH
REM �t�@�C���ƃ��x���̍쐬
(echo ��,�J�n����,�I������,�c�Ǝ���,0,0) >> C:\�c�Ǝ���\%yyyy%�N%mm%����.csv

REM �挎�̎c�Ǝ��Ԃ��v�Z����
set /a mmp=%mm%-1
set yyyp=%yyyy%

REM 12���̏ꍇ�̏������s��
if %mmp%==0 (
set /a mmp=%mmp%+12
set /a yyyp=%yyyp%-1
)

REM �挎�̎c�Ǝ��Ԃ��v�Z����(����)
set b=0
for /f "tokens=6 delims=,:" %%a in (C:\�c�Ǝ���\%yyyp%�N%mmp%����.csv) do (
set /a b=%%a+b
)
set /a hour=%b%/60
set /a min=%b%%%60

echo "�挎�̗݌v�c�Ǝ��Ԃ�"%hour%"����"%min%"���ł��B"
(echo ,,,�݌v�c�Ǝ���,%hour%����%min%��) >> C:\�c�Ǝ���\%yyyp%�N%mmp%����.csv

GOTO NEXT

:NEXT

REM ���t�A���Ԃ̏o��
(echo %dd%,%hh%:%mn%,eee) >> C:\�c�Ǝ���\%yyyy%�N%mm%����.csv
pause


:END
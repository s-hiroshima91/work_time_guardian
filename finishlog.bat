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

REM �����̊J�n���Ԃ��擾����
for /f "tokens=2-3 delims=,:" %%a in (C:\�c�Ǝ���\%yyyy%�N%mm%����.csv) do (
set a=%%a
set b=%%b

)

REM �����̎c�Ǝ��Ԃ��v�Z����
set /a ot=(1%hh%-100)*60+(1%mn%-100)-((1%a%-100)*60+(1%b%-100))-9*60

REM �t�@�C�������ꎞ�I�ɕύX����
Ren C:\�c�Ǝ���\%yyyy%�N%mm%����.csv %yyyy%�N%mm%����_temp.csv

REM �������̃��O���폜����
find /v "eee" <C:\�c�Ǝ���\%yyyy%�N%mm%����_temp.csv >C:\�c�Ǝ���\%yyyy%�N%mm%����.csv

REM �����̎��т���������
(echo %dd%,%a%:%b%,%hh%:%mn%,%ot%) >> C:\�c�Ǝ���\%yyyy%�N%mm%����.csv

REM �ꎞ�t�@�C�����폜����
del C:\�c�Ǝ���\%yyyy%�N%mm%����_temp.csv

REM �V���b�g�_�E������

shutdown.exe /s /t 0

REM �����\�����΂��Ă����ꍇ��
REM shutdown���R�����g�ɂ���exit /b�𐶂����B

REM exit /b

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: chm�ļ��������� V1.3
:: code by namejm 2007.12.27��2010.4.9 bbs.bathome.net CMD@XP
::
:: ���ܣ�
::     ����/����������chm�ļ�����������Դ��ԭʼ�ṹ��
:: ʹ�÷�ʽ�����֣�
::     �� �ѵ��������ļ�ֱ���Ϸŵ�������
::     �� ֱ��˫�����С���ʱ������ǵ�ǰĿ¼��������.chmΪ��׺���ļ�
:: ִ�й��̼�����Ч����
::     ��Ϊ hh -decompile ��䲻��ʹ�����ţ����ԣ��Ȱ�ԭʼ��Դ�ͷŵ�
:: ���ļ�����ʽ���ļ����У��ͷ���Ϻ��ٸ�����
::     ����ִ�з�ʽ���м򵥵��ݴ�������������Դ���ڵ������ļ���
:: �У����ļ���λ�ڵ�ǰĿ¼������chm�ļ���������
::    �޷�ʶ����.chmΪ��׺����chm�ļ������ǿ���ʶ����.chmΪ��׺��
::�������ļ���ò���е��ֿ�^_^��
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
set TT=chm�ļ��������� 1.3
echo.&echo.&echo         ���ڷ�����CHM�ļ������Ժ�...
cd /d "%~dp0"
:: ���϶��ļ����������ļ��ϵķ�ʽ����������ʱ��%cd% ��ֵ����ǿ��ת��Ϊ
:: %homepath%����ˣ���һ�����ǳ��ؼ���
set "destination=chm�ļ���������"
for /f "delims=" %%i in ("%destination%") do set "destination_short=%%~sfi"
md "%destination%" 2>nul
del /a /f "%destination%\αchm�ļ��б�.txt" 2>nul
if "%~1"=="" goto All

:Some
set str=%*
set "str=%str:"=%"
set "str= %str%"
call set "str=%%str: %~d1=" "%~d1%%"
for %%i in ("%str%") do (
    if not %%i=="" (
        title %TT%-���ڴ���"%%~nxi"
        if /i not "%%~xi"==".chm" (
            echo.&echo         "%%~nxi"����chm�ļ�
            echo.&echo         �밴���������...
            pause>nul
            cls
            echo.&echo.&echo         ���ڷ�����CHM�ļ������Ժ�...
        ) else (
            rd /q /s "%%~ni" 2>nul
            hh -decompile %destination_short%\%%~sni %%~sfi
            if not exist "%destination%\%%~sni" (
                echo "%%~nxi">>"%destination%\αchm�ļ��б�.txt"
            ) else (
                ren "%destination%\%%~sni" "%%~ni" 2>nul
            )
        )
    )
)
exit

:All
for /f "delims=" %%i in ('dir /a-d /b *.chm 2^>nul') do (
    title %TT%-���ڴ���"%%~nxi"
    rd /q /s "%destination%\%%~ni" 2>nul
    hh -decompile %destination_short%\%%~sni %%~sfi
    if not exist "%destination%\%%~sni" (
        echo "%%~nxi">>"%destination%\αchm�ļ��б�.txt"
    ) else (
        ren "%destination%\%%~sni" "%%~ni" 2>nul
    ) 
)
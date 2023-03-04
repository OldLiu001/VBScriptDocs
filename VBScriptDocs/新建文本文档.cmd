::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: chm文件反编译器 V1.3
:: code by namejm 2007.12.27～2010.4.9 bbs.bathome.net CMD@XP
::
:: 功能：
::     单个/批量反编译chm文件，并保持资源的原始结构。
:: 使用方式有两种：
::     ① 把单个或多个文件直接拖放到本程序。
::     ② 直接双击运行。此时处理的是当前目录下所有以.chm为后缀的文件
:: 执行过程及处理效果：
::     因为 hh -decompile 语句不能使用引号，所以，先把原始资源释放到
:: 短文件名格式的文件夹中，释放完毕后再改名；
::     两种执行方式都有简单的容错处理；反编译后的资源放在单独的文件夹
:: 中，此文件夹位于当前目录，并以chm文件名命名。
::    无法识别不以.chm为后缀名的chm文件，但是可以识别以.chm为后缀名
::的其他文件（貌似有点拗口^_^）
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
set TT=chm文件反编译器 1.3
echo.&echo.&echo         正在反编译CHM文件，请稍候...
cd /d "%~dp0"
:: 以拖动文件到批处理文件上的方式运行批处理时，%cd% 的值将会强制转换为
:: %homepath%，因此，上一条语句非常关键！
set "destination=chm文件反编译结果"
for /f "delims=" %%i in ("%destination%") do set "destination_short=%%~sfi"
md "%destination%" 2>nul
del /a /f "%destination%\伪chm文件列表.txt" 2>nul
if "%~1"=="" goto All

:Some
set str=%*
set "str=%str:"=%"
set "str= %str%"
call set "str=%%str: %~d1=" "%~d1%%"
for %%i in ("%str%") do (
    if not %%i=="" (
        title %TT%-正在处理"%%~nxi"
        if /i not "%%~xi"==".chm" (
            echo.&echo         "%%~nxi"不是chm文件
            echo.&echo         请按任意键继续...
            pause>nul
            cls
            echo.&echo.&echo         正在反编译CHM文件，请稍候...
        ) else (
            rd /q /s "%%~ni" 2>nul
            hh -decompile %destination_short%\%%~sni %%~sfi
            if not exist "%destination%\%%~sni" (
                echo "%%~nxi">>"%destination%\伪chm文件列表.txt"
            ) else (
                ren "%destination%\%%~sni" "%%~ni" 2>nul
            )
        )
    )
)
exit

:All
for /f "delims=" %%i in ('dir /a-d /b *.chm 2^>nul') do (
    title %TT%-正在处理"%%~nxi"
    rd /q /s "%destination%\%%~ni" 2>nul
    hh -decompile %destination_short%\%%~sni %%~sfi
    if not exist "%destination%\%%~sni" (
        echo "%%~nxi">>"%destination%\伪chm文件列表.txt"
    ) else (
        ren "%destination%\%%~sni" "%%~ni" 2>nul
    ) 
)
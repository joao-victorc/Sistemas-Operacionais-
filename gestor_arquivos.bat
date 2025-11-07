@echo off
title Gestor de Arquivos Simples
setlocal enabledelayedexpansion

:: =======================================
:: CONFIGURAÇÕES INICIAIS
:: =======================================
set "BASE=%~dp0GestorArquivosSimples"
set "DOCS=%BASE%\Documentos"
set "LOGS=%BASE%\Logs"
set "BACKUPS=%BASE%\Backups"
set "LOG=%LOGS%\atividade.log"
set "RESUMO=%BASE%\resumo_execucao.txt"

set /a pastas_criadas=0
set /a arquivos_criados=0

cls
echo ==========================================
echo     BEM-VINDO AO GESTOR DE ARQUIVOS
echo ==========================================
echo.
echo Este programa vai criar pastas, arquivos,
echo fazer um backup e gerar um relatorio final.
echo.
pause




:: =======================================
:: 1. CRIAR AS PASTAS (todas dentro de BASE)
:: =======================================
echo Criando as pastas...
echo ------------------------------

for %%p in ("%BASE%" "%DOCS%" "%LOGS%" "%BACKUPS%") do (
    if not exist "%%~p" (
        mkdir "%%~p"
        echo Pastas criadas com sucesso
        set /a pastas_criadas+=1
        call :registrar "Criacao da pasta %%~p" "Sucesso"
    ) else (
        echo A pasta ja existe: %%~p
        call :registrar "Verificacao da pasta %%~p" "Ja existia"
    )
)
echo.
pause

:: =======================================
:: 2. CRIAR OS ARQUIVOS (dentro de DOCS)
:: =======================================
echo Criando os arquivos dentro de Documentos...
echo ------------------------------

(
    echo Este e um relatorio simples.
    echo Criado automaticamente pelo Gestor de Arquivos.
    echo Data: %date%
    echo Hora: %time%
) > "%DOCS%\relatorio.txt"
set /a arquivos_criados+=1
call :registrar "Criacao do arquivo relatorio.txt" "Sucesso"

(
    echo id,nome,idade
    echo 1,Joao,20
    echo 2,Maria,22
) > "%DOCS%\dados.csv"
set /a arquivos_criados+=1
call :registrar "Criacao do arquivo dados.csv" "Sucesso"

(
    echo [Configuracoes]
    echo modo=automatico
    echo versao=1.0
) > "%DOCS%\config.ini"
set /a arquivos_criados+=1
call :registrar "Criacao do arquivo config.ini" "Sucesso"

echo Todos os arquivos foram criados com sucesso!
echo.
echo Local: "Documentos\GestorArquivos"
echo.
pause

:: =======================================
:: 3. FAZER O BACKUP (tudo dentro da BASE)
:: =======================================
echo Fazendo copia de backup...
echo ------------------------------

(
echo BACKUP REALIZADO COM SUCESSO
echo. 
echo Data do Backup: %date%
echo Hora do Backup: %time%
echo.
echo Arquivos incluidos no backup:
echo - relatorio.txt
echo - dados.csv  
echo - config.ini
echo.
echo Local: %BACKUPS%
echo.
echo * BACKUP COMPLETO *
)

xcopy "%DOCS%\*" "%BACKUPS%\" /Y >nul
if !errorlevel! equ 0 (
    echo Backup feito com sucesso!
    call :registrar "Backup dos arquivos" "Sucesso"
) else (
    echo Ocorreu um erro ao fazer o backup.
    call :registrar "Backup dos arquivos" "Falha"
)

(
    echo * BACKUP COMPLETO *
    echo Data: %date%
    echo Hora: %time%
) > "%BACKUPS%\backup_completo.bak"
set /a arquivos_criados+=1
call :registrar "Criacao do arquivo backup_completo.bak" "Sucesso"

if !errorlevel! equ 0 (
    echo Ocorreu um erro ao criar o arquivo backup_completo.bak
)



echo Backup salvo em: "%BACKUPS%"
echo.
pause

:: =======================================
:: 4. GERAR RELATORIO FINAL
:: =======================================
echo Gerando relatorio final...
echo ------------------------------

(
    echo RELATORIO DE EXECUCAO
    echo ----------------------
    echo Total de pastas criadas: %pastas_criadas%
    echo Total de arquivos criados: %arquivos_criados%
    echo Data/Hora do backup: %DATA_BACKUP%
    echo.
    echo Todos os dados foram salvos em:
    echo %BASE%
) > "%RESUMO%"

call :registrar "Geracao do relatorio resumo_execucao.txt" "Sucesso"

echo Relatorio final criado com sucesso!
echo Local: %RESUMO%
echo.
pause

:: =======================================
:: FIM
:: =======================================
echo ==========================================
echo          TUDO PRONTO! 
echo ==========================================
echo Todas as pastas, arquivos e backup foram criados.
echo Verifique os logs e relatorios em:
echo %BASE%
echo.
pause
exit /b

:registrar
set "datahora=%date% %time%"
echo [%datahora%] - %~1 - %~2 >> "%LOG%"
exit /b
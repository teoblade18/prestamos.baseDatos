@echo off
@echo Ejecutando mi SQL SP

(
echo exec dbo.actualizar_prestamo_fechaCorte
) | SQLCMD -S bd-lenderapp.mssql.somee.com -d bd-lenderapp -U "teoblade18_SQLLogin_1" -P "8vznmzm8w9" 2>&1 | findstr /V "^$"

REM Configuración del tiempo de espera
set SCM_COMMAND_IDLE_TIMEOUT=300
USE [bd-lenderapp]
GO
/****** Object:  Trigger [dbo].[adiciona_abonos]    Script Date: 3/14/2024 2:26:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[adiciona_abonos]
ON [dbo].[Abonos] FOR INSERT,DELETE AS
BEGIN
	DECLARE @idPrestamo as INT
	DECLARE @valor as INT
	DECLARE @esInsert as INT

	DECLARE @idPrestamista as INT


	SET @esInsert = (select COUNT(*) from inserted)

	IF @esInsert > 0 BEGIN
		set @idPrestamo = (select idPrestamo from inserted)
		set @valor = (select valor from inserted)
		SET @idPrestamista = (select idPrestamista from Prestamos where idPrestamo = @idPrestamo)

		--Cambia el estado del prestamo a abonado cuando recibe un abono y modifica el montoReal
		update Prestamos set montoReal = montoReal - @valor, estado = 'Abonado'
		where idPrestamo = @idPrestamo

		update Prestamistas set capital = capital + @valor where idPrestamista = @idPrestamista

		--Cambia el estado del prestamo a pagado, en caso de que el montoReal sea 0 o menor
		IF (SELECT montoReal FROM Prestamos WHERE idPrestamo = @idPrestamo) <= 0
		BEGIN
			UPDATE Prestamos SET estado = 'Pagado', fechaFinal = GETDATE() WHERE idPrestamo = @idPrestamo
		END

	END
	ELSE
	BEGIN
		set @idPrestamo = (select idPrestamo from deleted)
		set @valor = (select valor from deleted)
		SET @idPrestamista = (select idPrestamista from Prestamos where idPrestamo = @idPrestamo)

		update Prestamos set montoReal = montoReal + @valor
		where idPrestamo = @idPrestamo

		update Prestamistas set capital = capital - @valor where idPrestamista = @idPrestamista
	END
END


GO
/****** Object:  Trigger [dbo].[adiciona_interes]    Script Date: 3/1/2024 1:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[adiciona_interes]
ON [dbo].[Intereses] FOR INSERT,DELETE AS
BEGIN
	DECLARE @idPrestamo as INT
	DECLARE @valor as INT
	DECLARE @esInsert as INT

	SET @esInsert = (select COUNT(*) from inserted)

	IF @esInsert > 0 
	BEGIN
		set @idPrestamo = (select idPrestamo from inserted)
		set @valor = (select valor from inserted)

		update Prestamos set montoReal = montoReal + @valor
		where idPrestamo = @idPrestamo
	END
	ELSE
	BEGIN
		set @idPrestamo = (select idPrestamo from deleted)
		set @valor = (select valor from deleted)

		update Prestamos set montoReal = montoReal - @valor
		where idPrestamo = @idPrestamo
	END
	
END


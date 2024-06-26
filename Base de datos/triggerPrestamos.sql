GO
/****** Object:  Trigger [dbo].[primer_intereres_prestamo]    Script Date: 3/14/2024 1:57:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[primer_intereres_prestamo]
ON [dbo].[Prestamos] FOR INSERT AS
BEGIN
	DECLARE @idPrestamo as INT
	DECLARE @montoInicial as INT
	DECLARE @porcentaje as INT
	DECLARE @idPrestamista as INT
	DECLARE @fechaPrestamo as DATE

	DECLARE @valorInteres as INT

	SELECT @idPrestamo = idPrestamo,
       @montoInicial = montoInicial,
       @porcentaje = porcentaje,
       @fechaPrestamo = fechaInicial,
       @idPrestamista = idPrestamista
	FROM inserted;
	
	set @valorInteres = ((@montoInicial * @porcentaje) / 100)

	insert Intereses (idPrestamo,fecha,valor,tipo) values (@idPrestamo,@fechaPrestamo, @valorInteres, 'Estandar')
	update Prestamistas set capital = capital - @montoInicial where idPrestamista = @idPrestamista

END


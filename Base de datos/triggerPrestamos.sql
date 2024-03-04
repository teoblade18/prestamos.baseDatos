USE [Proyecto_Prestamos]
GO
/****** Object:  Trigger [dbo].[primer_intereres_prestamo]    Script Date: 3/3/2024 12:23:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[primer_intereres_prestamo]
ON [dbo].[Prestamos] FOR INSERT AS
BEGIN
	DECLARE @idPrestamo as INT
	DECLARE @montoInicial as INT
	DECLARE @porcentaje as INT
	DECLARE @valorInteres as INT
	DECLARE @fechaPrestamo as DATE

	set @idPrestamo = (select idPrestamo from inserted)
	set @montoInicial = (select montoInicial from inserted)
	set @porcentaje = (select porcentaje from inserted)
	set @fechaPrestamo = (select fechaInicial from inserted)
	
	set @valorInteres = ((@montoInicial * @porcentaje) / 100)

	insert Intereses (idPrestamo,fecha,valor,tipo) values (@idPrestamo,@fechaPrestamo, @valorInteres, 'Estandar')
	
END


USE [bd-lenderapp]
GO
/****** Object:  StoredProcedure [dbo].[actualizar_prestamo_fechaCorte]    Script Date: 3/4/2024 11:36:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: Mateo Agudelo>
-- Create date: <Create Date: 02/03/2024>
-- Description:	<Description: Procedimiento para actualizar estados de prestamos y añadir intereses del mes>
-- =============================================
CREATE PROCEDURE [dbo].[actualizar_prestamo_fechaCorte]
	
AS
BEGIN
	Declare @fechaHoy AS DATE
	set @fechaHoy = GETDATE()

	Declare @fechaHoyMasMes AS DATE
	Set @fechaHoyMasMes = DATEADD(MONTH, 1, @fechaHoy)

	INSERT INTO Intereses (idPrestamo,fecha,valor,tipo)
	SELECT	p.idPrestamo, @fechaHoy as fecha, (p.montoReal * p.porcentaje / 100) as valor, 'Estandar' as tipo
	FROM Prestamos p
	WHERE p.estado = 'Abonado' and p.fechaProximoPago = @fechaHoy and p.tipoIntereses = 'Compuesto' and p.fechaPago <> @fechaHoy

	Update Prestamos set fechaProximoPago = @fechaHoyMasMes, estado = 'Impago' where estado = 'Abonado' and fechaProximoPago = @fechaHoy 

END

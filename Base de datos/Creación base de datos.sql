USE [bd-lenderapp]
GO
/****** Object:  Table [dbo].[Abonos]    Script Date: 2/29/2024 10:12:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abonos](
	[idAbono] [int] IDENTITY(1,1) NOT NULL,
	[idPrestamo] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[valor] [numeric](18, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idAbono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 2/29/2024 10:12:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[cedula] [varchar](50) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[puntaje] [numeric](18, 0) NULL,
	[idPrestamista] [int] NOT NULL,
	[maxPrestar] [numeric](18, 0) NULL,
	[numeroCuenta] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Intereses]    Script Date: 2/29/2024 10:12:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intereses](
	[idInteres] [int] IDENTITY(1,1) NOT NULL,
	[idPrestamo] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[valor] [numeric](18, 0) NOT NULL,
	[tipo] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idInteres] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestamistas]    Script Date: 2/29/2024 10:12:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestamistas](
	[idPrestamista] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[capital] [numeric](18, 0) NOT NULL,
	[numeroCuenta] [varchar](max) NULL,
	[idUsuario] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idPrestamista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestamos]    Script Date: 2/29/2024 10:12:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestamos](
	[idPrestamo] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[idPrestamista] [int] NOT NULL,
	[fechaInicial] [date] NOT NULL,
	[porcentaje] [numeric](18, 0) NOT NULL,
	[tipoIntereses] [varchar](30) NOT NULL,
	[diaCorte] [numeric](18, 0) NOT NULL,
	[montoInicial] [numeric](18, 0) NOT NULL,
	[montoReal] [numeric](18, 0) NULL,
	[fechaPago] [date] NOT NULL,
	[fechaProximoPago] [date] NOT NULL,
	[estado] [varchar](10) NOT NULL,
	[fechaFinal] [date] NULL
PRIMARY KEY CLUSTERED 
(
	[idPrestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 2/29/2024 10:12:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nombreUsuario] [nvarchar](max) NOT NULL,
	[contraseña] [nvarchar](max) NOT NULL,
	[email] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Prestamos] ADD  CONSTRAINT [DF_Prestamos_estado]  DEFAULT ('Abonado') FOR [estado]
GO
ALTER TABLE [dbo].[Abonos]  WITH CHECK ADD FOREIGN KEY([idPrestamo])
REFERENCES [dbo].[Prestamos] ([idPrestamo])
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD FOREIGN KEY([idPrestamista])
REFERENCES [dbo].[Prestamistas] ([idPrestamista])
GO
ALTER TABLE [dbo].[Intereses]  WITH CHECK ADD FOREIGN KEY([idPrestamo])
REFERENCES [dbo].[Prestamos] ([idPrestamo])
GO
ALTER TABLE [dbo].[Prestamistas]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[Prestamos]  WITH CHECK ADD FOREIGN KEY([idCliente])
REFERENCES [dbo].[Clientes] ([idCliente])
GO
ALTER TABLE [dbo].[Prestamos]  WITH CHECK ADD FOREIGN KEY([idPrestamista])
REFERENCES [dbo].[Prestamistas] ([idPrestamista])
GO

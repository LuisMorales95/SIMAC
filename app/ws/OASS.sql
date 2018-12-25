USE [master]
GO
/****** Object:  Database [OFICIO_ASSISTENTE]    Script Date: 25/12/2018 12:42:37 p. m. ******/
CREATE DATABASE [OFICIO_ASSISTENTE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OficioAssistente', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\OficioAssistente.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OficioAssistente_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\OficioAssistente_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OFICIO_ASSISTENTE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET ARITHABORT OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET  MULTI_USER 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET QUERY_STORE = OFF
GO
USE [OFICIO_ASSISTENTE]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [OFICIO_ASSISTENTE]
GO
/****** Object:  Table [dbo].[Circular]    Script Date: 25/12/2018 12:42:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Circular](
	[id_circular] [int] IDENTITY(1,1) NOT NULL,
	[cla_circular] [varchar](50) NULL,
	[nom_circular] [varchar](100) NULL,
	[asu_circular] [varchar](500) NULL,
	[ubi_circular] [varchar](500) NULL,
	[notas] [varchar](1000) NULL,
	[fk_id_departamento] [int] NULL,
	[fk_id_estado] [int] NULL,
	[fk_id_persona] [int] NULL,
	[DepEnviada] [varchar](100) NULL,
	[RutaCircularP] [varchar](400) NULL,
	[RutaCircularR] [varchar](400) NULL,
 CONSTRAINT [PK_Circular] PRIMARY KEY CLUSTERED 
(
	[id_circular] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 25/12/2018 12:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamento](
	[id_departamento] [int] IDENTITY(1,1) NOT NULL,
	[nom_departamento] [varchar](200) NOT NULL,
	[cla_departamento] [varchar](50) NULL,
	[ncla_departamento] [varchar](200) NULL,
 CONSTRAINT [PK_Departamento] PRIMARY KEY CLUSTERED 
(
	[id_departamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estado]    Script Date: 25/12/2018 12:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estado](
	[id_estado] [int] IDENTITY(1,1) NOT NULL,
	[nom_estado] [varchar](100) NULL,
 CONSTRAINT [PK_Estado] PRIMARY KEY CLUSTERED 
(
	[id_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Memoran]    Script Date: 25/12/2018 12:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Memoran](
	[id_memoran] [int] IDENTITY(1,1) NOT NULL,
	[cla_memoran] [varchar](50) NULL,
	[nom_memoran] [varchar](100) NULL,
	[asu_memoran] [varchar](500) NULL,
	[ubi_memoran] [varchar](500) NULL,
	[notas] [varchar](1000) NULL,
	[fk_id_departamento] [int] NULL,
	[fk_id_estado] [int] NULL,
	[fk_id_persona] [int] NULL,
	[DepEnviada] [varchar](100) NULL,
	[RutaMemoranP] [varchar](400) NULL,
	[RutaMemoranR] [varchar](400) NULL,
 CONSTRAINT [PK_Memoran] PRIMARY KEY CLUSTERED 
(
	[id_memoran] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Oficio]    Script Date: 25/12/2018 12:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Oficio](
	[id_oficio] [int] IDENTITY(1,1) NOT NULL,
	[cla_oficio] [varchar](50) NULL,
	[nom_oficio] [varchar](100) NULL,
	[asu_oficio] [varchar](500) NULL,
	[ubi_oficio] [varchar](500) NULL,
	[notas] [varchar](1000) NULL,
	[fk_id_departamento] [int] NULL,
	[fk_id_estado] [int] NULL,
	[fk_id_persona] [int] NULL,
	[DepEnviada] [varchar](100) NULL,
	[RutaOficioP] [varchar](400) NULL,
	[RutaOficioR] [varchar](400) NULL,
 CONSTRAINT [PK_Oficio] PRIMARY KEY CLUSTERED 
(
	[id_oficio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 25/12/2018 12:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[id_persona] [int] IDENTITY(1,1) NOT NULL,
	[nom_persona] [varchar](50) NULL,
	[apm_persona] [varchar](50) NULL,
	[app_persona] [varchar](50) NULL,
	[tel_persona] [varchar](50) NULL,
	[cor_persona] [varchar](150) NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[id_persona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 25/12/2018 12:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[id_rol] [int] IDENTITY(1,1) NOT NULL,
	[nom_rol] [varchar](50) NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TieneDepartamento]    Script Date: 25/12/2018 12:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TieneDepartamento](
	[id_TieneDep] [int] IDENTITY(1,1) NOT NULL,
	[fk_id_departamento] [int] NOT NULL,
	[fk_id_usuario] [int] NOT NULL,
 CONSTRAINT [PK_TieneDepartamento] PRIMARY KEY CLUSTERED 
(
	[id_TieneDep] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 25/12/2018 12:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[usu_usuario] [varchar](50) NULL,
	[con_usuario] [varchar](50) NULL,
	[token] [varchar](50) NULL,
	[fk_id_persona] [int] NOT NULL,
	[fk_id_rol] [int] NULL,
	[activo] [smallint] NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Circular] ON 

INSERT [dbo].[Circular] ([id_circular], [cla_circular], [nom_circular], [asu_circular], [ubi_circular], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaCircularP], [RutaCircularR]) VALUES (2, N'INFO-HAADV-CIRCULAR-0001/2018', N'Luis Morales', N'Programacion', N'Escritorio Mio', N'', 1008, 1, 5, N'SEDESOL', N'', N'CircularYRecibos/DocAssistant_20180903_205519.jpg')
INSERT [dbo].[Circular] ([id_circular], [cla_circular], [nom_circular], [asu_circular], [ubi_circular], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaCircularP], [RutaCircularR]) VALUES (1002, N'INFO-HAADV-CIRCULAR-0000/2018', N'Jose Luis Morales', N'Este es el asunto de la circular', N'Carpeta F101', N'Estas son las notas del trabajo', 1007, 1, 1002, N'SEDESOL', N'', N'CircularYRecibos/Bee Docs_20180920_170215.jpg')
SET IDENTITY_INSERT [dbo].[Circular] OFF
SET IDENTITY_INSERT [dbo].[Departamento] ON 

INSERT [dbo].[Departamento] ([id_departamento], [nom_departamento], [cla_departamento], [ncla_departamento]) VALUES (1007, N'Informatica', N'INFO', N'INFO-HAADV-OFICIO-0000/2018')
INSERT [dbo].[Departamento] ([id_departamento], [nom_departamento], [cla_departamento], [ncla_departamento]) VALUES (1008, N'Recursos Humanos', N'RRHH', N'RRHH-HAADV-OFICIO-0000/2018')
INSERT [dbo].[Departamento] ([id_departamento], [nom_departamento], [cla_departamento], [ncla_departamento]) VALUES (1009, N'Presidencia Municipal', N'PM', N'PM-HAADV-OFICIO-0000/2018')
INSERT [dbo].[Departamento] ([id_departamento], [nom_departamento], [cla_departamento], [ncla_departamento]) VALUES (1010, N'DirecciÃ³n de TrÃ¡nsito', N'DDT', N'DDT-HAADV-OFICIO-0000/2018')
INSERT [dbo].[Departamento] ([id_departamento], [nom_departamento], [cla_departamento], [ncla_departamento]) VALUES (2007, N'Direccion de Obras Municipales', N'DOM', N'DOM-HAADV-OFICIO-0000/2018')
SET IDENTITY_INSERT [dbo].[Departamento] OFF
SET IDENTITY_INSERT [dbo].[Estado] ON 

INSERT [dbo].[Estado] ([id_estado], [nom_estado]) VALUES (1, N'Pendiente')
INSERT [dbo].[Estado] ([id_estado], [nom_estado]) VALUES (2, N'Pendiente por Entregar')
INSERT [dbo].[Estado] ([id_estado], [nom_estado]) VALUES (3, N'Pendiente (No Entregado)')
INSERT [dbo].[Estado] ([id_estado], [nom_estado]) VALUES (4, N'Se Envio')
INSERT [dbo].[Estado] ([id_estado], [nom_estado]) VALUES (5, N'Enviado')
SET IDENTITY_INSERT [dbo].[Estado] OFF
SET IDENTITY_INSERT [dbo].[Memoran] ON 

INSERT [dbo].[Memoran] ([id_memoran], [cla_memoran], [nom_memoran], [asu_memoran], [ubi_memoran], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaMemoranP], [RutaMemoranR]) VALUES (3, N'DDT-HAADV-OFICIO-0000/2018', N'Jose Luis Morales Perez', N'', N'Carpeta T23', N'', 1007, 5, 1002, N'Presidencia Municipal', N'MemoranYRecibos/DocAssistant_20180901_202134.jpg', N'')
INSERT [dbo].[Memoran] ([id_memoran], [cla_memoran], [nom_memoran], [asu_memoran], [ubi_memoran], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaMemoranP], [RutaMemoranR]) VALUES (6, N'RRHH-HAADV-MEMORAN-0001/2018', N'Luis Morales', N'Peticion', N'Capeta Memoran M001', N'', 1007, 1, 5, N'SEDESOL', N'MemoranYRecibos/DocAssistant_20180903_200458.jpg', N'')
INSERT [dbo].[Memoran] ([id_memoran], [cla_memoran], [nom_memoran], [asu_memoran], [ubi_memoran], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaMemoranP], [RutaMemoranR]) VALUES (7, N'INFO-HAADV-MEMORAN-0000/2018', N'Luis Morales', N'', N'En mi escritorio', N'', 1007, 1, 1002, N'SEDESOL', N'MemoranYRecibos/Bee Docs_20180918_194020.jpg', N'MemoranYRecibos/Bee Docs_20180918_194110.jpg')
SET IDENTITY_INSERT [dbo].[Memoran] OFF
SET IDENTITY_INSERT [dbo].[Oficio] ON 

INSERT [dbo].[Oficio] ([id_oficio], [cla_oficio], [nom_oficio], [asu_oficio], [ubi_oficio], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaOficioP], [RutaOficioR]) VALUES (1, N'INFO-HAADV-OFICIO-0000/2018', N'Jose Luis Morales Perez', N'Solicitud para computadoras ', N'Carpeta F-100', N'Datos Actualizados', 1007, 1, 1002, N'Presidencia Municipal', N'OficiosYRecibos/DocAssistant_20180901_101714.jpg', N'OficiosYRecibos/DocAssistant_20180901_102637.jpg')
INSERT [dbo].[Oficio] ([id_oficio], [cla_oficio], [nom_oficio], [asu_oficio], [ubi_oficio], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaOficioP], [RutaOficioR]) VALUES (2, N'INFO-HAADV-OFICIO-4433/2018', N'Luis Fernando Palomeque Otriz', N'Solicitud', N'Carpeta L-170', N'', 1007, 1, 5, N'Precidencia Municipial', N'OficiosYRecibos/DocAssistant_20180831_235215.jpg', N'OficiosYRecibos/DocAssistant_20180831_235222.jpg')
INSERT [dbo].[Oficio] ([id_oficio], [cla_oficio], [nom_oficio], [asu_oficio], [ubi_oficio], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaOficioP], [RutaOficioR]) VALUES (3, N'RRHH-HAADV-OFICIO-0001/2018', N'Luis Fernando Palomeque Otriz', N'Solicitud', N'Carpeta L-170', N'', 1007, 1, 5, N'Precidencia Municipial', N'', N'')
INSERT [dbo].[Oficio] ([id_oficio], [cla_oficio], [nom_oficio], [asu_oficio], [ubi_oficio], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaOficioP], [RutaOficioR]) VALUES (4, N'INFO-HAADV-OFICIO-4433/2018', N'Luis Fernando Palomeque Otriz', N'Solicitud', N'Carpeta L-170', N'', 1007, 3, 1002, N'Precidencia Municipial', N'OficiosYRecibos/DocAssistant_20180901_101808.jpg', N'OficiosYRecibos/DocAssistant_20180831_235222.jpg')
INSERT [dbo].[Oficio] ([id_oficio], [cla_oficio], [nom_oficio], [asu_oficio], [ubi_oficio], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaOficioP], [RutaOficioR]) VALUES (1004, N'INFO-HAADV-OFICIO-0001/2018', N'Silvia Morales Perez', N'Peticion', N'Folio 101', N'Notas valiosas', 1008, 1, 5, N'CFE', N'OficiosYRecibos/DocAssistant_20180901_135351.jpg', N'OficiosYRecibos/DocAssistant_20180831_235124.jpg')
INSERT [dbo].[Oficio] ([id_oficio], [cla_oficio], [nom_oficio], [asu_oficio], [ubi_oficio], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaOficioP], [RutaOficioR]) VALUES (1005, N'DDT-HAADV-OFICIO-0000/2018', N'Luis Fernando Palomeque Otriz', N'Felicidades', N'Carpeta L-170', N'', 1009, 5, 1002, N'Precidencia Municipial', N'OficiosYRecibos/DocAssistant_20180901_140918.jpg', N'')
INSERT [dbo].[Oficio] ([id_oficio], [cla_oficio], [nom_oficio], [asu_oficio], [ubi_oficio], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaOficioP], [RutaOficioR]) VALUES (1006, N'RRHH-HAADV-OFICIO-8856/2018', N'Luis Morales', N'peticion', N'Carpeta 103', N'', 1007, 1, 1002, N'SEDESOL', N'OficiosYRecibos/DocAssistant_20180903_190730.jpg', N'')
INSERT [dbo].[Oficio] ([id_oficio], [cla_oficio], [nom_oficio], [asu_oficio], [ubi_oficio], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaOficioP], [RutaOficioR]) VALUES (1007, N'INFO-HAADV-OFICIO-0000/2018', N'Luis Morales', N'', N'', N'', 1007, 1, 1002, N'SEDESOL', N'OficiosYRecibos/DocAssistant_20180903_211338.jpg', N'OficiosYRecibos/DocAssistant_20180903_211354.jpg')
INSERT [dbo].[Oficio] ([id_oficio], [cla_oficio], [nom_oficio], [asu_oficio], [ubi_oficio], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaOficioP], [RutaOficioR]) VALUES (2004, N'PM-HAADV-OFICIO-0000/2018', N'Jose Luis Morales', N'uuu', N'uuu', N'uuu', 1009, 1, 1002, N'uuu', N'OficiosYRecibos/Bee Docs_20180918_171444.jpg', N'OficiosYRecibos/Bee Docs_20180918_193130.jpg')
INSERT [dbo].[Oficio] ([id_oficio], [cla_oficio], [nom_oficio], [asu_oficio], [ubi_oficio], [notas], [fk_id_departamento], [fk_id_estado], [fk_id_persona], [DepEnviada], [RutaOficioP], [RutaOficioR]) VALUES (2005, N'INFO-HAADV-OFICIO-0000/2018', N'Jose Luis Morales', N'Asuntos del Oficio', N'Ubicacion del Oficio', N'Notas del Oficio', 1007, 1, 1002, N'Dependencia Enviada', N'OficiosYRecibos/Bee Docs_20180920_164717.jpg', N'')
SET IDENTITY_INSERT [dbo].[Oficio] OFF
SET IDENTITY_INSERT [dbo].[Personas] ON 

INSERT [dbo].[Personas] ([id_persona], [nom_persona], [apm_persona], [app_persona], [tel_persona], [cor_persona]) VALUES (5, N'Example', N'person1', N'person1', N'0000000000', N'prueba5@gmail.com')
INSERT [dbo].[Personas] ([id_persona], [nom_persona], [apm_persona], [app_persona], [tel_persona], [cor_persona]) VALUES (1002, N'Jose Luis ', N'Morales', N'Perez', N'9211320942', N'luis@gmail.com')
INSERT [dbo].[Personas] ([id_persona], [nom_persona], [apm_persona], [app_persona], [tel_persona], [cor_persona]) VALUES (1004, N'tester1', N'tester', N'tester', N'0000000000', N'developer@dev.com')
INSERT [dbo].[Personas] ([id_persona], [nom_persona], [apm_persona], [app_persona], [tel_persona], [cor_persona]) VALUES (1005, N'tom', N'tom', N'holland', N'0000000000', N'tomhomand@gmail.com')
SET IDENTITY_INSERT [dbo].[Personas] OFF
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([id_rol], [nom_rol]) VALUES (1, N'Trabajador')
INSERT [dbo].[Rol] ([id_rol], [nom_rol]) VALUES (2, N'Supervisor')
INSERT [dbo].[Rol] ([id_rol], [nom_rol]) VALUES (3, N'Administrador')
SET IDENTITY_INSERT [dbo].[Rol] OFF
SET IDENTITY_INSERT [dbo].[TieneDepartamento] ON 

INSERT [dbo].[TieneDepartamento] ([id_TieneDep], [fk_id_departamento], [fk_id_usuario]) VALUES (8, 1009, 5)
INSERT [dbo].[TieneDepartamento] ([id_TieneDep], [fk_id_departamento], [fk_id_usuario]) VALUES (12, 1008, 5)
INSERT [dbo].[TieneDepartamento] ([id_TieneDep], [fk_id_departamento], [fk_id_usuario]) VALUES (13, 1007, 5)
SET IDENTITY_INSERT [dbo].[TieneDepartamento] OFF
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([id_usuario], [usu_usuario], [con_usuario], [token], [fk_id_persona], [fk_id_rol], [activo]) VALUES (5, N'prueba', N'prueba', N'0433729a57c9479245703a228f037911', 5, 1, 1)
INSERT [dbo].[Usuarios] ([id_usuario], [usu_usuario], [con_usuario], [token], [fk_id_persona], [fk_id_rol], [activo]) VALUES (1002, N'developer', N'3095', N'26dc5ec8b98515ab30b389abe05c7b73', 1002, 3, 1)
INSERT [dbo].[Usuarios] ([id_usuario], [usu_usuario], [con_usuario], [token], [fk_id_persona], [fk_id_rol], [activo]) VALUES (1004, N'developer1', N'dev', N'3a0c587dfdfe514902b33500695d5711', 1004, 1, 0)
INSERT [dbo].[Usuarios] ([id_usuario], [usu_usuario], [con_usuario], [token], [fk_id_persona], [fk_id_rol], [activo]) VALUES (1005, N'developer2', N'dev', N'7dc15209414bad9b5c7ccc4a144fe506', 1005, 1, 0)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
ALTER TABLE [dbo].[Circular]  WITH CHECK ADD  CONSTRAINT [FK_id_departamento_Circular] FOREIGN KEY([fk_id_departamento])
REFERENCES [dbo].[Departamento] ([id_departamento])
GO
ALTER TABLE [dbo].[Circular] CHECK CONSTRAINT [FK_id_departamento_Circular]
GO
ALTER TABLE [dbo].[Circular]  WITH CHECK ADD  CONSTRAINT [FK_id_estado_Circular] FOREIGN KEY([fk_id_estado])
REFERENCES [dbo].[Estado] ([id_estado])
GO
ALTER TABLE [dbo].[Circular] CHECK CONSTRAINT [FK_id_estado_Circular]
GO
ALTER TABLE [dbo].[Circular]  WITH CHECK ADD  CONSTRAINT [FK_id_persona_Circular] FOREIGN KEY([fk_id_persona])
REFERENCES [dbo].[Personas] ([id_persona])
GO
ALTER TABLE [dbo].[Circular] CHECK CONSTRAINT [FK_id_persona_Circular]
GO
ALTER TABLE [dbo].[Memoran]  WITH CHECK ADD  CONSTRAINT [FK_id_departamento_Memoran] FOREIGN KEY([fk_id_departamento])
REFERENCES [dbo].[Departamento] ([id_departamento])
GO
ALTER TABLE [dbo].[Memoran] CHECK CONSTRAINT [FK_id_departamento_Memoran]
GO
ALTER TABLE [dbo].[Memoran]  WITH CHECK ADD  CONSTRAINT [FK_id_estados_Memoran] FOREIGN KEY([fk_id_estado])
REFERENCES [dbo].[Estado] ([id_estado])
GO
ALTER TABLE [dbo].[Memoran] CHECK CONSTRAINT [FK_id_estados_Memoran]
GO
ALTER TABLE [dbo].[Memoran]  WITH CHECK ADD  CONSTRAINT [FK_id_persona_Memoran] FOREIGN KEY([fk_id_persona])
REFERENCES [dbo].[Personas] ([id_persona])
GO
ALTER TABLE [dbo].[Memoran] CHECK CONSTRAINT [FK_id_persona_Memoran]
GO
ALTER TABLE [dbo].[Oficio]  WITH CHECK ADD  CONSTRAINT [FK_departamento_oficio] FOREIGN KEY([fk_id_departamento])
REFERENCES [dbo].[Departamento] ([id_departamento])
GO
ALTER TABLE [dbo].[Oficio] CHECK CONSTRAINT [FK_departamento_oficio]
GO
ALTER TABLE [dbo].[Oficio]  WITH CHECK ADD  CONSTRAINT [FK_Estado_Oficio] FOREIGN KEY([fk_id_estado])
REFERENCES [dbo].[Estado] ([id_estado])
GO
ALTER TABLE [dbo].[Oficio] CHECK CONSTRAINT [FK_Estado_Oficio]
GO
ALTER TABLE [dbo].[Oficio]  WITH CHECK ADD  CONSTRAINT [FK_id_persona_Oficio] FOREIGN KEY([fk_id_persona])
REFERENCES [dbo].[Personas] ([id_persona])
GO
ALTER TABLE [dbo].[Oficio] CHECK CONSTRAINT [FK_id_persona_Oficio]
GO
ALTER TABLE [dbo].[TieneDepartamento]  WITH CHECK ADD  CONSTRAINT [FK_fk_id_usuario_TieneDepartamento] FOREIGN KEY([fk_id_usuario])
REFERENCES [dbo].[Usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[TieneDepartamento] CHECK CONSTRAINT [FK_fk_id_usuario_TieneDepartamento]
GO
ALTER TABLE [dbo].[TieneDepartamento]  WITH CHECK ADD  CONSTRAINT [FK_id_departamento_TieneDepartamento] FOREIGN KEY([fk_id_departamento])
REFERENCES [dbo].[Departamento] ([id_departamento])
GO
ALTER TABLE [dbo].[TieneDepartamento] CHECK CONSTRAINT [FK_id_departamento_TieneDepartamento]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_id_persona_id_persona] FOREIGN KEY([fk_id_persona])
REFERENCES [dbo].[Personas] ([id_persona])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_id_persona_id_persona]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_id_rol_id_rol] FOREIGN KEY([fk_id_rol])
REFERENCES [dbo].[Rol] ([id_rol])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_id_rol_id_rol]
GO
USE [master]
GO
ALTER DATABASE [OFICIO_ASSISTENTE] SET  READ_WRITE 
GO

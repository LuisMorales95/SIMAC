USE [master]
GO
/****** Object:  Database [SIMACV2]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE DATABASE [SIMACV2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SIRC_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\SIMACV2.mdf' , SIZE = 13248KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'SIRC_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\SIMACV2_1.ldf' , SIZE = 92864KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO
ALTER DATABASE [SIMACV2] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SIMACV2].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [SIMACV2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SIMACV2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SIMACV2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SIMACV2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SIMACV2] SET ARITHABORT OFF 
GO
ALTER DATABASE [SIMACV2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SIMACV2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SIMACV2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SIMACV2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SIMACV2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SIMACV2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SIMACV2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SIMACV2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SIMACV2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SIMACV2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SIMACV2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SIMACV2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SIMACV2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SIMACV2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SIMACV2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SIMACV2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SIMACV2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SIMACV2] SET RECOVERY FULL 
GO
ALTER DATABASE [SIMACV2] SET  MULTI_USER 
GO
ALTER DATABASE [SIMACV2] SET PAGE_VERIFY TORN_PAGE_DETECTION  
GO
ALTER DATABASE [SIMACV2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SIMACV2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SIMACV2] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [SIMACV2]
GO
/****** Object:  User [sirc]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE USER [sirc] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[sirc]
GO
/****** Object:  User [_esecurity]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE USER [_esecurity] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [_coatzaweb]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE USER [_coatzaweb] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [_coatzaweb]
GO
/****** Object:  Schema [audiencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE SCHEMA [audiencia]
GO
/****** Object:  Schema [seguridad]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE SCHEMA [seguridad]
GO
/****** Object:  Schema [sirc]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE SCHEMA [sirc]
GO
/****** Object:  UserDefinedFunction [dbo].[ExisteColonia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ExisteColonia]
	(	
	@Colonia varchar(50),
	@IdLocalidad smallint
	)
RETURNS bit
AS	
	BEGIN			
		IF (SELECT COUNT(*) FROM dbo.Colonia WHERE Colonia=@Colonia and IdLocalidad=@IdLocalidad) >0
			RETURN 1
		RETURN 0			
	END







GO
/****** Object:  UserDefinedFunction [dbo].[ExisteDependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[ExisteDependencia]
	(	
	@Dependencia varchar(50)	
	)
RETURNS bit
AS	
	BEGIN			
		IF (SELECT COUNT(*) FROM dbo.Dependencia WHERE Dependencia=@Dependencia) >0
			RETURN 1
		RETURN 0			
	END




GO
/****** Object:  UserDefinedFunction [dbo].[ExisteLocalidad]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[ExisteLocalidad]
	(	
	@Localidad varchar(50)	
	)
RETURNS bit
AS	
	BEGIN			
		IF (SELECT COUNT(*) FROM dbo.Localidad WHERE Localidad=@Localidad) >0
			RETURN 1
		RETURN 0			
	END




GO
/****** Object:  UserDefinedFunction [dbo].[ExisteServicio]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[ExisteServicio]
	(	
	@Servicio varchar(50)	
	)
RETURNS bit
AS	
	BEGIN			
		IF (SELECT COUNT(*) FROM dbo.Servicio WHERE Servicio=@Servicio) >0
			RETURN 1
		RETURN 0			
	END





GO
/****** Object:  UserDefinedFunction [dbo].[ExisteTiempoRespuesta]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE FUNCTION [dbo].[ExisteTiempoRespuesta]
	(	
	@valor int	
	)
RETURNS bit
AS	
	BEGIN			
		IF (SELECT COUNT(*) FROM dbo.TiempoRespuesta WHERE rojo=@valor) >0
			RETURN 1
		RETURN 0			
	END







GO
/****** Object:  UserDefinedFunction [dbo].[ExisteUserId]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


create  FUNCTION [dbo].[ExisteUserId]
	(	
	@iAppLogin varchar(20)	
	)
RETURNS bit
AS	
	BEGIN			
		IF (SELECT COUNT(*) FROM dbo.esAppWebUsuario WHERE iAppLogin=@iAppLogin) >0
			RETURN 1
		RETURN 0			
	END

GO
/****** Object:  UserDefinedFunction [dbo].[GetAppIdByName]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[GetAppIdByName]
	(	
	@AppName varchar(255)	
	)
RETURNS int
AS	
	BEGIN
		DECLARE @AppID int
		
		SELECT @AppID=COUNT(iAppID) FROM esApps WHERE sAppName=@AppName
		IF (@AppID>0)			
			SET @AppID=(SELECT iAppID FROM esApps WHERE sAppName=@AppName)
			RETURN @AppID
		RETURN 0
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetCiudadanoByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[GetCiudadanoByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS varchar(255) 
AS	
	BEGIN
		DECLARE @nombre varchar(255)
		SET @nombre=( SELECT  (Nombre+' '+ApellidoP+' '+ApellidoM) as 'Nombre'
		FROM Ciudadano
		--INNER JOIN Colonia ON Localidad.Id = Colonia.idLocalidad
		--INNER JOIN Ciudadano ON Ciudadano.IdColonia = Colonia.Id
		INNER JOIN RelSolCiud ON Ciudadano.Id = RelSolCiud.IdCiudadano
		INNER JOIN Solicitud ON RelSolCiud.IdSolicitud=Solicitud.Id
		WHERE Solicitud.Id=@idSolicitud
		)
		IF (@@ROWCOUNT>0) 
			RETURN @nombre
		RETURN ''
		
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetEstadoIDByName]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[GetEstadoIDByName]
	(	
	@Estado varchar(20)	
	)
RETURNS int
AS	
	BEGIN
		DECLARE @EstadoID int
		
		SELECT @EstadoID=COUNT(*) FROM dbo.Estado WHERE Estado=@Estado
		IF (@EstadoID>0)			
			SET @EstadoID=(SELECT id FROM dbo.Estado WHERE Estado=@Estado)
			RETURN @EstadoID
		RETURN 0
	END






GO
/****** Object:  UserDefinedFunction [dbo].[GetFechaCreacion]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[GetFechaCreacion]
	(
	@idSolicitud int
	)
RETURNS datetime
AS
	BEGIN
		DECLARE @fecha datetime

/*		set @fecha= (SELECT TOP 1 FechaHora
		FROM SolicitudEstado
		WHERE idSolicitud=@idSolicitud
		ORDER BY IdSolicitudEstado ASC)*/

		set @fecha= (SELECT min (FechaHora)
		FROM SolicitudEstado
		WHERE idSolicitud=@idSolicitud)

		IF (@fecha is null ) return '01-01-01'

		RETURN @fecha
	END




GO
/****** Object:  UserDefinedFunction [dbo].[GetFirstComentarioByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[GetFirstComentarioByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS varchar(20) 
AS	
	BEGIN
		DECLARE @status varchar(20)
		SET @status=(
			SELECT Comentario
			FROM Seguimiento INNER JOIN SolicitudEstado
			ON Seguimiento.IdSolicitudEstado = SolicitudEstado.IdSolicitudEstado
			WHERE SolicitudEstado.IdSolicitudEstado = dbo.GetFirstSolicitudEstadoByIdSolicitud(@idSolicitud)
		)
		IF (@@ROWCOUNT>0) 		
			RETURN @status
		RETURN ''
	END




GO
/****** Object:  UserDefinedFunction [dbo].[GetFirstIdCapturistaByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[GetFirstIdCapturistaByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS int
AS	
	BEGIN
		DECLARE @idCapturista int		
		SET @idCapturista=(SELECT TOP 1 idCaptura 
					FROM SolicitudEstado
					WHERE idSolicitud=@idSolicitud
					ORDER BY IdSolicitudEstado ASC)
		IF (@@ROWCOUNT>0) 		
			RETURN @idCapturista
		RETURN 0
	END


GO
/****** Object:  UserDefinedFunction [dbo].[GetFirstSolicitudEstadoByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[GetFirstSolicitudEstadoByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS int
AS	
	BEGIN
		DECLARE @idSolicitudEstado int		
		SET @idSolicitudEstado=(SELECT TOP 1 idSolicitudEstado 
					FROM SolicitudEstado
					WHERE idSolicitud=@idSolicitud
					ORDER BY IdSolicitudEstado ASC)
		IF (@@ROWCOUNT>0) 		
			RETURN @idSolicitudEstado
		RETURN 0
	END

GO
/****** Object:  UserDefinedFunction [dbo].[GetIdSolicitudByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create FUNCTION [dbo].[GetIdSolicitudByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS int
AS	
	BEGIN
		DECLARE @idServicio smallint		
		SET @idServicio=(SELECT TOP 1 IdServicio 
					FROM Solicitud
					WHERE Id=@idSolicitud)
		IF (@@ROWCOUNT>0) 		
			RETURN @idServicio
		RETURN 0
	END


GO
/****** Object:  UserDefinedFunction [dbo].[GetLastComentarioByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[GetLastComentarioByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS varchar(20) 
AS	
	BEGIN
		DECLARE @status varchar(20)
		SET @status=(
			SELECT Comentario
			FROM Seguimiento INNER JOIN SolicitudEstado
			ON Seguimiento.IdSolicitudEstado = SolicitudEstado.IdSolicitudEstado
			WHERE SolicitudEstado.IdSolicitudEstado = dbo.GetLastSolicitudEstadoByIdSolicitud(@idSolicitud)
		)
		IF (@@ROWCOUNT>0) 		
			RETURN @status
		RETURN ''
	END



GO
/****** Object:  UserDefinedFunction [dbo].[GetLastEstadoByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[GetLastEstadoByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS varchar(20) 
AS	
	BEGIN
		DECLARE @status varchar(20)
		SET @status=(
					SELECT Estado
					FROM Estado INNER JOIN SolicitudEstado
					ON Estado.Id = SolicitudEstado.IdEstado
					WHERE SolicitudEstado.IdSolicitudEstado = dbo.GetLastSolicitudEstadoByIdSolicitud(@idSolicitud)
		)
		IF (@@ROWCOUNT>0) 		
			RETURN @status
		RETURN 0
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetLastFechaEstado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE FUNCTION [dbo].[GetLastFechaEstado]
	(
	@idSolicitud int
	)
RETURNS datetime
AS
	BEGIN
		DECLARE @fecha datetime
		Declare @fecha_2 datetime
		
/*		set @fecha= (SELECT TOP 1 FechaHora
		FROM SolicitudEstado
		WHERE idSolicitud=@idSolicitud
		ORDER BY IdSolicitudEstado ASC)*/
		set @fecha= (SELECT min (FechaHora)
		FROM SolicitudEstado
		WHERE idSolicitud=@idSolicitud)
		
		set @fecha_2= (SELECT max (FechaHora)
		FROM SolicitudEstado
		WHERE idSolicitud=@idSolicitud)

		IF (datediff(Hour,@fecha,@fecha_2)=0) return getdate()

		RETURN @fecha_2
	END





GO
/****** Object:  UserDefinedFunction [dbo].[GetLastFechaEstado_02]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE FUNCTION [dbo].[GetLastFechaEstado_02]
	(
	@idSolicitud int
	)
RETURNS datetime
AS
	BEGIN
		DECLARE @fecha datetime

/*		set @fecha= (SELECT TOP 1 FechaHora
		FROM SolicitudEstado
		WHERE idSolicitud=@idSolicitud
		ORDER BY IdSolicitudEstado ASC)*/

		set @fecha= (SELECT max (FechaHora)
		FROM SolicitudEstado
		WHERE idSolicitud=@idSolicitud)

		IF (@fecha is null ) return '01-01-01'

		RETURN @fecha
	END





GO
/****** Object:  UserDefinedFunction [dbo].[GetLastSolicitudEstadoByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[GetLastSolicitudEstadoByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS int
AS	
	BEGIN
		DECLARE @idSolicitudEstado int		
		SET @idSolicitudEstado=(SELECT TOP 1 idSolicitudEstado 
					FROM SolicitudEstado
					WHERE idSolicitud=@idSolicitud
					ORDER BY IdSolicitudEstado DESC)
		IF (@@ROWCOUNT>0) 		
			RETURN @idSolicitudEstado
		RETURN 0
	END



GO
/****** Object:  UserDefinedFunction [dbo].[GetRoleIdByRoleNameAndAppId]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[GetRoleIdByRoleNameAndAppId]
	(		
	@RoleName varchar(50),
	@AID int	
	)
RETURNS int
AS	
BEGIN		
		DECLARE @iAppRoleID int,
			@Regreso int	
		
		DECLARE iCursor CURSOR FOR 
			SELECT iAppRoleID FROM esAppRoles
			WHERE sRole=@RoleName
			AND iAppID=@AID
	
	SET @Regreso=0
	OPEN iCursor	
	FETCH NEXT FROM iCursor INTO @iAppRoleID
	IF (@@FETCH_STATUS =0 )		
		SET @Regreso= @iAppRoleID		
	CLOSE iCursor
	DEALLOCATE iCursor
	IF (@Regreso >0)		
		RETURN @Regreso	
	RETURN 0
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSolucionByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[GetSolucionByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS varchar(20) 
AS	
	BEGIN
		DECLARE @status varchar(20)
		SET @status=(

SELECT Solucion FROM dbo.ServicioRealizado
WHERE idSolicitudEstado = (SELECT Max(idSolicitudEstado) FROM dbo.SolicitudEstado WHERE idSolicitud=@idSolicitud and idEstado=(SELECT id FROM EStado WHERE Estado='Realizado') )
		)
		IF (@@ROWCOUNT>0) 		
			RETURN @status
		RETURN ''
	END



GO
/****** Object:  UserDefinedFunction [dbo].[GetTelCiudadanoByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[GetTelCiudadanoByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS varchar(255) 
AS	
	BEGIN
		DECLARE @contacto varchar(255)
		SET @contacto=( SELECT  (Telefono+', '+TelefonoAlt+', '+CorreoE) as 'Contacto'
		FROM Ciudadano
		--INNER JOIN Colonia ON Localidad.Id = Colonia.idLocalidad
		--INNER JOIN Ciudadano ON Ciudadano.IdColonia = Colonia.Id
		INNER JOIN RelSolCiud ON Ciudadano.Id = RelSolCiud.IdCiudadano
		INNER JOIN Solicitud ON RelSolCiud.IdSolicitud=Solicitud.Id
		WHERE Solicitud.Id=@idSolicitud
		)
		IF (@@ROWCOUNT>0) 		
			RETURN @contacto
		RETURN ''
	END


GO
/****** Object:  UserDefinedFunction [dbo].[GetTelelefonoByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetTelelefonoByIdSolicitud]
	(	
	@idSolicitud int
	)
RETURNS varchar(255) 
AS	
	BEGIN
		DECLARE @contacto varchar(255)
		SET @contacto=( SELECT top(1) (isnull(Telefono+' - ','')+isnull(TelefonoAlt,'')) as 'Contacto'
		FROM Ciudadano
		--INNER JOIN Colonia ON Localidad.Id = Colonia.idLocalidad
		--INNER JOIN Ciudadano ON Ciudadano.IdColonia = Colonia.Id
		INNER JOIN RelSolCiud ON Ciudadano.Id = RelSolCiud.IdCiudadano
		INNER JOIN Solicitud ON RelSolCiud.IdSolicitud=Solicitud.Id
		WHERE Solicitud.Id=@idSolicitud
		)
		IF (@@ROWCOUNT>0) 		
			RETURN @contacto
		RETURN ''
	END



GO
/****** Object:  UserDefinedFunction [dbo].[GetUserIDByLoginID]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetUserIDByLoginID]
	(
	@LoginID varchar(255)	
	)
RETURNS int
AS
	
	BEGIN
		DECLARE @ID int
		SET @ID=0		
		SET @ID=(SELECT COUNT(sLoginID) FROM esUsers WHERE sLoginID=@LoginID)
		IF (@ID>0)
			BEGIN
				SELECT @ID=iUserID FROM esUsers WHERE  sLoginID=@LoginID			
				RETURN @ID
			END	
		RETURN 0
	END
GO
/****** Object:  UserDefinedFunction [dbo].[IsRoleInApp]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsRoleInApp]
	(
	@RoleName varchar(50),	
	@AppName varchar(255)	
	)
RETURNS int
AS	
	BEGIN
		DECLARE @AppID int,
				@RoleID int
		--Verifico que exista la aplicacion
		SELECT @AppID=COUNT(iAppID) FROM esApps WHERE sAppName=@AppName
		--Verifico que exista el rol dentro de la aplicacion
		SELECT @RoleID=COUNT(sRole) FROM esAppRoles WHERE sRole=@RoleName AND iAppID=dbo.GetAppIdByName(@AppName)
		--Por lo tanto ya se que es valido
		IF @RoleID >0
			RETURN 1
		RETURN 0
	END
GO
/****** Object:  UserDefinedFunction [dbo].[IsRoleInAppId]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[IsRoleInAppId]
	(	
	@RoleName varchar (50),
	@AppId int
	)
RETURNS int
AS	
	BEGIN	
	DECLARE @RoleId int
		--Verifico que exista el rol dentro de la aplicacion
		SELECT @RoleID=COUNT(iAppRoleID) FROM esAppRoles WHERE sRole=@RoleName AND iAppID=@AppId
		--Por lo tanto ya se que es valido
		IF @RoleID >0
			RETURN 1
		RETURN 0
	END
GO
/****** Object:  UserDefinedFunction [dbo].[IsRoleInAppIdAndUserId]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[IsRoleInAppIdAndUserId]
	(		
	@RoleName varchar(50),
	@AID int,
	@UID int
	)
RETURNS int
AS	
BEGIN		
		DECLARE @iAppRoleID int,
			@Regreso int	
		
		DECLARE iCursor CURSOR FOR 
			SELECT esAppRoles.iAppRoleID	
			FROM esAppUserRoles 
			INNER JOIN esAppRoles 
			ON esAppUserRoles.iAppRoleID = esAppRoles.iAppRoleID 
			WHERE esAppUserRoles.iAppID = @AID
			AND esAppUserRoles.iUserID = @UID
			AND esAppRoles.sRole=@RoleName	
	
	SET @Regreso=0
	OPEN iCursor	
	FETCH NEXT FROM iCursor INTO @iAppRoleID
	IF (@@FETCH_STATUS =0 )		
		SET @Regreso= @iAppRoleID		
	CLOSE iCursor
	DEALLOCATE iCursor

	IF (@Regreso >0)		
		RETURN @Regreso	
	RETURN 0
END
GO
/****** Object:  UserDefinedFunction [dbo].[IsUserIdInAppId]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsUserIdInAppId]
	(	
	@UserId int,
	@AppId int
	)
RETURNS int
AS	
	BEGIN
		DECLARE @AID int,
			@UID int, 
			@XCount int
		--Verifico que exista la aplicacion
		SELECT @AID=COUNT(iAppID) FROM esApps WHERE iAppID=@AppId
		--Verifico que exista el usuario
		SELECT @UID=COUNT(iUserID) FROM esUsers WHERE  iUserID=@UserId
		--verifico que el usuario este registrado en la aplicacion
		SELECT @XCount=COUNT(*) FROM esAppsUsers WHERE iAppID=@AppId AND iUserID=@UserId		
		--Por lo tanto ya se que es registrado
		IF ((@AID>0) AND (@UID>0) AND (@XCount>0))
			RETURN 1
		RETURN 0		
	END
GO
/****** Object:  UserDefinedFunction [dbo].[ValidateAppId]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ValidateAppId]
	(
	@AppId int	
	)
RETURNS int
AS	
	BEGIN
		DECLARE @AID int				
		--Verifico que exista la aplicacion
		SELECT @AID=COUNT(iAppID) FROM esApps WHERE iAppId=@AppId
		IF @AID >0
			RETURN @AppId
		RETURN 0
	END
GO
/****** Object:  UserDefinedFunction [dbo].[ValidateUserId]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  FUNCTION [dbo].[ValidateUserId]
	(
	@UserId int	
	)
RETURNS int
AS	
	BEGIN
		DECLARE @UID int				
		--Verifico que exista la aplicacion
		SELECT @UID=COUNT(iUserID) FROM esUsers WHERE iUserID=@UserId
		IF @UID >0
			RETURN 1
		RETURN 0
	END
GO
/****** Object:  Table [audiencia].[AudienciaTemp]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [audiencia].[AudienciaTemp](
	[idAudiencia] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[apellidoPaterno] [varchar](50) NOT NULL,
	[apellidoMaterno] [varchar](50) NOT NULL,
	[direccion] [varchar](70) NOT NULL,
	[idLocalidad] [smallint] NOT NULL,
	[idColonia] [int] NOT NULL,
	[telefono] [varchar](30) NULL,
	[correoElectronico] [varchar](60) NULL,
	[peticion] [varchar](1024) NOT NULL,
	[fechaHora] [datetime] NULL,
 CONSTRAINT [PK_AudienciaTemp] PRIMARY KEY CLUSTERED 
(
	[idAudiencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aflcomments]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aflcomments](
	[comment_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[comment_desc] [varchar](300) NOT NULL,
	[comment_date] [datetime] NOT NULL,
	[comment_parent] [int] NULL,
	[comment_active] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ayuntamiento]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ayuntamiento](
	[LogoAyunto] [varchar](255) NOT NULL,
	[LogoAdmon] [varchar](255) NOT NULL,
	[Nombre] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ciudadano]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudadano](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[ApellidoP] [varchar](30) NOT NULL,
	[ApellidoM] [varchar](30) NULL,
	[NumeroInt] [varchar](5) NULL,
	[NumeroExt] [varchar](5) NULL,
	[Direccion] [varchar](50) NOT NULL,
	[IdColonia] [smallint] NOT NULL,
	[Sexo] [bit] NOT NULL,
	[CorreoE] [varchar](50) NULL,
	[CorreoEAlt] [varchar](50) NULL,
	[Telefono] [varchar](20) NULL,
	[TelefonoAlt] [varchar](20) NULL,
	[Asociacion] [varchar](50) NULL,
	[Edad] [smallint] NULL,
	[Calle1] [varchar](50) NULL,
	[Calle2] [varchar](50) NULL,
	[fechaNac] [smalldatetime] NULL,
 CONSTRAINT [PK_Ciudadano] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Colonia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Colonia](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Colonia] [varchar](50) NOT NULL,
	[IdLocalidad] [smallint] NOT NULL,
 CONSTRAINT [PK_Colonia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dependencia](
	[esOP] [bit] NOT NULL,
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Dependencia] [varchar](50) NOT NULL,
	[Descripcion] [varchar](256) NULL,
	[Ubicacion] [varchar](50) NULL,
	[Telefono] [varchar](20) NULL,
	[CorreoE] [varchar](50) NULL,
	[idTiempo] [smallint] NOT NULL,
 CONSTRAINT [PK_Dependencia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Position] [nvarchar](50) NULL,
	[Office] [nvarchar](50) NULL,
	[Age] [int] NULL,
	[Salary] [nvarchar](50) NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estado](
	[Id] [smallint] NOT NULL,
	[Estado] [varchar](20) NOT NULL,
	[Descripcion] [varchar](256) NULL,
	[EstadoCiudadano] [varchar](20) NOT NULL,
	[IdEdoCiudadano] [smallint] NOT NULL,
 CONSTRAINT [PK_Estado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormaContacto]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormaContacto](
	[idformacontacto] [smallint] IDENTITY(1,1) NOT NULL,
	[formadecontacto] [varchar](100) NULL,
 CONSTRAINT [PK_FormaContacto] PRIMARY KEY CLUSTERED 
(
	[idformacontacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Localidad]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Localidad](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Localidad] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Localidad] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovilAlertas]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilAlertas](
	[id_alerta] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](max) NULL,
	[descripcion] [varchar](max) NULL,
	[fecha] [varchar](50) NULL,
	[ubicacion] [varchar](max) NULL,
	[alertaimg] [varchar](max) NULL,
	[longitud] [varchar](50) NULL,
	[latitud] [varchar](50) NULL,
	[fk_id_categoria] [int] NULL,
	[fk_id_ciudadano] [int] NULL,
 CONSTRAINT [PK_MovilAlertas] PRIMARY KEY CLUSTERED 
(
	[id_alerta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovilCategoria]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilCategoria](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [varchar](50) NULL,
 CONSTRAINT [PK_MovilCategoria] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovilCiudadano]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilCiudadano](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[ApellidoP] [varchar](30) NULL,
	[NumeroExt] [varchar](5) NULL,
	[Direccion] [varchar](50) NULL,
	[IdColonia] [smallint] NULL,
	[Sexo] [bit] NULL,
	[CorreoE] [varchar](50) NULL,
	[Telefono] [varchar](20) NULL,
	[fechaNac] [smalldatetime] NULL,
	[Contrasena] [varchar](50) NULL,
	[Token] [varchar](50) NULL,
	[ImgURL] [varchar](1000) NULL,
	[tokennotif] [varchar](300) NULL,
	[fk_id_rol] [int] NULL,
	[Verificacion_Usuario] [bit] NULL,
 CONSTRAINT [PK_CiudadanoMovil] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovilComentario]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilComentario](
	[id_comentario] [int] IDENTITY(1,1) NOT NULL,
	[comentario] [varchar](500) NULL,
	[fecha] [varchar](50) NULL,
	[fk_id_alerta] [int] NULL,
	[fk_id_ciudadano] [int] NULL,
 CONSTRAINT [PK_MovilComentario] PRIMARY KEY CLUSTERED 
(
	[id_comentario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovilEmergencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilEmergencia](
	[id_emergencia] [int] IDENTITY(1,1) NOT NULL,
	[telefono] [varchar](20) NULL,
	[extencion] [varchar](10) NULL,
	[img_emergencia] [varchar](max) NULL,
	[Nombre_emergencia] [varchar](50) NULL,
 CONSTRAINT [PK_MovilEmergencia] PRIMARY KEY CLUSTERED 
(
	[id_emergencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovilReaccion]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilReaccion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[reaccion] [varchar](50) NULL,
 CONSTRAINT [PK_MovilReaccion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovilRol]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilRol](
	[id_rol] [int] IDENTITY(1,1) NOT NULL,
	[rol] [varchar](50) NULL,
 CONSTRAINT [PK_MovilRol] PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovilSolicitud_Temp]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilSolicitud_Temp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fk_id_ciudadano] [int] NULL,
	[fk_id_colonia] [int] NULL,
	[problema] [varchar](max) NULL,
	[direccion] [varchar](max) NULL,
	[referencia1] [varchar](max) NULL,
	[referencia2] [varchar](max) NULL,
	[fechahora] [varchar](50) NULL,
	[Img_Solicitud] [varchar](max) NULL,
	[vigencia] [bit] NULL,
	[longitud] [varchar](50) NULL,
	[latitud] [varchar](50) NULL,
 CONSTRAINT [PK_MovilSolicitud_Temp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovilTiene_reaccion]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilTiene_reaccion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fk_id_ciudadano] [int] NULL,
	[fk_id_alerta] [int] NULL,
	[fk_id_reaccion] [int] NULL,
 CONSTRAINT [PK_MovilTiene_reaccion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Periodo]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Periodo](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[minAgno] [smalldatetime] NOT NULL,
	[maxAgno] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Periodo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelSolCiud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelSolCiud](
	[IdCiudadano] [int] NOT NULL,
	[IdSolicitud] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sector]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sector](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Sector] [varchar](5) NOT NULL,
	[Subsector] [varchar](5) NOT NULL,
 CONSTRAINT [PK_Sector] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SectorColonia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SectorColonia](
	[IdSector] [smallint] NOT NULL,
	[IdColonia] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seguimiento]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seguimiento](
	[IdSolicitudEstado] [int] NOT NULL,
	[Comentario] [varchar](1024) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Servicio]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicio](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Servicio] [varchar](100) NOT NULL,
	[IdDependencia] [smallint] NOT NULL,
	[Descripcion] [varchar](256) NULL,
 CONSTRAINT [PK_Servicio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServicioRealizado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServicioRealizado](
	[IdSolicitudEstado] [int] NOT NULL,
	[FechaRealizacion] [smalldatetime] NOT NULL,
	[Encargado] [varchar](50) NOT NULL,
	[Solucion] [varchar](1024) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Solicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitud](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Descripcion] [varchar](1024) NOT NULL,
	[IdServicio] [smallint] NOT NULL,
	[IdColonia] [smallint] NULL,
	[Calle] [varchar](50) NULL,
	[Ref1] [varchar](50) NULL,
	[Ref2] [varchar](50) NULL,
	[idformacontacto] [smallint] NULL,
	[prioritario] [bit] NULL,
	[idtmp] [bigint] NULL,
 CONSTRAINT [PK_Solicitud] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SolicitudEstado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolicitudEstado](
	[IdSolicitudEstado] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[IdSolicitud] [int] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[FechaHora] [smalldatetime] NOT NULL,
	[IdCaptura] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SolicitudEstado] PRIMARY KEY CLUSTERED 
(
	[IdSolicitudEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SolicitudTemp]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolicitudTemp](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Nombre] [varchar](30) NULL,
	[ApellidoP] [varchar](30) NULL,
	[ApellidoM] [varchar](30) NULL,
	[Direccion] [varchar](50) NULL,
	[NumeroExt] [varchar](5) NULL,
	[NumeroInt] [varchar](5) NULL,
	[IdColonia] [smallint] NULL,
	[Sexo] [bit] NULL,
	[CorreoE] [varchar](50) NULL,
	[CorreoEAlt] [varchar](50) NULL,
	[Telefono] [varchar](20) NULL,
	[TelefonoAlt] [varchar](20) NULL,
	[Asociacion] [varchar](50) NULL,
	[Edad] [smallint] NULL,
	[Descripcion] [varchar](1024) NULL,
	[IdCol] [smallint] NULL,
	[Calle] [varchar](50) NULL,
	[Ref1] [varchar](50) NULL,
	[Ref2] [varchar](50) NULL,
	[FechaHora] [smalldatetime] NOT NULL,
	[Eliminado] [bit] NOT NULL,
	[fechaNac] [smalldatetime] NULL,
	[formaContacto] [tinyint] NULL,
 CONSTRAINT [PK_SolicitudTemp] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SolicitudTempMovil]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolicitudTempMovil](
	[idtmp] [bigint] NOT NULL,
	[nombrecompleto] [varchar](200) NULL,
	[idcolonia] [smallint] NULL,
	[direccion] [varchar](255) NULL,
	[telefono] [varchar](50) NULL,
	[correoe] [varchar](150) NULL,
	[problema] [varchar](1024) NULL,
	[idcoloniap] [smallint] NULL,
	[ref01] [varchar](100) NULL,
	[ref02] [varchar](100) NULL,
	[fechahora] [datetime] NULL,
	[eliminado] [bit] NULL,
	[img_solicitud] [varchar](max) NULL,
	[logintud] [varchar](max) NULL,
	[latitud] [varchar](max) NULL,
	[fechaNac] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SolicitudTmpExce]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolicitudTmpExce](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Nombre] [varchar](30) NULL,
	[ApellidoP] [varchar](30) NULL,
	[ApellidoM] [varchar](30) NULL,
	[IdColonia] [smallint] NULL,
	[Colonia] [varchar](150) NULL,
	[Direccion] [varchar](50) NULL,
	[NumeroExt] [varchar](5) NULL,
	[Fecha] [smalldatetime] NOT NULL,
	[FechaSol] [smalldatetime] NOT NULL,
	[Descripcion] [varchar](1024) NULL,
	[IdCol] [smallint] NULL,
	[Col] [varchar](150) NULL,
	[Calle] [varchar](50) NULL,
	[Telefono] [varchar](20) NULL,
	[CorreoE] [varchar](50) NULL,
	[Solucion] [varchar](1024) NULL,
	[Atendio] [varchar](50) NULL,
	[Capturo] [varchar](50) NULL,
	[UsuarioDep] [varchar](50) NULL,
	[formaContacto] [tinyint] NULL,
 CONSTRAINT [PK_SolicitudTmpExce] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiempoRespuesta]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiempoRespuesta](
	[idTiempo] [smallint] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](60) NULL,
	[verde] [smallint] NULL,
	[amarillo] [smallint] NULL,
	[naranja] [smallint] NULL,
	[rojo] [smallint] NULL,
 CONSTRAINT [PK_TiempoRespuesta] PRIMARY KEY CLUSTERED 
(
	[idTiempo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[traza]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[traza](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[EventClass] [int] NULL,
	[TextData] [ntext] NULL,
	[NTUserName] [nvarchar](128) NULL,
	[ClientProcessID] [int] NULL,
	[ApplicationName] [nvarchar](128) NULL,
	[LoginName] [nvarchar](128) NULL,
	[SPID] [int] NULL,
	[Duration] [bigint] NULL,
	[StartTime] [datetime] NULL,
	[Reads] [bigint] NULL,
	[Writes] [bigint] NULL,
	[CPU] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RowNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [seguridad].[esAppRoles]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seguridad].[esAppRoles](
	[iAppRoleID] [int] IDENTITY(1,1) NOT NULL,
	[iAppID] [int] NOT NULL,
	[sRole] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iAppRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [seguridad].[esApps]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seguridad].[esApps](
	[iAppID] [int] NOT NULL,
	[sAppName] [varchar](255) NOT NULL,
	[sDesc] [varchar](1024) NULL,
	[sURL] [varchar](1024) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iAppID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [seguridad].[esAppWebUsuario]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seguridad].[esAppWebUsuario](
	[iAppID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDROL] [int] NULL,
	[iAppLogin] [varchar](20) NOT NULL,
	[iAppNombreC] [varchar](250) NOT NULL,
	[iAppCorreo] [varchar](255) NULL,
	[iAppPwd] [varchar](250) NOT NULL,
	[iAppAudiencia] [bit] NULL,
	[iAppActivo] [bit] NOT NULL,
 CONSTRAINT [PK_esAppWebUsuario] PRIMARY KEY CLUSTERED 
(
	[iAppID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [seguridad].[esDetallesUsers]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seguridad].[esDetallesUsers](
	[iUserID] [int] NOT NULL,
	[iAppID] [bigint] NULL,
	[sNombre] [varchar](50) NOT NULL,
	[sApellido] [varchar](64) NULL,
	[iSexo] [int] NULL,
	[iEdad] [int] NULL,
	[sDireccion] [varchar](64) NULL,
	[sColonia] [varchar](64) NULL,
	[sTelefono] [varchar](25) NULL,
	[sCiudad] [varchar](64) NULL,
	[sCorreoE] [varchar](128) NULL,
	[sDependencia] [varchar](128) NULL,
 CONSTRAINT [PK_esDetallesUsers] PRIMARY KEY CLUSTERED 
(
	[iUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [seguridad].[MODULO]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seguridad].[MODULO](
	[IDMODULO] [int] IDENTITY(1,1) NOT NULL,
	[DESCRIPCION] [varchar](100) NOT NULL,
	[MODULO] [varchar](50) NOT NULL,
	[URL] [varchar](255) NULL,
	[ACTIVO] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [seguridad].[PAGINA]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seguridad].[PAGINA](
	[IDPAGINA] [int] IDENTITY(1,1) NOT NULL,
	[IDMODULO] [int] NULL,
	[TITULO] [nvarchar](50) NULL,
	[PAGINA] [nvarchar](100) NULL,
	[CODIGO] [varchar](20) NULL,
	[ACTIVO] [bit] NULL,
 CONSTRAINT [PK_PAGINA] PRIMARY KEY CLUSTERED 
(
	[IDPAGINA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [seguridad].[PERMISOROL]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seguridad].[PERMISOROL](
	[IDPERMISOROL] [int] IDENTITY(1,1) NOT NULL,
	[IDPAGINA] [int] NULL,
	[IDROL] [int] NULL,
	[IDMODULO] [int] NULL,
 CONSTRAINT [PK_PERMISOROL] PRIMARY KEY CLUSTERED 
(
	[IDPERMISOROL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [seguridad].[RELUSERDEP]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seguridad].[RELUSERDEP](
	[idrel] [int] IDENTITY(1,1) NOT NULL,
	[iddep] [smallint] NOT NULL,
	[iAppID] [bigint] NOT NULL,
	[fecha] [datetime] NULL,
 CONSTRAINT [PK_RELUSERDEP] PRIMARY KEY CLUSTERED 
(
	[idrel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [seguridad].[ROL]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seguridad].[ROL](
	[IDROL] [int] IDENTITY(1,1) NOT NULL,
	[ROL] [varchar](50) NULL,
	[DESCRIPCION] [varchar](100) NULL,
 CONSTRAINT [PK_ROL] PRIMARY KEY CLUSTERED 
(
	[IDROL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_depenciaByUsuario]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_depenciaByUsuario]
AS
SELECT dbo.Dependencia.Id, dbo.Dependencia.Dependencia, dbo.Dependencia.Descripcion, dbo.Dependencia.Ubicacion, dbo.Dependencia.Telefono, dbo.Dependencia.CorreoE, dbo.TiempoRespuesta.idTiempo, dbo.TiempoRespuesta.descripcion AS trDescripcion, 
             dbo.TiempoRespuesta.verde AS trVerde, dbo.TiempoRespuesta.amarillo AS trAmarillo, dbo.TiempoRespuesta.naranja AS trNaranja, dbo.TiempoRespuesta.rojo AS trRojo, seguridad.RELUSERDEP.iAppID, seguridad.RELUSERDEP.idrel
FROM   dbo.Dependencia INNER JOIN
             seguridad.RELUSERDEP ON dbo.Dependencia.Id = seguridad.RELUSERDEP.iddep INNER JOIN
             dbo.TiempoRespuesta ON dbo.Dependencia.idTiempo = dbo.TiempoRespuesta.idTiempo AND dbo.Dependencia.idTiempo = dbo.TiempoRespuesta.idTiempo
GO
/****** Object:  View [dbo].[view_getDependenciaWithTiempos]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_getDependenciaWithTiempos]
AS
SELECT     dbo.Dependencia.Id, dbo.Dependencia.Dependencia, dbo.Dependencia.Descripcion, dbo.Dependencia.Ubicacion, dbo.Dependencia.Telefono, dbo.Dependencia.CorreoE, dbo.Dependencia.idTiempo, 
                      dbo.TiempoRespuesta.descripcion AS trDescripcion, dbo.TiempoRespuesta.verde AS trVerde, dbo.TiempoRespuesta.amarillo AS trAmarillo, dbo.TiempoRespuesta.naranja AS trNaranja, 
                      dbo.TiempoRespuesta.rojo AS trRojo
FROM         dbo.Dependencia INNER JOIN
                      dbo.TiempoRespuesta ON dbo.Dependencia.idTiempo = dbo.TiempoRespuesta.idTiempo
GO
/****** Object:  View [dbo].[view_getServicio_dependencia_tiempoDepencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_getServicio_dependencia_tiempoDepencia]
AS
SELECT     dbo.Servicio.Id AS idServicio, dbo.Servicio.Servicio, dbo.Servicio.IdDependencia AS idDep, dbo.Servicio.Descripcion, dbo.Dependencia.Dependencia AS Dependencia_Dependencia, 
                      dbo.TiempoRespuesta.verde AS trVerde, dbo.TiempoRespuesta.amarillo AS trAmarillo, dbo.TiempoRespuesta.naranja AS trNaranja, dbo.TiempoRespuesta.rojo AS trRojo
FROM         dbo.Servicio INNER JOIN
                      dbo.Dependencia ON dbo.Servicio.IdDependencia = dbo.Dependencia.Id INNER JOIN
                      dbo.TiempoRespuesta ON dbo.Dependencia.idTiempo = dbo.TiempoRespuesta.idTiempo
GO
/****** Object:  View [seguridad].[view_PaginaRolModulo]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [seguridad].[view_PaginaRolModulo] AS
SELECT     seguridad.PERMISOROL.IDPERMISOROL, seguridad.PERMISOROL.IDPAGINA, seguridad.PERMISOROL.IDROL, seguridad.PERMISOROL.IDMODULO, seguridad.PAGINA.TITULO, 
                      seguridad.PAGINA.PAGINA, seguridad.PAGINA.ACTIVO, seguridad.PAGINA.CODIGO,  seguridad.MODULO.MODULO, seguridad.MODULO.DESCRIPCION, 
                      seguridad.MODULO.URL, seguridad.ROL.ROL
FROM         seguridad.PAGINA INNER JOIN
                      seguridad.MODULO ON seguridad.PAGINA.IDMODULO = seguridad.MODULO.IDMODULO INNER JOIN
                      seguridad.PERMISOROL ON seguridad.PAGINA.IDPAGINA = seguridad.PERMISOROL.IDPAGINA AND seguridad.MODULO.IDMODULO = seguridad.PERMISOROL.IDMODULO INNER JOIN
                      seguridad.ROL ON seguridad.PERMISOROL.IDROL = seguridad.ROL.IDROL

GO
/****** Object:  View [seguridad].[view_segPermisosByRolGET]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


			 CREATE VIEW [seguridad].[view_segPermisosByRolGET]
AS
SELECT u.iAppID as IDUSUARIO, r.IDROL, r.ROL, pa.IDPAGINA, pa.PAGINA, pa.ACTIVO AS activopagina, m.IDMODULO, m.MODULO, m.URL, m.ACTIVO AS activomodulo,  pa.CODIGO AS codigoPagina
FROM   seguridad.MODULO AS m INNER JOIN
             --seguridad.MODULO AS m ON m.IDAPLICACION = app.IDAPLICACION INNER JOIN
             seguridad.PERMISOROL AS pr ON pr.IDMODULO = m.IDMODULO INNER JOIN
             seguridad.PAGINA AS pa ON pa.IDPAGINA = pr.IDPAGINA INNER JOIN
             seguridad.ROL AS r ON r.IDROL = pr.IDROL INNER JOIN
             seguridad.esAppWebUsuario AS u ON u.IDROL = r.IDROL

GO
SET IDENTITY_INSERT [audiencia].[AudienciaTemp] ON 

INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (1, N'L.C.C. Brenda Verónica', N' López', N' Alejandro', N'X|SN', 1, 1, N'9231218252', N'simac.aguadulce@gmail.com', N'Audiencia Publica', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (2, N'Ing. Delfino', N' García ', N'Izquierdo', N'X|SN', 1, 1, N'9231410015', N'simac.aguadulce@gmail.com', N'Audiencia Publica', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (3, N'Sr. Leonardo', N' Deloya ', N'Catalán', N'San Moto|SN', 1, 1, N'9231086299', N'simac.aguadulce@gmail.com', N'Solicitud de trabajo ', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (4, N'Adrián', N' Méndez ', N'Juárez', N'Calle: Lerdo Ampliación Emiliano Zapata #29|SN', 1, 19, N'9231032629', N'simac.aguadulce@gmail.com', N'Solicitud de trabajo', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (5, N'Héctor ', N'Ortiz ', N'Domínguez', N'X|SN', 1, 1, N'9232352250', N'simac.aguadulce@gmail.com', N'COMUDE', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (6, N'Roberto ', N'Hernández ', N'Estrada', N'X|SN', 1, 1, N'9231004746', N'simac.aguadulce@gmail.com', N'COMUDE', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (7, N'Juan Manuel ', N'de la Cruz ', N'Sánchez ', N'Independencia #63 Col. Díaz Ordaz|SN', 1, 10, N'9231229152', N'simac.aguadulce@gmail.com', N'Mantenimiento de calle', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (8, N'Leticia ', N'jimenez', N'arias', N'Col. Díaz Ordaz Independencia #2|SN', 1, 10, N'92311807.36', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (9, N'Olga  ', N'perez', N'leon', N'Av. Los Pinos Col. Alborada|SN', 1, 26, N'9231222411', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (10, N'Carlos Alberto ', N'perez', N'', N'Col. El Palmar|SN', 1, 16, N'9231104998', N'simac.aguadulce@gmail.com', N'Trabajo ', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (11, N'Santiago ', N'gonzalez', N'carrillo', N'Emiliano Zapata #55 Ejido Arena|SN', 1, 19, N'9232382599', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (12, N'Víctor Manuel ', N'payro', N'fernandez', N'Eduardo Soto Ines #231 Col. 18 de Marzo|SN', 1, 58, N'9231019227', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (13, N'Israel ', N'osorio', N'arriaga', N'Col. El Bosque 2da Calle Mulato #16|SN', 1, 13, N'9231271816', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (14, N'Héctor ', N'gonzalez ', N'mayo', N'Calle. Cuauhtémoc S/N Tonalá|SN', 17, 56, N'9221582187', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (15, N'Yarib Rances ', N'contreras', N'cruz', N'Calle Vicente Toledan #7|SN', 1, 1, N'9981818369', N'simac.aguadulce@gmail.com', N'Mantenimiento de Calle', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (16, N'Andrea', N'justiniano', N'guillen', N'Calle Vicente Toledan #7|SN', 1, 1, N'2330927', N'simac.aguadulce@gmail.com', N'', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (17, N'Susana Cano Margado', N'cano', N'margado', N'Col. Los Pinos|SN', 1, 26, N'9231124003', N'simac.aguadulce@gmail.com', N'Basura', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (18, N'Alfredo ', N'escamilla', N'hernandez', N'A.V. Ferrocarril #640|SN', 1, 1, N'9622330669', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (19, N'Juan Enrique ', N'lozano', N'piña', N'Fco I Madero #1630 Col. 4 Caminos|SN', 1, 2, N'9231050375', N'simac.aguadulce@gmail.com', N'Apoyo de trancito', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (20, N'Concepción ', N'hernandez', N'carrillo', N'Col. Miguel Arenal Calle Cristo |SN', 1, 29, N'9231304351', N'simac.aguadulce@gmail.com', N'Trabajo ', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (21, N'Eva ', N'murrieta', N'martinez', N'Boca del Rio Veracruz |SN', 1, 1, N'99320530558', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (22, N'martin', N'vivero', N'acevedo', N'Drenajes Roto|SN', 1, 1, N'9231155113', N'simac.aguadulce@gmail.com', N'OBRAS. P', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (23, N'Lucia Fabiola d', N'de la Cruz ', N'chable', N'Constitución #17 Lázaro Cárdenas |SN', 1, 23, N'2281320956', N'simac.aguadulce@gmail.com', N'Organización ', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (24, N'Juan Antonio', N'centeno', N'chable', N'Carretera Tonalá Ejido Punta Gorda |SN', 13, 52, N'9231100874', N'simac.aguadulce@gmail.com', N'Alumbrado Publico', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (25, N'Melida del carmen', N'lopez', N'', N'Rafael Hernández Ochoa #15 col. Nueva del Rio|SN', 1, 34, N'9231055119', N'simac.aguadulce@gmail.com', N'Escuela', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (26, N'Angélica ', N'casango ', N'cortez', N'Col. El Papayal Carreta a las piedras|SN', 1, 17, N'9231272257', N'simac.aguadulce@gmail.com', N'Pavimentación ', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (27, N'María del Pilar ', N'garcia ', N'lopez', N'Col. Carretera a la panga bosque 2da |SN', 1, 13, N'9231119673', N'simac.aguadulce@gmail.com', N'Ampliación de red eléctrica', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (28, N'Jesús ', N'avalos', N'castellanos', N'Col. Magisterial |SN', 1, 27, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo a calle ', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (29, N'Elesvat ', N'hernandez', N'vazquez', N'Col. Km2 |SN', 1, 21, N'9231176194', N'simac.aguadulce@gmail.com', N'Entrega de solicitud Ampliación de drenaje ', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (30, N'Soledad ', N'arevalo', N'', N'Carmen Serdán #83 Col 4 Caminos|SN', 1, 2, N'2331610', N'simac.aguadulce@gmail.com', N'Invasión de Terreno Publico', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (31, N'marina', N'marcial', N'', N'C. Cuauhtémoc|SN', 1, 9, N'9231150634', N'simac.aguadulce@gmail.com', N'ALUMBRADO', CAST(N'2018-01-15T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (32, N'Eladio ', N'perez', N'reyes', N'Col. Solidaridad calle Jolipa s/n|SN', 1, 39, N'9231179418', N'simac.aguadulce@gmail.com', N'laboral ', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (33, N'Virginia ', N'sanchez', N'calzada', N'Col. Benito Juárez calle Cuauhtémoc|SN', 1, 9, N'9231356354', N'simac.aguadulce@gmail.com', N'drenaje', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (34, N'Luis ', N'acuña', N'rueda', N'Col. Benito Juárez calle Chetumal|SN', 1, 9, N'0000000000', N'simac.aguadulce@gmail.com', N'Drenajes', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (35, N'Silvia ', N'sanchez', N'', N'Col. El Muelle calle Adolfo López Mateos|SN', 1, 15, N'9231169656', N'simac.aguadulce@gmail.com', N'Alcantarillado', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (36, N'Alejo ', N'hernandez', N'herrera', N'Col. KM2 Calle Ursulo Galván |SN', 1, 21, N'0000000000', N'simac.aguadulce@gmail.com', N'Barda Caida', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (37, N'jorge', N'garcia', N'', N'Col. Ampliación Emiliano Zapata|SN', 1, 19, N'0000000000', N'simac.aguadulce@gmail.com', N'Laboral', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (38, N'Abigail ', N'dominguez', N'', N'X|SN', 1, 1, N'9231000360', N'simac.aguadulce@gmail.com', N'Escuela Leopoldo Lugones', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (39, N'Servando ', N'molina', N'villalobos', N'X|SN', 1, 1, N'9231222364', N'simac.aguadulce@gmail.com', N'Discapacitado', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (40, N'Pedro ', N'gonzalez', N'pacheco', N'X|SN', 1, 1, N'9231272933', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (41, N'Elvadoris ', N'hernandez', N'ricardez', N'Calle. Limones Col. 1005|SN', 1, 31, N'9231135805', N'simac.aguadulce@gmail.com', N'Comité de Calles ', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (42, N'Francisco ', N'beltran', N'', N'Col. 18 de Marzo|SN', 1, 58, N'2333449', N'simac.aguadulce@gmail.com', N'SALUDARLO', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (43, N'Landy Guillermina ', N'pech', N'ameica', N'Calle. Benito Juárez Col. Muelle|SN', 1, 15, N'9231324950', N'simac.aguadulce@gmail.com', N'Solicitud de Escuela', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (44, N'María Rosario ', N'pacheco', N'carranza', N'Col. 1005|SN', 1, 31, N'9231108292', N'simac.aguadulce@gmail.com', N'Pavimentación de Calle', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (45, N'Lucia ', N'sanchez', N'pola', N'Calle. Brito Col. Díaz Ordaz|SN', 1, 10, N'9231259118', N'simac.aguadulce@gmail.com', N'Jardín de Niños', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (46, N'Reyna ', N'garcia', N'hernandez', N'Col. Díaz Ordaz|SN', 1, 10, N'0000000000', N'simac.aguadulce@gmail.com', N'', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (47, N'Alejandro ', N'romero', N'', N'Calle Cerro Azul Col. 4 Caminos |SN', 2, 2, N'9231119164', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (48, N'José Francisco', N'osorio', N'jimenez', N'Col. 1005|SN', 1, 31, N'9231167742', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (49, N'María del Socorro ', N'ramirez', N'', N'Col. Díaz Ordaz|SN', 1, 10, N'9231055949', N'simac.aguadulce@gmail.com', N'Pozo', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (50, N'Gabriela ', N'castillo', N'martinez', N'Calle Emiliano Zapata Col. Nueva del Rio |SN', 1, 34, N'0000000000', N'simac.aguadulce@gmail.com', N'Puente Caído', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (51, N'Raymundo ', N'cuervo', N'gomez', N'Calle Narciso Mendoza Col. Abulón|SN', 1, 11, N'9231154077', N'simac.aguadulce@gmail.com', N'Deporte', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (52, N'Alejandro ', N'ortega', N'llamas', N'Calle Primera de mayo col. Díaz Ordaz|SN', 1, 10, N'9231261102', N'simac.aguadulce@gmail.com', N'Pre cartilla', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (53, N'Raúl ', N'castillejos', N'', N'Calle, Fco I Madero COL. Díaz Ordaz|SN', 1, 10, N'9231283230', N'simac.aguadulce@gmail.com', N'Calles', CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (54, N'Marcial ', N'rosales', N'perez', N'Ejido el Granero|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo de despensa ', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (55, N'Luis ', N'reyes', N'hernandez', N'Calle Franboyan #29 Col. 1005|SN', 1, 31, N'0000000000', N'simac.aguadulce@gmail.com', N'Calle Compostura', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (56, N'Consuelo ', N'toledo', N'', N'Col. Alborada |SN', 1, 5, N'0000000000', N'simac.aguadulce@gmail.com', N'Predial ', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (57, N'Gloria ', N'triano', N'correa', N'Col. Los Pinos|SN', 1, 26, N'0000000000', N'simac.aguadulce@gmail.com', N'Alumbrado', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (58, N'Tania ', N'aguilar', N'', N'Col. Insurgentes |SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Trabajo Personal ', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (59, N'Rafael', N'mumenthey', N'lopez', N'Tierra Blanca Col. Allende|SN', 1, 6, N'2333130', N'simac.aguadulce@gmail.com', N'Trabajo Personal', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (60, N'Juan ', N'de la druz', N'valencia', N'Jardín de niños Tonalá |SN', 17, 56, N'9231009954', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (61, N'Nery ', N'correa', N'may', N'Poblado Miguel Alemán |SN', 1, 1, N'9231176246', N'simac.aguadulce@gmail.com', N'LIMPIA PUBLICA', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (62, N'María ', N'espinoza', N'mendez', N'Tonalá|SN', 17, 56, N'9231178803', N'simac.aguadulce@gmail.com', N'Jardín de Niños Tonalá', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (63, N'Antonio ', N'gonzalez', N'hernandez', N'Col. Juan de la Barrera|SN', 1, 1, N'9231323976', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (64, N'Juan José ', N'tenorio', N'perez', N'Col. Los Pinos|SN', 1, 26, N'9231191664', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (65, N'Sebastián ', N'lopez', N'gonzalez', N'Col. Lázaro Cárdenas |SN', 1, 23, N'9231111096', N'simac.aguadulce@gmail.com', N'Alumbrado', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (66, N'Lucia Fabiola ', N'de la cruz', N'cabrera', N'Calle Constitución Col. Lázaro Cárdenas |SN', 1, 23, N'0000000000', N'simac.aguadulce@gmail.com', N'Solicitud de Difusión', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (67, N'Esperanza ', N'hernandez', N'jose', N'Calle Tolteca Col. 1005|SN', 1, 31, N'0000000000', N'simac.aguadulce@gmail.com', N'Predial', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (68, N'Enrique ', N'fonseca', N'perez', N'Col. Los Pinos|SN', 1, 26, N'2334631', N'simac.aguadulce@gmail.com', N'Solicitud de Topes ', CAST(N'2018-01-29T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (69, N'Román ', N'lopez', N'garcia', N'Calle 20 de noviembre #18|SN', 1, 1, N'9231137610', N'simac.aguadulce@gmail.com', N'Apoyo', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (70, N'Ernesto ', N'quintana', N'gallegos', N'Calle Ferrocarril Col. Uno y medio |SN', 1, 1, N'9231582682', N'simac.aguadulce@gmail.com', N'Relleno de Agujero', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (71, N'Sofía Guadalupe', N'morales', N'.', N'Calle Nuevo Panteón Col. Díaz Ordaz|SN', 1, 10, N'9211971778', N'simac.aguadulce@gmail.com', N'Liberación de Obra', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (72, N'Rosa del Carmen', N'sevilla', N'.', N'Col. Díaz Ordaz Calle. Francisco I madero # 21|SN', 1, 10, N'0000000000', N'simac.aguadulce@gmail.com', N'Invasión de terreno', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (73, N'Bertha karolina ', N'salinas', N'', N'Calle. Los pinos COL. 1005|SN', 1, 31, N'9232385056', N'simac.aguadulce@gmail.com', N'Apoyo para escuela.', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (74, N'Yesica Fabiola ', N'cordova ', N'dominguez', N'Calle. Quintana roo Col. Magisterial|SN', 1, 27, N'9231192730', N'simac.aguadulce@gmail.com', N'Apoyo para kinder', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (75, N'Marcela ', N'valenzuela', N'', N'Calle. Reforma Col.Benito Juárez|SN', 1, 8, N'9232315953', N'simac.aguadulce@gmail.com', N'Pavimentación de calle  ', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (76, N'Antonio ', N'cuevas', N'.', N'Calle. Matamoros Ampliación suspiro|SN', 1, 18, N'0000000000', N'simac.aguadulce@gmail.com', N'Predial ', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (77, N'María de Lourdes', N'laureano', N'', N'Calle. Emiliano zapata Col. Lázaro Cárdenas|SN', 1, 23, N'9231012141', N'simac.aguadulce@gmail.com', N'Alumbrado ', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (78, N'Luz Elena ', N'carballo', N'hernandez', N'Col. 4 caminos |SN', 1, 2, N'9231277783', N'simac.aguadulce@gmail.com', N'Apoyo iglesia ', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (79, N'Ofelia ', N'contreras', N'hernandez', N'Calle. Independencia Col. Díaz Ordaz|SN', 1, 10, N'9231009033', N'simac.aguadulce@gmail.com', N'Pozo para un caic dif', CAST(N'2018-02-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (80, N'Maribel ', N'rasgado', N'lopez', N'Col. Flores Magón|SN', 1, 1, N'2334021', N'simac.aguadulce@gmail.com', N'Mercado del Repasto', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (81, N'Manuel ', N'ricardez', N'madrigal', N'Calle Libertad #2 Col. Abulon|SN', 1, 11, N'2334571', N'simac.aguadulce@gmail.com', N'Pavimentación de calle ', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (82, N'Modesto ', N'velazquez', N'.', N'Col El Muelle|SN', 1, 15, N'9231265250', N'simac.aguadulce@gmail.com', N'Apoyo', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (83, N'Martin ', N'rodriguez', N'.', N'Calle Fco Villa Col. Benito Juarez|SN', 1, 8, N'9231285920', N'simac.aguadulce@gmail.com', N'', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (84, N'Victor ', N'castillo', N'sanchez', N'Col. Centro|SN', 1, 1, N'2281770240', N'simac.aguadulce@gmail.com', N'Apoyo para escuela', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (85, N'Julián ', N'sanchez ', N'gomez', N'Calle Rexamen Col. Obrera|SN', 1, 35, N'9232381410', N'simac.aguadulce@gmail.com', N'', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (86, N'José Alfredo', N'nolasco ', N'fonseca', N'Calle. Fransita Col.4 caminos|SN', 1, 2, N'9231123945', N'simac.aguadulce@gmail.com', N'Apoyo para pago predial', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (87, N'Laura', N'acosta', N'', N'Caic dif bambi|SN', 1, 1, N'9231108728', N'simac.aguadulce@gmail.com', N'Apoyo para un portón ', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (88, N'Maleni ', N'escalante', N'', N'Calle. Melchor Ocampo #5 Col. El muelle|SN', 1, 15, N'9231208991', N'simac.aguadulce@gmail.com', N'Trabajo madre soltera ', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (89, N'Santa Teresa ', N'diaz', N'rivera', N'Calle. Melchor Ocampo Col. El muelle|SN', 1, 15, N'9231201759', N'simac.aguadulce@gmail.com', N'Trabajo madre soltera ', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (90, N'Beatriz ', N'diaz', N'rivera', N'Calle. Melchor Ocampo Col. El muelle|SN', 1, 15, N'9237170747', N'simac.aguadulce@gmail.com', N'Trabajo madre soltera ', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (91, N'Carmen ', N'sanchez', N'', N'Calle. Hilario salas Col. El muelle|SN', 1, 15, N'9231101403', N'simac.aguadulce@gmail.com', N'Trabajo madre soltera ', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (92, N'Josefina ', N'rodriguez', N'alor', N'Calle. Amado Nervo Col. Emiliano zapata|SN', 1, 19, N'2336307', N'simac.aguadulce@gmail.com', N'persona', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (93, N'Silvia ', N'gonzalez', N'rios', N'Calle. Tlaxcala Col.1005|SN', 1, 31, N'9211278274', N'simac.aguadulce@gmail.com', N'Propuesta cultural', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (94, N'Alejandro ', N'señir', N'rodriguez', N'puebla|SN', 1, 1, N'4432775370', N'simac.aguadulce@gmail.com', N'Uniformes policía municipal', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (95, N'Sandra luz ', N'ocampo', N'.', N'Col. centro|SN', 1, 1, N'.', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (96, N'Felipe ', N'padron', N'rosales', N'Calle. Rafael Hernández Col. Nueva del rio|SN', 1, 34, N'9231114101', N'simac.aguadulce@gmail.com', N'Diversos ', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (97, N'Julieta ', N'arellano', N'cordoba', N'Calle. Entrada la gloria Col.1005|SN', 1, 31, N'9231182212', N'simac.aguadulce@gmail.com', N'apoyo', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (98, N'Adriana ', N'torres', N'carrillo', N'Calle. Cuauhtémoc|SN', 1, 1, N'9231391857', N'simac.aguadulce@gmail.com', N'Alumbrado Publico', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (99, N'Elizabeth ', N'ramirez', N'luna', N'Calle Juventino Rosas Col. El Bosque|SN', 1, 12, N'923.2351147', N'simac.aguadulce@gmail.com', N' Ayuda de Construcción ', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
GO
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (100, N'Bertha', N'gutierrez', N'', N'Calle Articulo #123 Col. Benito Juárez|SN', 1, 8, N'9211031029', N'simac.aguadulce@gmail.com', N'Alumbrado Publico', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (101, N'Sheila Cristal ', N'flores ', N'hernandez', N'Calle Luis Cortines Col. Cuauhtémoc |SN', 1, 9, N'9231386028', N'simac.aguadulce@gmail.com', N'Firma y Sello ', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (102, N'andres', N'lopez', N'lopez', N'Calle Venustiano Carranza Col. Los Pinos |SN', 1, 26, N'9231270651', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (103, N'Arturo ', N'', N'', N'Col. 4 Caminos |SN', 1, 2, N'9231107955', N'simac.aguadulce@gmail.com', N'Apoyo a la Comunidad', CAST(N'2018-01-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (104, N'Manuel ', N'gallardo', N'cruz', N'Col. 1005|SN', 1, 31, N'0000000000', N'simac.aguadulce@gmail.com', N'Adultos Mayores', CAST(N'2018-02-19T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (105, N'Luis ', N'acuña', N'rueda', N'Col. Benito Juárez|SN', 1, 8, N'0000000000', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (106, N'Carmen ', N'gallegos', N'sanchez', N' Col. Magisterial|SN', 1, 27, N'0000000000', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (107, N'María de la Cruz', N'barajas', N'chavez', N'Col. 1005|SN', 1, 31, N'0000000000', N'simac.aguadulce@gmail.com', N'Casa hogar para niños', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (108, N'Jorge Alberto ', N'medina', N'gonzalez', N'Calle. Bulevar L. Carenas Col. 18 de Marzo |SN', 1, 58, N'9231073851', N'simac.aguadulce@gmail.com', N'Predial', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (109, N'Román ', N'martinez', N'reyes', N'Calle Veracruz Col. Emiliano Zapata|SN', 1, 19, N'2335326', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (110, N'Rene ', N'colorado', N'cruz', N'Calle Veracruz Col. Emiliano Zapata|SN', 1, 19, N'9231126845', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (111, N'Jesús ', N'magaña', N'martinez', N'Calle Josefa Ortiz de Domínguez Col. El Muelle |SN', 1, 15, N'2334549', N'simac.aguadulce@gmail.com', N'Varos', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (112, N'Ramón ', N'cruz', N'ramirez', N'Col. Alborada|SN', 1, 5, N'2330021', N'simac.aguadulce@gmail.com', N'Alumbrado Publico', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (113, N'Rosa ', N'rivera', N'hernandez', N'Col. Alborada|SN', 1, 5, N'9231051749', N'simac.aguadulce@gmail.com', N'.', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (114, N'María del Carmen ', N'hernandez', N'.', N'Calle 25 de Enero Col. Miguel Hidalgo|SN', 1, 30, N'0000000000', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-10-29T00:00:49.657' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (115, N'Paul ', N'castillejos', N'.', N'Calle Fco i Madero Col. Díaz Ordaz |SN', 1, 10, N'9231283230', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (116, N'Hiram ', N'sastre', N'cordova', N'Calle Independencia Col. Km2|SN', 1, 21, N'0000000000', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (117, N'Austroberto ', N'brito', N'sargado', N'Calle. Usumacinta col. Solidaridad|SN', 1, 39, N'0000000000', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (118, N'Cinthya Karina', N'santos', N'.', N'Col. Allende|SN', 1, 6, N'9231326982', N'simac.aguadulce@gmail.com', N'Alumbrado', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (119, N'Pedro ', N'aposta', N'lopez', N'Calle 18 de ,marzo Col. Lázaro Cárdenas |SN', 1, 23, N'9231236108', N'simac.aguadulce@gmail.com', N'Permiso de Construcción ', CAST(N'2018-02-26T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (120, N'José Raúl ', N'de la cruz', N'Acuña', N'Calle Niños Héroes Col. 1005 |SN', 1, 31, N'9231390755', N'simac.aguadulce@gmail.com', N'Construcción de barda', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (121, N'Juan ', N'santiago', N'milagro', N'Calle Emiliano Zapata Col. |SN', 1, 19, N'9231204068', N'simac.aguadulce@gmail.com', N'Remodelación de casa', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (122, N'Lucio', N'dominguez', N'.', N'Calle 8 de Mayo Col. El Muelle|SN', 1, 15, N'9232384209', N'simac.aguadulce@gmail.com', N'Rehabilitación de calle ', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (123, N'Juan Pablo', N'hernandez', N'.', N'Calle Allende Col. Allende|SN', 1, 6, N'9231196068', N'simac.aguadulce@gmail.com', N'Convenio de barda', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (124, N'Yanet ', N'zapata', N'lopez', N'Calle Abulón Col. Abulón|SN', 1, 11, N'9231094115', N'simac.aguadulce@gmail.com', N'Permiso para negocio personal', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (125, N'Ángel ', N'olan', N'hernandez', N'Tonalá|SN', 17, 56, N'9331069367', N'simac.aguadulce@gmail.com', N'Permiso para negocio personal', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (126, N'Ezequiel ', N'lopez', N'.', N'Col. 4 caminos|SN', 1, 2, N'2334796', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (127, N'Guillermo  ', N'lopez', N'.', N'Ejido Corrosal|SN', 5, 44, N'0000000000', N'simac.aguadulce@gmail.com', N'Rollos de Alambre', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (128, N'Liliana ', N'perez', N'hernandez', N'Ejido Migel Alemán|SN', 1, 29, N'9231306331', N'simac.aguadulce@gmail.com', N'Transporte ', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (129, N'Raúl ', N'solorzano', N'.', N'Díaz Ordaz|SN', 1, 10, N'9231283230', N'simac.aguadulce@gmail.com', N'Regularización de terreno', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (130, N'Fco ', N'saucedo', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Regularización de terreno', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (131, N'Piñón ', N'de la cruz', N'.', N'La bloquera|SN', 1, 1, N'9231087839', N'simac.aguadulce@gmail.com', N'OBRAS PUBLICAS', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (132, N'Rodolfo ', N'santos', N'.', N'Calle Tolteca Col. 1005|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'PREDIAL', CAST(N'2018-03-05T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (134, N'José Antonio ', N'castellanos', N'.', N'X|SN', 1, 1, N'89231207980', N'simac.aguadulce@gmail.com', N'Calle', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (135, N'Mónica ', N'jimenez', N'martinez', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (136, N'Baudel', N'sanchez', N'.', N'X|SN', 1, 1, N'9231104804', N'simac.aguadulce@gmail.com', N'Camino', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (137, N'Roberto ', N'castillo', N'.', N'X|SN', 1, 1, N'9231327378', N'simac.aguadulce@gmail.com', N'Calle y alumbrado', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (138, N'Gerardo ', N'de la cruz', N'.', N'X|SN', 1, 1, N'9231387435', N'simac.aguadulce@gmail.com', N'Alumbrado', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (139, N'Rosa ', N'garcia', N'sanchez', N'X|SN', 1, 1, N'9231104450', N'simac.aguadulce@gmail.com', N'Invasión de terreno', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (140, N'Miguel ', N'martinez', N'gomez', N'X|SN', 1, 1, N'9231092946', N'simac.aguadulce@gmail.com', N'Asunto de Ejido', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (141, N'Rosalba ', N'valdilleso', N'zarate', N'X|SN', 1, 1, N'9231207980', N'simac.aguadulce@gmail.com', N'Apoyo de salud', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (142, N'Ismael', N'cabrera', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Tope', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (143, N'Gabriel ', N'lara', N'gonzalez', N'X|SN', 1, 1, N'9232385598', N'simac.aguadulce@gmail.com', N'Ayuda a Traslado', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (144, N'Celia ', N'aguilar', N'.', N'X|SN', 1, 1, N'9231186091', N'simac.aguadulce@gmail.com', N'Deporte ', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (145, N'Jazmín ', N'barahona', N'.', N'X|SN', 1, 1, N'9231083547', N'simac.aguadulce@gmail.com', N'Pavimentación', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (146, N'Jazmín', N'mendez', N'.', N'X|SN', 1, 1, N'5527163138', N'simac.aguadulce@gmail.com', N'Parque', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (147, N'Pedro ', N'gonzalez', N'gomez', N'X|SN', 1, 1, N'9231214625', N'simac.aguadulce@gmail.com', N'Ecología', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (148, N'Soledad ', N'perez', N'villalobos', N'X|SN', 1, 1, N'9231322027', N'simac.aguadulce@gmail.com', N'Poblado', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (149, N'Juana ', N'alejandro', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo a Ejido los Soldados', CAST(N'2018-03-12T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (150, N'José Manuel ', N'zurita', N'arjona', N'X|SN', 1, 1, N'9231111922', N'simac.aguadulce@gmail.com', N'Topes en la Col. Allende', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (151, N'Luis ', N'acuña', N'rueda', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Drenaje Col. 1005', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (152, N'Josefina ', N'santos', N'espinoza', N'X|SN', 1, 1, N'9231149198', N'simac.aguadulce@gmail.com', N'Apoyo para pensión ', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (153, N'María ', N'perez', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo para pensión', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (154, N'Mauricio ', N'osorio', N'.', N'X|SN', 1, 1, N'92312228877', N'simac.aguadulce@gmail.com', N'Obra', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (155, N'Teofilina ', N'santos', N'santiago', N'X|SN', 1, 1, N'9231308077', N'simac.aguadulce@gmail.com', N'Comercio', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (156, N'Humberto ', N'fernandez', N'garcia', N'X|SN', 1, 1, N'9231088140', N'simac.aguadulce@gmail.com', N'Apoyo para trasladar paciente', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (157, N'Rafael ', N'malpica', N'cordova', N'X |SN', 1, 1, N'9231179938', N'simac.aguadulce@gmail.com', N'Información', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (158, N'Onésimo ', N'jimenez', N'de la cruz', N'X|SN', 1, 1, N'9231016813', N'simac.aguadulce@gmail.com', N'Reunión para agente municipal', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (159, N'Irvin', N'rodriguez', N'alvarado', N'X|SN', 1, 1, N'9231211048', N'simac.aguadulce@gmail.com', N'Pagos', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (160, N'elizabeth', N'lopez', N'sanchez', N'X|SN', 1, 1, N'9231313132', N'simac.aguadulce@gmail.com', N'Proteger Animales de la Calle ', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (161, N'Emiliano', N'gonzalez', N'.', N'X|SN', 1, 1, N'9231084344', N'simac.aguadulce@gmail.com', N'Ampliación de red Eléctrica', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (162, N'Josefa ', N'diaz', N'montalvo', N'X|SN', 1, 1, N'2293202934', N'simac.aguadulce@gmail.com', N'Recuperación de Propiedad', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (163, N'giselle', N'palacios', N'beltran', N'X|SN', 1, 1, N'9231140687', N'simac.aguadulce@gmail.com', N'Regularización de Terreno', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (164, N'Edgar Demetrio ', N'gonzalez ', N'lopez', N'X|SN', 1, 1, N'9231356356', N'simac.aguadulce@gmail.com', N'Rehabilitación de calle', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (165, N'Hernández', N'hernandez', N'perez', N'X|SN', 1, 1, N'923.1123783', N'simac.aguadulce@gmail.com', N'Problema en la calle', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (166, N'María Rosario', N'pacheco', N'.', N'X|SN', 1, 1, N'9231108292', N'simac.aguadulce@gmail.com', N'Problema en la cale ', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (167, N'Ricardo ', N'toledo', N'.', N'X|SN', 1, 1, N'9231180440', N'simac.aguadulce@gmail.com', N'Apoyo para traslado', CAST(N'2018-04-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (168, N'José Reyes ', N'castillo', N'alejandro', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Alumbrado Publico', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (169, N'Rodolfo ', N'perez', N'.', N'X|SN', 1, 1, N'9231305214', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (170, N'Roberto ', N'ortiz', N'.', N'X|SN', 1, 1, N'9231012523', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (171, N'Miguel ', N'alejandro', N'corteza', N'X|SN', 1, 1, N'2332787', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (172, N'Lorena', N'campos', N'martinez', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (173, N'José ', N'lopez', N'hernandez', N'X|SN', 1, 1, N'9211541150', N'simac.aguadulce@gmail.com', N'ASUNTOS RELIGIOSO', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (174, N'Javier', N'roman', N'.', N'X|SN', 1, 1, N'2333545', N'simac.aguadulce@gmail.com', N'Obra', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (175, N'Emiliano ', N'gonzalez', N'.', N'X|SN', 1, 1, N'9231084344', N'simac.aguadulce@gmail.com', N'Ampliación de calle', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (176, N'Manuel ', N'ricardez', N'.', N'X|SN', 1, 1, N'2334571', N'simac.aguadulce@gmail.com', N'pavimentación', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (177, N'María ', N'lopez', N'garcia', N'X|SN', 1, 1, N'9231221484', N'simac.aguadulce@gmail.com', N'Carta Residencial', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (178, N'Alfredo ', N'oropeza', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'PERSONAL', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (179, N'María del Carmen', N'gamboa', N'.', N'X|SN', 1, 1, N'9231196014', N'simac.aguadulce@gmail.com', N'Descuento de permiso ', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (180, N'Romero', N'sanchez', N'.', N'X|SN', 1, 1, N'923.2380168', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (181, N'', N'rivera', N'zamora', N'X|SN', 1, 1, N'92311028.96', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (182, N'Aurelio ', N'gomez', N'hipolitico', N'X|SN', 1, 1, N'2333601', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (183, N'José del Carmen', N'ramos ', N'rosas', N'X|SN', 1, 1, N'9231165506', N'simac.aguadulce@gmail.com', N'Obras Publicas', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (184, N'María del Carmen ', N'romero', N'.', N'X|SN', 1, 1, N'9231175481', N'simac.aguadulce@gmail.com', N'Seguridad Publica', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (185, N'Javier Santiago', N'santiago', N'morales', N'X|SN', 1, 1, N'9231013920', N'simac.aguadulce@gmail.com', N'Obras Publicas', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (186, N'Adela ', N'sastre', N'cortazar', N'X|SN', 1, 1, N'9231213422', N'simac.aguadulce@gmail.com', N'Obras Publicas', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (187, N'Julio ', N'antonio', N'aguilar', N'X|SN', 1, 1, N'9211693294', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (188, N'Agustín ', N'palacios', N'.', N'X|SN', 1, 1, N'9211310960', N'simac.aguadulce@gmail.com', N'Entrega de Documentos', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (189, N'Belisario ', N'milla', N'balcazar', N'X|SN', 1, 1, N'9231320336', N'simac.aguadulce@gmail.com', N'Arreglar Calle', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (190, N'Luis ', N'rueda', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (191, N'Jardín de niños Gama ', N'.', N'.', N'X|SN', 1, 1, N'9231378560', N'simac.aguadulce@gmail.com', N'Terreno del Kinder', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (192, N'Reyes ', N'madrigal', N'.', N'X|SN', 1, 1, N'2332811', N'simac.aguadulce@gmail.com', N'Pago de Predial', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (193, N'María ', N'leon ', N'gutierrez', N'X|SN', 1, 1, N'9231112637', N'simac.aguadulce@gmail.com', N'Drenaje de Vecindad', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (194, N'Janet ', N'zamora', N'mendoza', N'X|SN', 1, 1, N'2335565', N'simac.aguadulce@gmail.com', N'Pavimentación Calle el Bosque ', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (195, N'Olivia ', N'ruiz', N'guzman', N'X|SN', 1, 1, N'9992013889', N'simac.aguadulce@gmail.com', N'Construcción de Capilla Naranjal', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (196, N'Teresita ', N'santiago', N'', N'X|SN', 1, 1, N'9231322190', N'simac.aguadulce@gmail.com', N'Alumbrado publico', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (197, N'Joany', N'romero', N'sanchez', N'X|SN', 1, 1, N'9232800168', N'simac.aguadulce@gmail.com', N'Terminaciones Obras eléctrica', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (198, N'Rosa ', N'robles', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo para la Telesecundaria 18 de marzo', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (199, N'Emiliano', N'ramirez', N'.', N'X|SN', 1, 1, N'9231121546', N'simac.aguadulce@gmail.com', N'Electrificación e la Col. 1005', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (200, N'Aristeo ', N'flores', N'.', N'X|SN', 1, 1, N'9232386816', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
GO
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (201, N'García ', N'garcia diaz', N'.', N'X|SN', 1, 1, N'9211798345', N'simac.aguadulce@gmail.com', N'Entrega de Documentos por Invasión a terrenos', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (202, N'Isabel ', N'sanchez', N'.', N'X|SN', 1, 1, N'9231376042', N'simac.aguadulce@gmail.com', N'Kínder del Ejido Cuauhtémoc  ', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (203, N'Adriana ', N'garcia diaz', N'.', N'X|SN', 1, 1, N'9231359896', N'simac.aguadulce@gmail.com', N'Invasión de terreno', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (204, N'María ', N'gil', N'almeida', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (205, N'José ', N'rodriguez', N'lopez', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (206, N'Martha ', N'morales', N'', N'X|SN', 1, 1, N'99342528720', N'simac.aguadulce@gmail.com', N'Firma de documentos', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (207, N'José ', N'luis', N'leon', N'X|SN', 1, 1, N'9231054726', N'simac.aguadulce@gmail.com', N'Electrificación por Juventino Rosas ', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (208, N'Roció ', N'magaña', N'lopez', N'X|SN', 1, 1, N'9211608663', N'simac.aguadulce@gmail.com', N'Apoyo para tramitar posición de derechos', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (209, N'Pablo ', N'pacheco', N'.', N'X|SN', 1, 1, N'9231322990', N'simac.aguadulce@gmail.com', N'Rehabilitación de calle', CAST(N'2018-04-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (210, N'Isidra Sánchez Jiménez ', N'sanchez', N'jimenez', N'X|SN', 1, 1, N'9231019818', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (211, N'Ros González Sánchez ', N'gonzalez', N'sanchez', N'X|SN', 1, 1, N'9231168099', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (212, N'Jesús Miguel Almeida Jiménez', N'almeida', N'sanchez', N'X|SN', 1, 1, N'9232317578', N'simac.aguadulce@gmail.com', N'Mantenimiento al Parque Col. El Muelle ', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (213, N'Deysi Patricia Pérez Jiménez', N'perez', N'jimenez', N'X|SN', 1, 1, N'9231004925', N'simac.aguadulce@gmail.com', N'Gestión de Alcantarillado', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (214, N'José Luis Rodríguez Alvarado', N'rodriguez', N'alvarado', N'X|SN', 1, 1, N'9232315350', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (215, N'Johana Romero Sánchez', N'romero', N'sanchez', N'X|SN', 1, 1, N'9232380168', N'simac.aguadulce@gmail.com', N'Solicitud de Energía Eléctrica para escuela', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (216, N'Rosa Mendoza Pérez  ', N'mendoza', N'perez', N'X|SN', 1, 1, N'9232333108', N'simac.aguadulce@gmail.com', N'Drenaje en la Col. Díaz Ordaz', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (217, N'José Manuel Damas González ', N'damas', N'gonzalez', N'X|SN', 1, 1, N'9231008278', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (218, N'Erasmo Ramos', N'ramos', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (219, N'Anna Jiménez Isidro', N'jimenez', N'isidro', N'X|SN', 1, 1, N'9231310783', N'simac.aguadulce@gmail.com', N'Apoyo', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (220, N'Raquel Casango Morales', N'casango', N'morales', N'X|SN', 1, 1, N'9231320927', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (221, N'Iris Jazmín Chávez Vázquez', N'chavez', N'vazquez', N'X|SN', 1, 1, N'9241451856', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (222, N'Vanesa Rivera Zamora', N'rivera', N'zamora', N'X|SN', 1, 1, N'9231102896', N'simac.aguadulce@gmail.com', N'Residencia', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (223, N'Sonia del Carmen ', N'.', N'.', N'X|SN', 1, 1, N'9231329459', N'simac.aguadulce@gmail.com', N'Terminaciones la Calle los pinos', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (224, N'José Fernando Puente', N'puente', N'.', N'X|SN', 1, 1, N'9231219597', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (225, N'Anna Berta González López', N'gonzalez', N'lopez', N'X|SN', 1, 1, N'92310599.61', N'simac.aguadulce@gmail.com', N'Obra eléctrica en Tonalá', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (226, N'Yolanda González ', N'gonzalez', N'.', N'X|SN', 1, 1, N'.', N'simac.aguadulce@gmail.com', N'Torre en Afectación de casa', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (227, N'Leticia Olan', N'olan', N'.', N'X|SN', 1, 1, N'9231051197', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (228, N'Ricardo ', N'toledo', N'feliz', N'X|SN', 1, 1, N'921.1283472', N'simac.aguadulce@gmail.com', N'Solicitud de Lámparas ', CAST(N'2018-04-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (230, N'Andrés ', N'castillo', N'gutierrez', N'Calle 3 valles #10 Col. Solidaridad|SN', 1, 39, N'9931202701', N'simac.aguadulce@gmail.com', N'Apoyo para relleno de terreno', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (231, N'Daniel ', N'aniceto', N'alcudia', N'Col. Mirador|SN', 1, 1, N'9212083214', N'simac.aguadulce@gmail.com', N'Laboral', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (232, N'María Teresa', N'sosa', N'garcia', N'KM.S/N|SN', 1, 1, N'9231258047', N'simac.aguadulce@gmail.com', N'Rebaja para pagar predial', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (233, N'María ', N'garza', N'lopez', N'Escuela Morelos Jiménez #26|SN', 1, 1, N'9231018445', N'simac.aguadulce@gmail.com', N'Aclaración de transporte', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (234, N'Juan ', N'santiago', N'milagros', N'Col. Nueva del Rio Calle. Emiliano Zapata|SN', 1, 34, N'0000000000', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (235, N'Pablo ', N'baez', N'santiago', N'Col. Allende|SN', 1, 6, N'0000000000', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (236, N'Iris ', N'chavez', N'vazquez', N'Col. El Muelle|SN', 1, 15, N'9241451856', N'simac.aguadulce@gmail.com', N'trabajo', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (237, N'Rosa ', N'gonzañez', N'santos', N'Col. Cuauhtémoc|SN', 1, 9, N'9231168099', N'simac.aguadulce@gmail.com', N'Terreno de gestión de panteón', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (238, N'José ', N'reyes', N'santos', N'Ejido el Pesquero|SN', 14, 53, N'.', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (239, N'María Cruz ', N'arcia', N'perez', N'Col. El Muelle|SN', 1, 15, N'9231353428', N'simac.aguadulce@gmail.com', N'Problemas con terreno', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (240, N'Aristeo ', N'flores', N'garcia', N'Ejido la Arena|SN', 18, 57, N'9232386816', N'simac.aguadulce@gmail.com', N'Apoyo personal', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (241, N'Jesús ', N'peralta', N'garcia', N'Calle Francisco I. Madero col. El Abulón|SN', 1, 11, N'9231112306', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (242, N'Jessica del Carmen  ', N'cervantes', N'm', N'Col. 4 caminos|SN', 1, 2, N'9211173746', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (243, N'Juan Antonio', N'barahona ', N'balcazar', N'Ejido Cuauhtémoc|SN', 1, 1, N'9231318549', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (244, N'Víctor  ', N'carrillo', N'correa', N'Ejido la Arena|SN', 18, 57, N'9231176669', N'simac.aguadulce@gmail.com', N'Obras para el ejido', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (245, N'José Guadalue', N'gongora', N'.', N'Ejido el Encanto Pesquero |SN', 14, 53, N'9231078206', N'simac.aguadulce@gmail.com', N'Solicitud de apoyo para el día de las madres', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (246, N'Abigail ', N'rodriguez', N'.', N'Km 2 1/2|SN', 1, 1, N'9231289884', N'simac.aguadulce@gmail.com', N'Gestión para la pavimentación de la calle', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (247, N'Ixel ', N'maldonado', N'hernandez', N'Col km 2 ½ por el estadio|SN', 1, 1, N'9231184945', N'simac.aguadulce@gmail.com', N'Proyectos  entrevista de educación', CAST(N'2018-03-07T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (258, N'Fidela ', N'gonzalez', N'cabrera', N'Agustín Melgar |SN', 1, 1, N'9231284599', N'simac.aguadulce@gmail.com', N'Personal ', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (259, N'Remedios ', N'cordova', N'hernandez', N'Ejido Piedras Negras|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Solicitar apoyo para operación en los Ojos', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (260, N'Ramón', N'jimenez', N'sanchez', N'Col. El Muelle|SN', 1, 15, N'9231262710', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (261, N'Luis ', N'acuña', N'.', N'Col. Benito Juárez|SN', 1, 8, N'9920098', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (262, N'Jesús Alberto', N'izquierdo', N'.', N'Calle. Nanchital Col. 4 Caminos|SN', 1, 2, N'9231176298', N'simac.aguadulce@gmail.com', N'Problema con agente municipal ', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (263, N'Eliverta ', N'palacios', N'.', N'Ejido. Miguel Aleman |SN', 1, 1, N'9231179375', N'simac.aguadulce@gmail.com', N'Apoyo para Caic Dif', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (264, N'Josué ', N'jiménez', N'.', N'Guadalupe Victoria #305|SN', 1, 1, N'9231231146', N'simac.aguadulce@gmail.com', N'Descuento para predial', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (265, N'Clemente ', N'canche', N'.', N'Col. Pajaral|SN', 1, 1, N'2335917', N'simac.aguadulce@gmail.com', N'Electrificación de calle', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (266, N'Lic. Natividad ', N'carrillo', N'.', N'Calle San German #128 Col. Emiliano Zapata |SN', 1, 19, N'9231115676', N'simac.aguadulce@gmail.com', N'Pavimentación de calle ', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (267, N'Víctor ', N'mancera', N'.', N'Centro|SN', 1, 1, N'2332002', N'simac.aguadulce@gmail.com', N'Datos Generales', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (268, N'Martin ', N'cruz', N'.', N'Cedral|SN', 4, 43, N'9232330948', N'simac.aguadulce@gmail.com', N'Apoyo al Kinder Col. Cedral Col El Muelle', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (269, N'Grupo Progreso Salud para la Comunidad ', N'.', N'.', N'Ferrocarril #296|SN', 1, 1, N'9232330948', N'simac.aguadulce@gmail.com', N'Entrega de Oficio', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (270, N'Teresa ', N'martínez', N'.', N'Flores Magón |SN', 1, 1, N'9381000812', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (271, N'María ', N'gil', N'.', N'Calle Reforma #35|SN', 1, 1, N'9231058273', N'simac.aguadulce@gmail.com', N'Apoyo para checar un deslave ', CAST(N'2018-05-21T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (300, N'Javier ', N'valdovillo', N'roman', N'Calle: principal suspiro # 14|SN', 1, 18, N'0000000000', N'simac.aguadulce@gmail.com', N'Muro de contención ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (301, N'Rubén A. ', N'gallegos', N'.', N'CETMART #15|SN', 1, 1, N'9221155098', N'simac.aguadulce@gmail.com', N'butacas', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (302, N'Landy ', N'pech', N'.', N'Quetzalcóatl |SN', 1, 1, N'9231324950', N'simac.aguadulce@gmail.com', N'Limpieza de patio', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (303, N'Joanna', N'romero', N'sanchez', N'Encanto Pesquero |SN', 14, 53, N'92323802168', N'simac.aguadulce@gmail.com', N'Apoyo de transporte', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (304, N'Sergio ', N'toledo', N'felix', N'Col. Kilómetro 2|SN', 1, 21, N'9231080093', N'simac.aguadulce@gmail.com', N'Alumbrado y drenaje ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (305, N'Clemente ', N'canche', N'mora', N'papayal|SN', 1, 1, N'.', N'simac.aguadulce@gmail.com', N'Alumbrado y pavimentación ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (306, N'hiram', N'mendez', N'lopez', N'Col. Juárez # 33, calle vicente suarez|SN', 1, 8, N'9331165554', N'simac.aguadulce@gmail.com', N'Pozo de agua ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (307, N'Felipe ', N'villalobos', N'.', N'Cayetano rodríguez,col-lazaro cardenas|SN', 1, 23, N'9231074808', N'simac.aguadulce@gmail.com', N'Personal ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (308, N'María del refugio ', N'garcia', N'lopez', N'Escuela José María y Pavón |SN', 1, 1, N'9231018445', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (309, N'Andrés ', N'salazar', N'gonzalez', N'Col. mil cinco|SN', 1, 31, N'.', N'simac.aguadulce@gmail.com', N'Terreno ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (310, N'Luz María', N'morales', N'.', N'Lázaro cárdenas  #204 |SN', 1, 23, N'9231121073', N'simac.aguadulce@gmail.com', N'Personal ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (311, N'Urania ', N'sanchez', N'sanchez', N'Jardín de niños matiana |SN', 1, 1, N'9231288301', N'simac.aguadulce@gmail.com', N'Apoyo escuela ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (312, N'Natividad ', N'garcia', N'carrillo', N'Calle: San German ,col.emiliano zapata|SN', 1, 19, N'9231115673', N'simac.aguadulce@gmail.com', N'pavimentación', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (313, N'Laura ', N'garcia', N'olin', N'Col. Solidaridad |SN', 1, 39, N'9231193138', N'simac.aguadulce@gmail.com', N'Pavimentación ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (314, N'Orlando ', N'castellanos', N'.', N'Guillermo prieto |SN', 1, 1, N'.', N'simac.aguadulce@gmail.com', N'Calle ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (315, N'Carmen ', N'rodriguez', N'.', N'Hnos. Serdán #113|SN', 1, 1, N'92332389', N'simac.aguadulce@gmail.com', N'Calle ', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (316, N'Esteban ', N'ramirez', N'.', N'Col. Naranjal |SN', 1, 32, N'9231394478', N'simac.aguadulce@gmail.com', N'Apoyo económico', CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (317, N' Alberto  ', N'cortez', N'morales', N'Calle Los Coquitos #10 Col. 1005|SN', 1, 31, N'9231201877', N'simac.aguadulce@gmail.com', N'Pavimentación de calle', CAST(N'2018-06-18T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (318, N'Anna María  ', N'salas', N'ochoa', N'Col. Emiliano Zapata|SN', 1, 19, N'9231167316', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-06-18T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (319, N'Miguel ', N'cruz', N'santos', N'Calle Art. 123 Col. Benito Juárez|SN', 1, 8, N'9231167316', N'simac.aguadulce@gmail.com', N'Pavimentación de Calle', CAST(N'2018-06-18T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (320, N'Ramiro ', N'garcia', N'carrillo', N'Playa las Palmitas Col. Ej El Tortugero |SN', 8, 47, N'9231094091', N'simac.aguadulce@gmail.com', N'Electrificación de Calle', CAST(N'2018-06-18T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (321, N'Alejandro ', N'medina', N'perez', N'Calle fco i Madero Col. Centro|SN', 1, 1, N'2334062', N'simac.aguadulce@gmail.com', N'x', CAST(N'2018-06-18T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (325, N'Luis ', N'acuña', N'rueda', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Drenaje Col. Benito Juárez', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (326, N'Adelfa ', N'gomez', N'hernandez', N' X|SN', 1, 1, N'9232381005', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (327, N'Modesto ', N'velazquez', N'.', N'X|SN', 1, 1, N'9231165280', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (328, N'Roman ', N'varales', N'.', N'X|SN', 1, 1, N'9231188400', N'simac.aguadulce@gmail.com', N'Limpieza de Aguas Negras', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (329, N'Jose ', N'ventura', N'pacheco', N'X|SN', 1, 1, N'9231003443', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (330, N'Alberto ', N'ovando', N'martinez', N'X|SN', 1, 1, N'9212227805', N'simac.aguadulce@gmail.com', N'Plataforma Petrolera (Pescadores)', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (331, N'Daniel ', N'padilla', N'solis', N'X|SN', 1, 1, N'9231120504', N'simac.aguadulce@gmail.com', N'Liberación de Camioneta ', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (332, N'Teresa ', N'ortiz', N'bautisto', N'X|SN', 1, 1, N'9231315719', N'simac.aguadulce@gmail.com', N'X', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (333, N'Eliane ', N'alaniz', N'.', N'X|SN', 1, 1, N'2331962', N'simac.aguadulce@gmail.com', N'Apoyo a joven deportista', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (334, N'Jesús ', N'de la cruz', N'lopez', N'X|SN', 1, 1, N'9232312894', N'simac.aguadulce@gmail.com', N'Alumbrado', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (335, N'Luz del Alba ', N'moreno', N'.', N'X|SN', 1, 1, N'2333134', N'simac.aguadulce@gmail.com', N'Solicitud de Drenaje', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (336, N'Alicia ', N'gutierrez', N'gonzalez', N'X|SN', 1, 1, N'9231356154', N'simac.aguadulce@gmail.com', N'Deslave Col. 18 de Marzo', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (337, N'Verónica ', N'presenda', N'.', N'X|SN', 1, 1, N'9231019654', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (338, N'Isaac ', N'rivas', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (340, N'Valentín ', N'dominguez', N'martinez', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Calle y paquecito', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (341, N'David ', N'correa', N'pablo', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Gestión de Pozo', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (342, N'Rosa ', N'olan', N'morales', N'X|SN', 1, 1, N'9232386902', N'simac.aguadulce@gmail.com', N'Reporte de Alumbrado', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (344, N'Karina ', N'velazquez', N'gonzalez', N'X|SN', 1, 1, N'9231015031', N'simac.aguadulce@gmail.com', N'Gestión de Becas', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
GO
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (345, N'Guadalupe ', N'torres ', N'javier', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Barda a punto de caerse ', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (346, N'María del Carmen  ', N'ovando', N'hernandez', N'X|SN', 1, 1, N'9231274280', N'simac.aguadulce@gmail.com', N'Alumbrado público ', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (347, N'Jonathan ', N'hernandez', N'.', N'X|SN', 1, 1, N'9231281536', N'simac.aguadulce@gmail.com', N'Gestión de Becas', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (348, N'Manuel ', N'ricardez', N'madrigal', N'X|SN', 1, 1, N'9232334571', N'simac.aguadulce@gmail.com', N'Pavimentación de callejón ', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (349, N'Ariadna ', N'escobar', N'sibaja', N'x|SN', 1, 1, N'2334035', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (350, N'Ana Luisa ', N'rendon', N'hernandez', N'X|SN', 1, 1, N'92310167.41', N'simac.aguadulce@gmail.com', N'Petición de Kínder Gama', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (351, N'Manuel ', N'rodriguez', N'adriano', N'X|SN', 1, 1, N'9231059457', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (352, N'María luisa', N'hernandez', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Ayuda ', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (353, N'Felipe ', N'cordova', N'cruz', N'X|SN', 1, 1, N'9361214786', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (354, N'Clemente ', N'canche', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo a Alumbrado Publico', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (355, N'Fernando ', N'arias', N'jimenez', N'X|SN', 1, 1, N' 92323334456', N'simac.aguadulce@gmail.com', N'Pavimentación de calle', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (356, N'Rodrigo ', N'ortega', N'sanchez', N'X|SN', 1, 1, N'9231018100', N'simac.aguadulce@gmail.com', N'Pavimentación de calle', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (357, N'Sandra Luz ', N'montiel', N'ordaz', N'X|SN', 1, 1, N'9231217444', N'simac.aguadulce@gmail.com', N'Gestión de Vecas', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (358, N'Humberto ', N'fernandez', N'.', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Solicitud para maquinaria', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (359, N'Veronica ', N'dominguez', N'.', N'Calle Ferrocarril|SN', 1, 1, N'92319250.88', N'simac.aguadulce@gmail.com', N'Problema de tope alto', CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (360, N'Jessenia ', N'cuevas', N'castellanos', N'Calle Vicente Suarez. |SN', 1, 1, N'9231227432', N'simac.aguadulce@gmail.com', N'Drenaje Arboles ', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (361, N'Luis ', N'alcudia', N'rueda', N'Calle Pantano Col. Benito Juárez|SN', 1, 8, N'0000000000', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (362, N'Ambrosio ', N'dominguez', N'.', N'Col.  |SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (363, N'Lidia ', N'ortiz', N'.', N'Col. centro Calle Putarco Elías|SN', 1, 1, N'5554668681', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (364, N'Idalia ', N'ortiz', N'durante', N'Calle Miguel Hidalgo Col. Tonalá |SN', 17, 56, N'9231311871', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (365, N'Aries Belén  ', N'dominguez', N'.', N'L a venta Tab.|SN', 1, 1, N'9231283777', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (366, N'Patrona ', N'ponce', N'perez', N'Calle el Manguito Col. 1005|SN', 1, 31, N'0000000000', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (367, N'Carlos Lucio ', N'martinez', N'.', N'Calle Benito Juarez Col. Obrera |SN', 1, 35, N'2331041', N'simac.aguadulce@gmail.com', N'Apoyo para Iglesia ', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (368, N'Laura ', N'lopez', N'notario', N'X|SN', 1, 1, N'9231165469', N'simac.aguadulce@gmail.com', N'Gestión Para transformador ', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (369, N',María del Carmen  ', N'gonzalez', N'.', N'X|SN', 1, 1, N'9231131991', N'simac.aguadulce@gmail.com', N'Problemas de Luz y Drenaje ', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (370, N'María Guadalupe ', N'chang', N'.', N'X|SN', 1, 1, N'9231214111', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (371, N'Julio Cesar ', N'muñiz', N'.', N'X|SN', 1, 1, N'9231183599', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (372, N'Marcelino ', N'jimenez', N'olan', N'X|SN', 1, 1, N'9171283969', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (373, N'Thomas ', N'dominguez', N'alvarez', N'X|SN', 1, 1, N'92323107.2056', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (374, N'Leonor ', N'alejandro', N'.', N'X|SN', 1, 1, N'9231174703', N'simac.aguadulce@gmail.com', N'Afectación de Campo Sintético', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (375, N'Alma María ', N'acosta', N'.', N'X|SN', 1, 1, N'9231356908', N'simac.aguadulce@gmail.com', N'Problemas de Calle y Luz', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (376, N'Rizalino ', N'meza', N'pacheco', N'X|SN', 1, 1, N'9231390963', N'simac.aguadulce@gmail.com', N'Autorización para traslado de alcantarilla ', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (377, N'Devora Alejandra ', N'morales', N'manzanero', N'Calle Flores Magón Col. Díaz Ordaz |SN', 1, 10, N'9231351760', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (380, N'Natividad  ', N'zapata', N'bautista', N'Calle  Mandarina |SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Problema con la calle ', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (381, N'Mercedes ', N'torres', N'hernandez', N'Calle Juan Escutia  Col. Emiliano Zapata|SN', 1, 19, N'9231353601', N'simac.aguadulce@gmail.com', N'Quitar un árbol y la Basura ', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (382, N'José Luis ', N'cruz', N'maldonado', N'Col. Bosques II Sección |SN', 1, 1, N'9321163390', N'simac.aguadulce@gmail.com', N'Deslave de Drenaje ', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (383, N' Beatriz Adriana ', N'valencia', N'sanchez', N'Calle Nanchital Col 4 Caminos|SN', 1, 2, N'923107 7635', N'simac.aguadulce@gmail.com', N'Problemas con un árbol y kínder', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (384, N'Miriam ', N'hernandez', N'silman', N'Calle Nanchital Col 4 Caminos|SN', 1, 2, N'9231017635', N'simac.aguadulce@gmail.com', N'Problemas con terreno', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (385, N'Edgar Adrián', N'rodriguez', N'', N'Calle Matamoros Col el suspiro|SN', 1, 18, N'9231116648', N'simac.aguadulce@gmail.com', N'Pavimentación y luz', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (386, N'Raquel ', N'hernandez', N'gonzalez', N'Ejido Diaz Ordaz |SN', 15, 54, N'9231274966', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (387, N'Rubén ', N'ramirez', N'hernandez', N'Calle Vicente Suarez Col. Benito Juárez |SN', 1, 8, N'2334946', N'simac.aguadulce@gmail.com', N'Ampliación eléctrica y poste de luz ', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (388, N'Victor ', N'sosa', N'reyes', N'Ejido el Granero|SN', 1, 1, N'9231097982', N'simac.aguadulce@gmail.com', N'Requerimiento de Pozo', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (389, N'Sebastiana ', N'melendez', N'geronimo', N'Col. El Muelle |SN', 1, 15, N'9231011089', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (390, N'Yariel Eduardo ', N'lopez', N'angulo', N'Co. 1005|SN', 1, 31, N'9211139754', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (391, N'Jesenia ', N'morales', N'mendez', N'Calle Antonio Caso Col Emiliano Zapata |SN', 1, 19, N'9231388490', N'simac.aguadulce@gmail.com', N'Árboles y cableado eléctrico', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (392, N'Elva Cristina ', N'velez', N'', N'Calle Limones Col. 1005|SN', 1, 31, N'9232384448', N'simac.aguadulce@gmail.com', N'Guarniciones y Banquetas ', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (393, N' Elvira ', N'morales', N'espinoza', N'Calle fco i madero col. km 2|SN', 1, 21, N'9231309414', N'simac.aguadulce@gmail.com', N'Apoyo a traslado para persona emferma', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (394, N'José ', N'reyes', N'sanchez', N'Col. Arenal|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (395, N'Rodrigo ', N'rodriguez', N'sanchez', N'Calle Independencia Col. Diaz Ordaz |SN', 1, 10, N'9231056648', N'simac.aguadulce@gmail.com', N'Drenaje ', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (396, N'Josefina ', N'rodriguez', N'alor', N'Calle Emiliano Zapata Col. Amado Nervo|SN', 1, 1, N'2336307', N'simac.aguadulce@gmail.com', N'Beca', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (397, N'Luisa ', N'ortiz', N'castellanos', N'Col. pico de Orizaba|SN', 1, 1, N'2289888837', N'simac.aguadulce@gmail.com', N'Problemas de Agua', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (398, N'Marco ', N'solis', N'sanchez', N'KM 2|SN', 1, 21, N'0000000000', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (399, N'Esther ', N'solis', N'sanchez', N'Km 2|SN', 1, 21, N'0000000000', N'simac.aguadulce@gmail.com', N'Personal ', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (400, N'Martha luisa', N'ortega', N'', N'Col suspiro|SN', 1, 18, N'2331616', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (401, N'Solomon ', N'lopez', N'lopez', N'Col. 1005|SN', 1, 31, N'9231215436', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (402, N'Isaac ', N'contreras', N'medina', N'Galeana |SN', 1, 1, N'2331912', N'simac.aguadulce@gmail.com', N'Calle y pavimentación y parque ', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (403, N'Dora María ', N'lara', N'garcia', N'Col. Suspiro|SN', 1, 18, N'0000000000', N'simac.aguadulce@gmail.com', N'Mobiliario para Kínder', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (404, N'Luz del Alba ', N'cruz', N'vidal', N'Ejido Poblado Hernández posada|SN', 1, 1, N'9231145385', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (405, N'Orlando Alejandro ', N'mauro', N'cruz', N'Calle. Venustiano Carranza Col. 1005|SN', 1, 31, N'0000000000', N'simac.aguadulce@gmail.com', N'Problemas Con Alcantarilla', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (406, N'Alberto ', N'brito', N'', N'Col. Solidaridad |SN', 1, 39, N'9232383327', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (407, N'José del Carmen ', N'sanchez', N'garduza', N'Calle Insurgentes #202 Col. Pingüinos|SN', 1, 25, N'2332045', N'simac.aguadulce@gmail.com', N'Entrega de Documentos', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (408, N'Roque ', N'hernandez', N'gonzalez', N'Calle Carretera la Granja |SN', 1, 1, N'9231274966', N'simac.aguadulce@gmail.com', N'Entrega de documentos', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (409, N'Javier ', N'luna', N'morales', N'Callejón Libertal col. Abulón |SN', 1, 11, N'2334571', N'simac.aguadulce@gmail.com', N'Pavimentación de Calle', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (410, N'Hiram ', N'sastre', N'mendez', N'Calle. 19 de marzo col. el Bosque 1ra sección |SN', 1, 12, N'9221128933', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (411, N'Rolando ', N'rodriguez', N'angulo', N'Calle Veracruz Col. Magisterial |SN', 1, 27, N'9231199637', N'simac.aguadulce@gmail.com', N'Problemas en la calle ', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (412, N'beatriz', N'ramos', N'mejia', N'Calle Úrsula Galván Col. KM2|SN', 1, 21, N'9231218257', N'simac.aguadulce@gmail.com', N'Pavimentación de Calle ', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (413, N'Leonardo ', N'chico', N'perez', N'Ejido Manantiales|SN', 11, 50, N'9231176752', N'simac.aguadulce@gmail.com', N'Problemas en puente', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (414, N'María Juanita ', N'lopez', N'', N'Col. El Bosque|SN', 1, 12, N'9231006667', N'simac.aguadulce@gmail.com', N'Relleno', CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (415, N'Armando ', N'rodriguez', N'reyes', N'Calle Framboyanes col. 1005|SN', 1, 31, N'9231168170', N'simac.aguadulce@gmail.com', N'Problemas con terreno', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (416, N'juana', N'valencia', N'mendoza', N'Las Palmitas|SN', 1, 1, N'9231305058', N'simac.aguadulce@gmail.com', N'Alumbrado Publico', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (417, N'Luis Antonio ', N'ruiz', N'', N'Callejón Córdoba Col. Allende |SN', 11, 6, N'9231375993', N'simac.aguadulce@gmail.com', N'Apoyo para relleno', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (418, N'María del Socorro ', N'flores', N'', N'Col. Segunda Sección #2|SN', 1, 1, N'2335473', N'simac.aguadulce@gmail.com', N'Arboles con cables', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (419, N'Bertha ', N'de la cruz', N'perez', N'Col. Bella Vista|SN', 1, 1, N'9211330845', N'simac.aguadulce@gmail.com', N'Terreno', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (420, N'José Alberto ', N'hernandez', N'gonzalez', N'Col. nueva del Rio|SN', 1, 34, N'9211286996', N'simac.aguadulce@gmail.com', N'Permiso para venta ', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (421, N'Beatriz ', N'garcia', N'velazquez', N'Col. nueva del rio|SN', 1, 34, N'9231280418', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (422, N'Soledad ', N'perez', N'esponda', N'Poblado el granero|SN', 1, 1, N'9231078772', N'simac.aguadulce@gmail.com', N'Petición para visita del presidente', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (423, N'Aida ', N'garcia', N'arena', N'Col. mil cinco Calle. Manguito|SN', 1, 31, N'9231278984', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (424, N'Rosalba ', N'alcudia', N'velazquez', N'Col. Lázaro cárdenas |SN', 1, 23, N'23 3 16 88', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (425, N'Roxana ', N'castillo', N'toledo', N'Col. 1005 Calle. Av. Reforma|SN', 1, 31, N'9232389807', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (426, N'berta', N'sosa', N'rodriguez', N'Col. nva. Del rio|SN', 1, 34, N'2330343', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (427, N'Luz maria ', N'jimenez', N'hernandez', N'Col. el muelle Calle. 10 de mayo|SN', 1, 15, N'92311690 18', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (428, N'Damiana ', N'marcial', N'rodriguez', N'Col. Benito Juárez|SN', 1, 8, N'', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (429, N'Luis ', N'monsalvo', N'garcia', N'Col. 4 caminos Calle. Nanchital|SN', 1, 2, N'9932675809', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (430, N'Misael ', N'morales', N'pascual', N'Col. Emiliano zapata|SN', 1, 2, N'7821347829', N'simac.aguadulce@gmail.com', N'drenaje', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (431, N'jorge omar', N'romero', N'suarez', N'Col. Díaz Ordaz |SN', 1, 10, N'', N'simac.aguadulce@gmail.com', N'Entrega de documentos432', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (432, N'Reyna ', N'garcia ', N'hernandez', N'Col. Díaz Ordaz|SN', 1, 10, N'9231083888', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (433, N'Fermín ', N'morales', N'hernandez', N'Col. nueva del rio |SN', 1, 34, N'9231322792', N'simac.aguadulce@gmail.com', N'Solicitud para pavimentación de calle ', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (434, N'Maria urania ', N'sanchez', N'sanchez', N'Col. Emiliano zapata |SN', 1, 19, N'92332731', N'simac.aguadulce@gmail.com', N'Solicitud de apoyo para kínder ', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (435, N'Jorge ', N'geronimo', N'rodriguez', N'Col. 1005|SN', 1, 31, N'9231229463', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (436, N'guadalupe del Carmen ', N'gomez', N'', N'Col. las piedras |SN', 1, 1, N'9981496069', N'simac.aguadulce@gmail.com', N'personal', CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (440, N'Carmela ', N'ramon', N'navarrete', N'Veracruz #1|SN', 1, 1, N'9211927372', N'simac.aguadulce@gmail.com', N'Apoyo con la retro para hacer criadero', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (441, N'Josefina ', N'gonzalez', N'mendez', N'Emiliano zapata|SN', 1, 19, N'9231388498', N'simac.aguadulce@gmail.com', N'Apoyo para la basura', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (442, N'Gerardo ', N'de la cruz', N'alvarez', N'Col. Cuauhtémoc|SN', 1, 9, N'9231387475', N'simac.aguadulce@gmail.com', N'Escuela cermar', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (443, N'Georgina ', N'jimenez', N'ocaña', N'Naranjal|SN', 1, 1, N'9232313867', N'simac.aguadulce@gmail.com', N'Predial', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (444, N'Martínez ', N'ramirez', N'roman', N'Allende|SN', 1, 6, N'9232315859', N'simac.aguadulce@gmail.com', N'x', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (445, N'Magdalena ', N'sanchez', N'hernandez', N'Alborada|SN', 1, 5, N'9231124359', N'simac.aguadulce@gmail.com', N'Visita a la colonia', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (446, N'Jesús ', N'vazquez', N'', N'Col. El muelle|SN', 1, 15, N'0000000000', N'simac.aguadulce@gmail.com', N'Tarjeta de banco', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (447, N'Alfredo ', N'gomez', N'sanchez', N'Carmen Serdán |SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Juridico', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (448, N'carlos', N'ramirez', N'', N'Los pinos|SN', 1, 26, N'0000000000', N'simac.aguadulce@gmail.com', N'x', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (449, N'Misael ', N'morales', N'pascual', N'Emiliano zapata|SN', 1, 19, N'0000000000', N'simac.aguadulce@gmail.com', N'drenaje', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
GO
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (450, N'Madisa: ing. Verónica  ', N'martines', N'uribe', N'Madisa jefe del medio ambiente|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo de impuesto en Agua Dulce', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (451, N'Héctor ', N'ortiz', N'dominguez', N'Col. Allende |SN', 1, 6, N'9232352250', N'simac.aguadulce@gmail.com', N'Deportes', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (452, N'Gloria ', N'rabadan', N'martinez', N'Blasillo|SN', 1, 1, N'7471440347', N'simac.aguadulce@gmail.com', N'Apoyo para 3 niños', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (453, N'Sonia ', N'de los santos', N'ramos', N'Miguel Alemán Aguacate|SN', 1, 1, N'9231254330', N'simac.aguadulce@gmail.com', N'Apoyo encomico caid Dif (bomba de agua)', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (454, N'Alfredo ', N'de la cruz', N'', N'Carranza #86|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo a salud', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (455, N'Cesar ', N'lopez', N'marin', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo a rehabilitación barda de panteón  ', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (456, N'Julio Cesar', N'cesar', N'diaz', N'Col. El Muelle|SN', 1, 15, N'0000000000', N'simac.aguadulce@gmail.com', N'trabajo', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (457, N'Gerardo ', N'manzon', N'armenta', N'Emiliano Zapata|SN', 1, 19, N'9231192668', N'simac.aguadulce@gmail.com', N'Apoyo a salud', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (458, N'Carmen Guadalupe ', N'torres', N'', N'Emiliano Zapata|SN', 1, 19, N'9232380317', N'simac.aguadulce@gmail.com', N'Asesoría legal ', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (459, N'Maria teresa ', N'robles', N'juarez', N'Naranjal|SN', 1, 32, N'9381244437', N'simac.aguadulce@gmail.com', N'Apoyo', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (460, N'Magdalena ', N'cruz', N'morales', N'Cuauhtémoc|SN', 1, 9, N'9231007127', N'simac.aguadulce@gmail.com', N'Apoyo con una silla de ruedas', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (461, N'Guadalupe ', N'gonzalez', N'', N'Col. El Muelle|SN', 1, 15, N'0000000000', N'simac.aguadulce@gmail.com', N'Obra de drenaje', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (462, N'Isidro ', N'flores', N'', N'X|SN', 1, 1, N'2881302980', N'simac.aguadulce@gmail.com', N'Feria juegos', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (463, N'German ', N'perez', N'absalon', N'x|SN', 1, 1, N'9231074186', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (464, N'Rene ', N'colorado', N'cruz', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'drenaje', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (466, N'Vicente ', N'puc', N'', N'X|SN', 1, 1, N'9231379160', N'simac.aguadulce@gmail.com', N'15 de septiembre', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (467, N'Alan ', N'hugo', N'', N'X|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Deslave del rio 18 de marzo', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (470, N'José Alberto  ', N'hernandez', N'', N'Col. Benito Juárez |SN', 1, 8, N'9211286996', N'simac.aguadulce@gmail.com', N'Permiso del Sobre Ruedas ', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (471, N'Selina ', N'bravo', N'soto', N'Magisterial |SN', 1, 27, N'9231298967', N'simac.aguadulce@gmail.com', N'Apoyo a Casa', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (472, N'José Luis ', N'garcia', N'marin', N'Niños Héroes, A.V Ferrocarril|SN', 1, 1, N'9231319173', N'simac.aguadulce@gmail.com', N'Personal', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (473, N'Leticia del Carmen ', N'chiñas', N'gallegos', N'Col. 1005|SN', 1, 31, N'9231252746', N'simac.aguadulce@gmail.com', N'Apoyo a parque sintético', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (474, N'Eulalio ', N'morales', N'lara', N'Km 2, Col. Cuartel|SN', 1, 1, N'9231089825', N'simac.aguadulce@gmail.com', N'Trabajador de PC', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (475, N'Juan ', N'santiago', N'mijangos', N'Col. Nueva del Rio|SN', 1, 34, N'0000000000', N'simac.aguadulce@gmail.com', N'Viajes de Tierra', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (476, N'Isidro ', N'lopez', N'', N'2da Sección, Col. El Bosque|SN', 1, 13, N'2331444', N'simac.aguadulce@gmail.com', N'Nueva Directiva Del Comité ', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (477, N'Herlinda ', N'cruz', N'zepeda', N'Col.4 Caminos|SN', 1, 2, N'0000000000', N'simac.aguadulce@gmail.com', N'Corte de Arbol', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (478, N'Landy Guillermo ', N'pech', N'america', N'Col. El Muelle|SN', 1, 15, N'0000000000', N'simac.aguadulce@gmail.com', N'Solicitud de Apoyo', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (479, N'Concepción ', N'perez', N'cruz', N'Centro|SN', 1, 4, N'9231126882', N'simac.aguadulce@gmail.com', N'Petición de Iglesia', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (480, N'Padres de Familia ', N'', N'', N'Cobaev|SN', 1, 1, N'9221163653', N'simac.aguadulce@gmail.com', N'Corte de Árbol', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (481, N'Ana Maria ', N'garduño', N'', N'Col. Emiliano Zapata |SN', 1, 19, N'9231163132', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (482, N'Delfino ', N'ortiz', N'', N'Co. Cuauhtémoc |SN', 1, 1, N'9381415337', N'simac.aguadulce@gmail.com', N'Petición de Mercado ', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (483, N'José  (Lic. Torruco)', N'reyes', N'mendez', N'Col. Emiliano Zapata |SN', 1, 19, N'9231198916', N'simac.aguadulce@gmail.com', N'Drenaje y Lámparas ', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (484, N'Clemente ', N'canario', N'', N'El Papayal|SN', 1, 17, N'0000000000', N'simac.aguadulce@gmail.com', N'Pavimentación ', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (485, N'Catalina ', N'garcía', N'', N'Col. 1005|SN', 1, 31, N'2334171', N'simac.aguadulce@gmail.com', N'Pavimentación ', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (486, N'Maria mercedez', N'carrillo', N'', N'Tonala|SN', 17, 56, N'9231313890', N'simac.aguadulce@gmail.com', N'Apoyo a Predial ', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (487, N'Picardo ', N'alonso', N'antonio', N'Centro|SN', 1, 4, N'9231308698', N'simac.aguadulce@gmail.com', N'Drenaje', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (488, N'Humberto ', N'rosado', N'', N'Col. Juárez|SN', 1, 8, N'2333985', N'simac.aguadulce@gmail.com', N'Alumbrado', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (489, N'Aida ', N'arenas', N'', N'Col. 1005|SN', 1, 31, N'9231278789', N'simac.aguadulce@gmail.com', N'Apoyo con Gastos Funerarios ', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (490, N'Lucia ', N'celaya', N'', N'Col. Bellavista|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Alumbrado', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (491, N'Luis Humberto', N'méndez', N'', N'Col. El Muelle |SN', 1, 15, N'9231117812', N'simac.aguadulce@gmail.com', N'Calle', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (492, N'Maribel  ', N'aguirre', N'', N'Col. Juárez|SN', 1, 8, N'9231078781', N'simac.aguadulce@gmail.com', N'Alumbrado', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (493, N'Jhoana ', N'sanchez', N'', N'x|SN', 1, 1, N'9232380165', N'simac.aguadulce@gmail.com', N'Alumbrado, Pintura y Pintura ', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (494, N'Gloria ', N'rabanales', N'', N'Calle Blasillo|SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Petición de escuela ', CAST(N'2018-09-03T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (495, N'Candelaria ', N'vazquez', N'almeida', N'Calles. Mandarinas|SN', 1, 1, N'9983012172', N'simac.aguadulce@gmail.com', N'Terreno', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (496, N'Armando ', N'garcia', N'rueda', N'Col. 20 de Noviembre |SN', 1, 1, N'0000000000', N'simac.aguadulce@gmail.com', N'Ayuda de Medicinas', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (497, N'Victor ', N'almazan', N'carrillo', N'Col. 18 de Marzo|SN', 1, 58, N'9231161455', N'simac.aguadulce@gmail.com', N'Presentación ', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (498, N'Ernesto ', N'carrillo', N'perez', N'Col. Benito Juárez |SN', 1, 8, N'9231158922', N'simac.aguadulce@gmail.com', N'Alumbrado', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (499, N'Juan Luis ', N'triano', N'ricardez', N'Col. Cuauhtémoc |SN', 1, 1, N'9231354778', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (500, N'Gualberto ', N'valenzuela', N'', N'Alborada |SN', 1, 5, N'9981805117', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (501, N'Michael ', N'dorantes', N'', N'Col. El Bosque|SN', 1, 1, N'9381576557', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (502, N'Gloria ', N'javier', N'', N'Col. Allende |SN', 1, 6, N'9231192740', N'simac.aguadulce@gmail.com', N'Alcantarillado ', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (503, N'Emiliano ', N'gonzalez', N'', N'Col. 1005|SN', 1, 31, N'9231084344', N'simac.aguadulce@gmail.com', N'Electrificación ', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (504, N'Andrés ', N'perez', N'valenzuela', N'Col. Cuauhtémoc |SN', 1, 9, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo a Enfermo', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (505, N'Guadalupe ', N'acopa', N'de la cruz', N'X|SN', 1, 1, N'9231144492', N'simac.aguadulce@gmail.com', N'Tramite de Animales ', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (506, N'Iris ', N'rojas', N'cuevas', N'X|SN', 1, 1, N'9231100122', N'simac.aguadulce@gmail.com', N'Juez Calificador', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (507, N'José ', N'ríos', N'', N'X|SN', 1, 1, N'9231252147', N'simac.aguadulce@gmail.com', N'CAEV', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (508, N'Beatriz ', N'mejía', N'', N'X|SN', 1, 1, N'9231208255', N'simac.aguadulce@gmail.com', N'APOYO ', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (509, N'Beatriz Adriana ', N'sánchez', N'', N'X|SN', 1, 1, N'9231017635', N'simac.aguadulce@gmail.com', N'Arbol', CAST(N'2018-09-24T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (510, N'Aida ', N'medina', N'alvarado', N'C. Mariano Escobedo Col. Emiliano Zapata |SN', 1, 19, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (511, N'Isidro ', N'lopez', N'jimenez', N'Bosque 2da sección |SN', 1, 13, N'2332540', N'simac.aguadulce@gmail.com', N'Calles ', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (512, N'Roberto', N'ramirez', N'gomez', N'Ejido el Granero|SN', 1, 1, N'9231091682', N'simac.aguadulce@gmail.com', N'Oficio de Apoyo', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (513, N'Rafael ', N'corzo', N'', N'X|SN', 1, 1, N'9231278499', N'simac.aguadulce@gmail.com', N'Solicitud para alumbrado de iglesia ', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (514, N'Marlene ', N'torres', N'adriano', N'Ejido Miguel Alemán |SN', 1, 1, N'9231179683', N'simac.aguadulce@gmail.com', N'Bomba de Agua Kinder ', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (515, N'William', N'gomez', N'', N'Col. 1005|SN', 1, 31, N'9231053298', N'simac.aguadulce@gmail.com', N'Deportivo', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (516, N'Roció ', N'izquierdo', N'castillo', N'Km2 por el Cuartel|SN', 1, 21, N'9231375210', N'simac.aguadulce@gmail.com', N'Drenaje y luz ', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (517, N'Celia Lizbeth ', N'lopez', N'garcia', N'Km2|SN', 1, 21, N'9231298699', N'simac.aguadulce@gmail.com', N'Alumbrado y limpieza  ', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (518, N'Sonia de los Santos ', N'de los santos', N'', N'Prim. González Boca Negra Miguel Alemán |SN', 1, 1, N'9231254330', N'simac.aguadulce@gmail.com', N'Apoyo a Bomba de Agua ', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (519, N'Director. Carlos Sandy ', N'hernandez', N'rosal', N'Amado Nervo |SN', 1, 1, N'9231107719', N'simac.aguadulce@gmail.com', N'Solicitud de obra ', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (520, N'José Carlos ', N'mendez', N'jimenez', N'Col. Las Piedras|SN', 1, 1, N'9231271162', N'simac.aguadulce@gmail.com', N'Solicitud de obra ', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (521, N'Alfredo ', N'lopez', N'lopez', N'Col. Centro|SN', 1, 1, N'9231013182', N'simac.aguadulce@gmail.com', N'Trabajo', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (522, N'Lic. Wiliado ', N'hernandez', N'perez', N'Col. Centro|SN', 1, 1, N'9231123783', N'simac.aguadulce@gmail.com', N'Drenaje Alumbrado ', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (523, N'Carmen ', N'valenzuela', N'', N'Col. Centro|SN', 1, 1, N'2330980', N'simac.aguadulce@gmail.com', N'Asunto Personal', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (524, N'Joselyn ', N'amezquita', N'', N'Col. Suspiro|SN', 1, 18, N'9231309975', N'simac.aguadulce@gmail.com', N'Caso Laboral', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (525, N'Eusebio ', N'dominguez', N'gonzalez', N'Col. Allende|SN', 1, 6, N'9231052111', N'simac.aguadulce@gmail.com', N'Pago de Catastro', CAST(N'2018-10-08T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (526, N'Gabriela ', N'arellano', N'', N'Los pinos|SN', 1, 26, N'0000000000', N'simac.aguadulce@gmail.com', N'Apoyo a enfermo ', CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (528, N'JOSE NICILAS', N'ROCHA', N'CORTES', N'PALMAS|SN', 1, 16, N'0000000000', N'ATENCIONCIUDADANA.ADVGOB@HOTMAIL.COM', N'AMPLIACION DE ENERGIA ELECTRICA', CAST(N'2018-10-29T11:40:42.510' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (529, N'MAXIMO', N'NIETO', N'OCAÑA', N'FRANCISCOIMADERO|74', 1, 22, N'0000000000', N'', N'SOLICITUD DE RETRO PARA PESCADO O CAMARON', CAST(N'2018-10-29T11:47:13.083' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (530, N'SANDRA', N'DOMINGUEZ', N'DE LA CRUZ', N'BENUSTIANO CARRANZA|29', 1, 31, N'9231305612', N'', N'APOYO PARA REGULARISACION DE TERRENO', CAST(N'2018-10-29T11:51:57.040' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (531, N'JULIO CESAR', N'MUÑIZ', N'SOSA', N'primera de mayo|68', 1, 6, N'9231183599', N'', N'platica social de problemas de la ciudad', CAST(N'2018-10-29T12:00:26.367' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (532, N'ALLAN HUGO', N'ORTUÑO', N'TORRES', N'eduardo soto|210', 1, 58, N'9231227602', N'', N'Respuesta en apoyo de escombro o llantas en la parte del rio', CAST(N'2018-10-29T12:09:41.193' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (533, N'OFELIO', N'RODRIGUEZ', N'GONZALES', N'fco marquez|31', 1, 19, N'9231271363', N'', N'asunto personal referente a trabajo.', CAST(N'2018-10-29T12:11:42.883' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (534, N'JOSE MAXIMILIANO', N'MOGUEL', N'LOYO', N'ledos|63', 1, 19, N'2334003', N'', N'peticion de alumbrado', CAST(N'2018-10-29T12:35:06.437' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (535, N'CELSO', N'ESTRADA', N'AMAYA', N'durango|', 1, 58, N'9212027721', N'', N'platicas de obras', CAST(N'2018-10-29T12:51:08.247' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (536, N'BENERANDO', N'ROBLEDO', N'MORALES', N'nanchito|sn', 1, 1, N'0000000000', N'', N'solicitud de trabajo', CAST(N'2018-10-29T13:17:03.190' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (537, N'EDGAR DEMETRIO', N'GONSALEZ', N'LOPEZ', N'francisco marquez|89', 1, 27, N'9231356356', N'', N'reavilitacion de calle', CAST(N'2018-10-29T13:19:45.767' AS DateTime))
INSERT [audiencia].[AudienciaTemp] ([idAudiencia], [nombre], [apellidoPaterno], [apellidoMaterno], [direccion], [idLocalidad], [idColonia], [telefono], [correoElectronico], [peticion], [fechaHora]) VALUES (539, N'FRANCISCO', N'MARTINEZ', N'VILLASECA', N'zaragoza|12', 1, 58, N'9211983848', N'pacomale@gmail.com', N'prueba de audiencia', CAST(N'2018-11-05T16:16:10.673' AS DateTime))
SET IDENTITY_INSERT [audiencia].[AudienciaTemp] OFF
SET IDENTITY_INSERT [dbo].[Ciudadano] ON 

INSERT [dbo].[Ciudadano] ([Id], [Nombre], [ApellidoP], [ApellidoM], [NumeroInt], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [CorreoEAlt], [Telefono], [TelefonoAlt], [Asociacion], [Edad], [Calle1], [Calle2], [fechaNac]) VALUES (1, N'SANDRA', N'DOMINGUEZ', N'DE LA CRUZ', NULL, N'29', N'BENUSTIANO CARRANZA', 31, 1, N'', NULL, N'', N'9231305612', NULL, NULL, NULL, NULL, CAST(N'2018-10-29T00:00:00' AS SmallDateTime))
INSERT [dbo].[Ciudadano] ([Id], [Nombre], [ApellidoP], [ApellidoM], [NumeroInt], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [CorreoEAlt], [Telefono], [TelefonoAlt], [Asociacion], [Edad], [Calle1], [Calle2], [fechaNac]) VALUES (2, N'JOSE NICILAS', N'ROCHA', N'CORTES', NULL, N'SN', N'PALMAS', 16, 0, N'ATENCIONCIUDADANA.ADVGOB@HOTMAIL.COM', NULL, N'', N'0000000000', NULL, NULL, NULL, NULL, CAST(N'2018-10-29T00:00:00' AS SmallDateTime))
INSERT [dbo].[Ciudadano] ([Id], [Nombre], [ApellidoP], [ApellidoM], [NumeroInt], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [CorreoEAlt], [Telefono], [TelefonoAlt], [Asociacion], [Edad], [Calle1], [Calle2], [fechaNac]) VALUES (3, N'MAXIMO', N'NIETO', N'OCAÑA', NULL, N'74', N'FRANCISCOIMADERO', 22, 0, N'', NULL, N'', N'9232330531', NULL, NULL, NULL, NULL, CAST(N'2018-10-29T00:00:00' AS SmallDateTime))
INSERT [dbo].[Ciudadano] ([Id], [Nombre], [ApellidoP], [ApellidoM], [NumeroInt], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [CorreoEAlt], [Telefono], [TelefonoAlt], [Asociacion], [Edad], [Calle1], [Calle2], [fechaNac]) VALUES (4, N'JOSE MAXIMILIANO', N'MOGUEL', N'LOYO', NULL, N'63', N'LEDOS', 19, 0, N'', NULL, N'', N'9232334003', NULL, NULL, NULL, NULL, CAST(N'2018-10-29T00:00:00' AS SmallDateTime))
INSERT [dbo].[Ciudadano] ([Id], [Nombre], [ApellidoP], [ApellidoM], [NumeroInt], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [CorreoEAlt], [Telefono], [TelefonoAlt], [Asociacion], [Edad], [Calle1], [Calle2], [fechaNac]) VALUES (5, N'ALLAN HUGO', N'ORTUÑO', N'TORRES', NULL, N'210', N'EDUARDO SOTO', 58, 0, N'', NULL, N'', N'9231227602', NULL, NULL, NULL, NULL, CAST(N'2018-10-29T00:00:00' AS SmallDateTime))
INSERT [dbo].[Ciudadano] ([Id], [Nombre], [ApellidoP], [ApellidoM], [NumeroInt], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [CorreoEAlt], [Telefono], [TelefonoAlt], [Asociacion], [Edad], [Calle1], [Calle2], [fechaNac]) VALUES (6, N'ALLAN HUGO', N'ORTUÑO', N'TORRES', NULL, N'210', N'EDUARDO SOTO', 58, 0, N'', NULL, N'', N'9231227602', NULL, NULL, NULL, NULL, CAST(N'2018-10-29T00:00:00' AS SmallDateTime))
INSERT [dbo].[Ciudadano] ([Id], [Nombre], [ApellidoP], [ApellidoM], [NumeroInt], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [CorreoEAlt], [Telefono], [TelefonoAlt], [Asociacion], [Edad], [Calle1], [Calle2], [fechaNac]) VALUES (7, N'EDGAR DEMETRIO', N'GONSALEZ', N'LOPEZ', NULL, N'89', N'FRANCISCO MARQUEZ', 27, 0, N'', NULL, N'', N'9231356356', NULL, NULL, NULL, NULL, CAST(N'2018-10-29T00:00:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[Ciudadano] OFF
SET IDENTITY_INSERT [dbo].[Colonia] ON 

INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (1, N'Sin Colonia', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (2, N'4 Caminos', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (3, N'Agraria', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (4, N'Agua Dulce Centro', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (5, N'Alborada', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (6, N'Allende', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (7, N'Bellavista', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (8, N'Benito Juárez', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (9, N'Cuauhtémoc', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (10, N'Diaz Ordaz', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (11, N'El Abulon', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (12, N'El Bosque Primera Sección', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (13, N'El Bosque Segunda Sección', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (14, N'El Chorrito', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (15, N'El Muelle Veracruz', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (16, N'El Palmar', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (17, N'El Papayal', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (18, N'El Suspiro', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (19, N'Emiliano Zapata', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (20, N'Gilberto Flores Muñoz', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (21, N'Km. 2', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (22, N'Las Piedras', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (23, N'Lázaro Cárdenas', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (24, N'Lealtad Gregorio Méndez', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (25, N'Los Pingüinos', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (26, N'Los Pinos', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (27, N'Magisterial', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (28, N'México', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (29, N'Miguel Alemán Valdés (Colonia Agrícola Ganadera)', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (30, N'Miguel Hidalgo', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (31, N'Mil 5', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (32, N'Naranjal', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (33, N'Niños Héroes', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (34, N'Nueva Del Rio', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (35, N'Obrera', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (36, N'PEMEX', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (37, N'Puebla', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (38, N'Quince de Agosto', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (39, N'Solidaridad', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (40, N'Uno y Medio', 1)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (41, N'Campo el Panal (El Palmar)', 2)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (42, N'El Burro', 3)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (43, N'El Cedral', 4)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (44, N'El Corosal', 5)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (45, N'El Faisán', 6)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (46, N'El Porvenir', 7)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (47, N'El Tortuguero', 8)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (48, N'La Gloria', 9)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (49, N'Las Palmitas', 10)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (50, N'Los Manantiales', 11)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (51, N'Los Soldados', 12)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (52, N'Punta Gorda', 13)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (53, N'El Encanto (Ejido el Encanto Pesquero)
', 14)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (54, N'Gustavo Díaz Ordaz
', 15)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (55, N'Ingeniero Mario Hernández Posada
', 16)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (56, N'Tonalá
', 17)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (57, N'La Arena
', 18)
INSERT [dbo].[Colonia] ([Id], [Colonia], [IdLocalidad]) VALUES (58, N'18 de Marzo', 1)
SET IDENTITY_INSERT [dbo].[Colonia] OFF
SET IDENTITY_INSERT [dbo].[Dependencia] ON 

INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 1, N'CONTRALORIA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 2, N'PROTECCION CIVIL', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 3, N'CULTURA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 4, N'SEGURIDAD', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 5, N'OBRAS PUBLICAS', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 6, N'TESORERIA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 7, N'SALUD', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 8, N'RECLUTAMIENTO', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 9, N'ASUNTOS RELIGIOSOS', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 10, N'PARTICIPACION CIUDADANA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 11, N'SERVICIOS PUBLICO MUNICIPALES', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 12, N'REGIDURIA 1ra', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 13, N'TURISMO', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 14, N'PRESIDENCIA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 15, N'GOBERNACION', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 16, N'ECOLOGIA Y MEDIO AMBIENTE', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 17, N'REGIDURIA 5ta', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 18, N'SALUID', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 19, N'INGRESOS', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 20, N'UNIDAD DE TRANSPARENCIA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 21, N'COMUDE', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 22, N'INFORMATICA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 23, N'RELACIONES LABORALES', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 24, N'REGISTRO CIVIL', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 25, N'FOMENTO AGROPECUARIO', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 26, N'SERVICIOS PUBLICOS', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 27, N'EQUIDAD Y GENERO', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 28, N'CATASTRO', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 29, N'REGIDURIA 4ta', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 30, N'SECRETARIA DEL AYUNTAMIENTO', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 31, N'SEDESOL', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 32, N'SINDICATURA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 33, N'BIBLIOTECAS', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 34, N'REGIDURIA 3ra', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 35, N'ALUMBRADO PUBLICO', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 36, N'LIMPIA PUBLICA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 37, N'COMUNICACION SOCIAL', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 38, N'EVENTOS ESPECIALES', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 39, N'PATRIMONIO', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 40, N'REGIDOR 2do', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 41, N'JUVENTUD', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 42, N'JURIDICO', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 43, N'PARQUES Y JARDINES', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 44, N'IVEA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 45, N'REGIDURIA 2da', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 46, N'DIVERSIDAD SEXUAL', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 47, N'RASTRO MUNICIPAL', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 48, N'EDUCACION', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 49, N'DIF', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 50, N'OFICINA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (1, 51, N'CLINICA DIF', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 52, N'CLINICA', N'.', N'.', N'.', N'.', 1)
INSERT [dbo].[Dependencia] ([esOP], [Id], [Dependencia], [Descripcion], [Ubicacion], [Telefono], [CorreoE], [idTiempo]) VALUES (0, 53, N'DESARROLLO URBANO', N'.', N'.', N'.', N'.', 1)
SET IDENTITY_INSERT [dbo].[Dependencia] OFF
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([ID], [Name], [Position], [Office], [Age], [Salary]) VALUES (1, N'Gerardo', N'Manager', N'210', 21, N'15000')
INSERT [dbo].[Employees] ([ID], [Name], [Position], [Office], [Age], [Salary]) VALUES (2, N'Andres', N'Manager', N'211', 21, N'15000')
INSERT [dbo].[Employees] ([ID], [Name], [Position], [Office], [Age], [Salary]) VALUES (3, N'Alexis', N'Manager', N'212', 21, N'15000')
INSERT [dbo].[Employees] ([ID], [Name], [Position], [Office], [Age], [Salary]) VALUES (4, N'Enrique', N'Manager', N'213', 21, N'15000')
INSERT [dbo].[Employees] ([ID], [Name], [Position], [Office], [Age], [Salary]) VALUES (5, N'Luis', N'Manager', N'214', 21, N'15000')
INSERT [dbo].[Employees] ([ID], [Name], [Position], [Office], [Age], [Salary]) VALUES (6, N'Jose', N'Manager', N'215', 21, N'15000')
INSERT [dbo].[Employees] ([ID], [Name], [Position], [Office], [Age], [Salary]) VALUES (7, N'Carlos', N'Manager', N'216', 21, N'15000')
INSERT [dbo].[Employees] ([ID], [Name], [Position], [Office], [Age], [Salary]) VALUES (8, N'Veronica', N'Manager', N'217', 21, N'15000')
SET IDENTITY_INSERT [dbo].[Employees] OFF
INSERT [dbo].[Estado] ([Id], [Estado], [Descripcion], [EstadoCiudadano], [IdEdoCiudadano]) VALUES (1, N'Entrante', N'En espera de ser atendido', N'Pendientes', 1)
INSERT [dbo].[Estado] ([Id], [Estado], [Descripcion], [EstadoCiudadano], [IdEdoCiudadano]) VALUES (2, N'En Proceso', N'En proceso', N'Pendientes', 1)
INSERT [dbo].[Estado] ([Id], [Estado], [Descripcion], [EstadoCiudadano], [IdEdoCiudadano]) VALUES (3, N'Realizado', N'Por confirmar Realización', N'Realizados', 2)
INSERT [dbo].[Estado] ([Id], [Estado], [Descripcion], [EstadoCiudadano], [IdEdoCiudadano]) VALUES (4, N'En Gestion', N'En Proceso de Gestión', N'Pendientes', 1)
INSERT [dbo].[Estado] ([Id], [Estado], [Descripcion], [EstadoCiudadano], [IdEdoCiudadano]) VALUES (5, N'Confirmado', N'Caso de Exito', N'Realizados', 2)
INSERT [dbo].[Estado] ([Id], [Estado], [Descripcion], [EstadoCiudadano], [IdEdoCiudadano]) VALUES (6, N'Sin Recursos', N'Falta de recursos materiales', N'Pendientes', 1)
INSERT [dbo].[Estado] ([Id], [Estado], [Descripcion], [EstadoCiudadano], [IdEdoCiudadano]) VALUES (7, N'Correccion', N'Corrección de datos', N'Pendientes', 1)
SET IDENTITY_INSERT [dbo].[FormaContacto] ON 

INSERT [dbo].[FormaContacto] ([idformacontacto], [formadecontacto]) VALUES (1, N'No identificado')
INSERT [dbo].[FormaContacto] ([idformacontacto], [formadecontacto]) VALUES (2, N'Telefonico')
INSERT [dbo].[FormaContacto] ([idformacontacto], [formadecontacto]) VALUES (3, N'Internet')
INSERT [dbo].[FormaContacto] ([idformacontacto], [formadecontacto]) VALUES (4, N'Facebook')
INSERT [dbo].[FormaContacto] ([idformacontacto], [formadecontacto]) VALUES (5, N'Twiter')
INSERT [dbo].[FormaContacto] ([idformacontacto], [formadecontacto]) VALUES (6, N'Movil')
INSERT [dbo].[FormaContacto] ([idformacontacto], [formadecontacto]) VALUES (7, N'Personal')
SET IDENTITY_INSERT [dbo].[FormaContacto] OFF
SET IDENTITY_INSERT [dbo].[Localidad] ON 

INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (1, N'Agua Dulce')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (2, N'Campo el Panal (El Palmar)')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (3, N'El Burro')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (4, N'El Cedral')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (5, N'El Corosal')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (14, N'El Encanto (Ejido el Encanto Pesquero)
')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (6, N'El Faisán')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (7, N'El Porvenir')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (8, N'El Tortuguero')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (15, N'Gustavo Díaz Ordaz
')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (16, N'Ingeniero Mario Hernández Posada
')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (18, N'La Arena
')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (9, N'La Gloria')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (10, N'Las Palmitas')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (11, N'Los Manantiales')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (12, N'Los Soldados')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (13, N'Punta Gorda')
INSERT [dbo].[Localidad] ([Id], [Localidad]) VALUES (17, N'Tonalá
')
SET IDENTITY_INSERT [dbo].[Localidad] OFF
SET IDENTITY_INSERT [dbo].[MovilAlertas] ON 

INSERT [dbo].[MovilAlertas] ([id_alerta], [titulo], [descripcion], [fecha], [ubicacion], [alertaimg], [longitud], [latitud], [fk_id_categoria], [fk_id_ciudadano]) VALUES (2008, N'Limpia pública municipal', N'Limpia pública municipal informa que de manera adicional al programa de rutas de recolección diarias se incorporan las siguientes colonias para el día de mañana Jueves 29 de Noviembre. #JuntosHaciendoHistoria', N'28-nov.-2018', N'18 de Marzo 41, Diaz Ordaz, 96690 Agua Dulce, Ver., México', N'imagen/android.graphics.Bitmap@2eb78cdK28KFO5ZPW9DPFHSMEAE.jpg', N'-94.143896587193', N'18.142745695413325', 1, 2096)
INSERT [dbo].[MovilAlertas] ([id_alerta], [titulo], [descripcion], [fecha], [ubicacion], [alertaimg], [longitud], [latitud], [fk_id_categoria], [fk_id_ciudadano]) VALUES (2009, N'Cierre de vialidad', N'Se cerrará la vialidad los días 29 y 30 de noviembre ', N'28-nov.-2018', N'Francisco I Madero 403, Diaz Ordaz, 96660 Agua Dulce, Ver., México', N'imagen/android.graphics.Bitmap@45e6ac8NJLFC24QALYMFDSTFXWA.jpg', N'-94.14301682263613', N'18.140324580763902', 1, 2096)
INSERT [dbo].[MovilAlertas] ([id_alerta], [titulo], [descripcion], [fecha], [ubicacion], [alertaimg], [longitud], [latitud], [fk_id_categoria], [fk_id_ciudadano]) VALUES (2010, N'1ra Feria de salud intermunicipal 2018', N'El H. Ayuntamiento Constitucional que preside el Alcalde Sergio Guzmán Ricárdez en coordinación con la Dirección de Salud Municipal y la Jurisdicción Sanitaria N°XI invita a la ciudadanía a asistir a la Primera Feria de la Salud Intermunicipal 2018

#JuntosHaciendoHistoria', N'28-nov.-2018', N'Francisco I Madero 217, Diaz Ordaz, 96690 Agua Dulce, Ver., México', N'imagen/android.graphics.Bitmap@382e8dcOFI34VMLH3DW8TV66BPV.jpg', N'-94.1469657048583', N'18.137812945554966', 1, 2096)
INSERT [dbo].[MovilAlertas] ([id_alerta], [titulo], [descripcion], [fecha], [ubicacion], [alertaimg], [longitud], [latitud], [fk_id_categoria], [fk_id_ciudadano]) VALUES (2011, N'informe meteorológico 03 de diciembre 2018', N'*Informe Meteorológico 03 de diciembre de 2018*

*Resumen*: El evento de Surada con rachas de 35 a 50 km/h aún puede persistirá hasta este mediodía-tarde especialmente en las regiones de Jalacingo-Atzalan, Orizaba, los Tuxtlas y Jesús Carranza-Coatzacoalcos, efecto que a su vez propiciará aún ambiente caluroso; sin embargo, durante esta tarde-noche y transcurso de mañana martes aumentarán las condiciones para tormentas, lluvias fuertes, asimismo el viento se fijará hoy al Norte alcanzando rachas máximas de 70 a 85 km/h entre el martes y miércoles, iniciando un descenso de la temperatura.

*Región Sur* (Cuencas del Papaloapan, Coatzacoalcos y Tonalá, incluyendo Los Tuxtlas): Despejado a medio nublado por la mañana, aumentando los nublados y la probabilidad de tormentas y lluvias por la noche. Acumulados estimados en 24 horas de 10 a 30 mm y máximos de 70 a 150 mm. Viento del Sur y Sureste de 20 a 30 km/h con rachas de 40 a 50 km/h, fijándose al Norte por la noche e incrementándose mañana. Ambiente caluroso. TMáx/TMín 32-35/22-24°C (Menores en la región de los Tuxtlas).

*Oleaje cerca de la costa*
0.5 a 1.5 metros en las proximidades del litoral, incrementándose mañana.', N'03-dic.-2018', N'Ignacio Zaragoza 20, Diaz Ordaz, 96620 Agua Dulce, Ver., México', N'imagen/android.graphics.Bitmap@3890f703ENCIT79RI74RJQV5PBE.jpg', N'-94.14657343178988', N'18.142324814486923', 1, 2096)
INSERT [dbo].[MovilAlertas] ([id_alerta], [titulo], [descripcion], [fecha], [ubicacion], [alertaimg], [longitud], [latitud], [fk_id_categoria], [fk_id_ciudadano]) VALUES (2012, N'*Informe Meteorológico 04 de diciembre de 201', N'*Resumen*: En las próximas 48 horas se tendrán los efectos del Frente frío No. 14 y su masa de aire polar asociada, dominando condiciones para nieblas, lloviznas, lluvias y tormentas, las cuales serán más significativas en las regiones norte y sur. En la costa el viento del Norte puede alcanzar rachas máximas de 70 a 85 km/h, disminuyendo la temperatura. Consulte *Alerta Gris*

*Región Sur* (Cuencas del Papaloapan, Coatzacoalcos y Tonalá, incluyendo Los Tuxtlas): Nublado, probabilidad de tormentas y lluvias. Acumulados estimados en 24 horas de 10 a 30 mm y máximos de 70 a 150 mm. Viento del Norte de 40 a 50 km/h y rachas de 60 a 75 km/h en la costa. Descendiendo la temperatura. TMáx/TMín 26-29/22-24°C (Menores en la región de los Tuxtlas).

*Oleaje cerca de la costa*
2.0 a 3.0 metros en las proximidades del litoral.

Fuente oficial: Protección Civil', N'04-dic.-2018', N'Francisco I Madero 217, Diaz Ordaz, 96690 Agua Dulce, Ver., México', N'imagen/android.graphics.Bitmap@8bb346080SH32W4GUIR0W9CQJPQ.jpg', N'-94.14685606956482', N'18.13786424279117', 1, 2096)
SET IDENTITY_INSERT [dbo].[MovilAlertas] OFF
SET IDENTITY_INSERT [dbo].[MovilCategoria] ON 

INSERT [dbo].[MovilCategoria] ([id], [tipo]) VALUES (1, N'Alerta')
SET IDENTITY_INSERT [dbo].[MovilCategoria] OFF
SET IDENTITY_INSERT [dbo].[MovilCiudadano] ON 

INSERT [dbo].[MovilCiudadano] ([id], [Nombre], [ApellidoP], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [Telefono], [fechaNac], [Contrasena], [Token], [ImgURL], [tokennotif], [fk_id_rol], [Verificacion_Usuario]) VALUES (1076, N'Jose', N'Morales', N'0', N'Araucarias', 10, 0, N'joseluismoralesp95@gmail.com', N'+529211320942', CAST(N'2018-08-07T00:00:00' AS SmallDateTime), NULL, N'3492cbcdbf3fdb502e8932d218d71401', N'profilpic/defaultimage.jpg', N'eNV-PYm7qHM:APA91bGKv2PRAqJxVgLfauSksjFtvGy-bEz58aW6Bj5ZyDUUA4pit7hG5iZiS-WALgw2w8EYoD07O2u5osjy6nNowU-ELZB1AxJFAOrIMmfTTPY3A1EoAuzQB0TZXLYR7zPHJCXfvIQG', 3, 1)
INSERT [dbo].[MovilCiudadano] ([id], [Nombre], [ApellidoP], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [Telefono], [fechaNac], [Contrasena], [Token], [ImgURL], [tokennotif], [fk_id_rol], [Verificacion_Usuario]) VALUES (1077, N'Silvia ', N'Morales', N'000', N'araucaria', 10, 0, N'MoralesPerez1977@gmail.com', N'+529212698704', CAST(N'2018-08-07T00:00:00' AS SmallDateTime), NULL, N'03f31cacdc5bf565a4e98effd5aa3310', N'profilpic/icon.png', N'cAVBXnu4D18:APA91bG1cq_MXjo6zQvuUvfYbp1foODfOABzjeTAlx6gnw9H473xX7GQHStyDAipqHlLQoVOxf9vyYa5YgI4wdVoK1UYF6Y2LMVAwMFf_I7sxyHgQubJNSk4tk-HXECk1rpIhammb-9c', 1, 1)
INSERT [dbo].[MovilCiudadano] ([id], [Nombre], [ApellidoP], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [Telefono], [fechaNac], [Contrasena], [Token], [ImgURL], [tokennotif], [fk_id_rol], [Verificacion_Usuario]) VALUES (1078, N'José abrhan', N'Antonio matias', N'204', N'paraiso', 37, 0, N'jabrhanm@gmail.com', N'+529211481010', CAST(N'1982-12-11T00:00:00' AS SmallDateTime), NULL, N'562cc57701d344c880c6ac31e7bf3346', N'profilpic/icon.png', N'', 3, 1)
INSERT [dbo].[MovilCiudadano] ([id], [Nombre], [ApellidoP], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [Telefono], [fechaNac], [Contrasena], [Token], [ImgURL], [tokennotif], [fk_id_rol], [Verificacion_Usuario]) VALUES (1080, N'Alejandro', N'Ruiz', N'507', N'los manantiales', 50, 0, N'alejandroruizreyes9@gmail.com', N'+529211668372', CAST(N'2018-09-09T00:00:00' AS SmallDateTime), NULL, N'6de9bce8a23d3f2374579c1d1007d057', N'profilpic/test.jpg', N'd2wvjxLmL30:APA91bE-zcwugFg_c5_KOTIR5pqM3z7n0iKgic7SQaH6fVr829dJ_R8KwCnAr9yyKUZs64g-K9-8JXo7G-f-n8S9b3bcvEy0NdUe93hm73sN_p2kvAjmtxcPFZKQfTwDhe2FU7a8i3n6', 1, 1)
INSERT [dbo].[MovilCiudadano] ([id], [Nombre], [ApellidoP], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [Telefono], [fechaNac], [Contrasena], [Token], [ImgURL], [tokennotif], [fk_id_rol], [Verificacion_Usuario]) VALUES (2090, N'paul henry', N'perez arias', N'22', N'hernandez ochoa 22', 34, 0, N'paulaguadulce@outlook.com', N'+529231093140', CAST(N'2014-09-11T00:00:00' AS SmallDateTime), NULL, N'50f86c89d076e89c1f0f79decf150a39', N'profilpic/icon.png', NULL, 1, 0)
INSERT [dbo].[MovilCiudadano] ([id], [Nombre], [ApellidoP], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [Telefono], [fechaNac], [Contrasena], [Token], [ImgURL], [tokennotif], [fk_id_rol], [Verificacion_Usuario]) VALUES (2092, N'enrique', N'perez', N'452', N'calle airoso ', 1, 0, N'gotrons2010@gmail.com', N'+529211435784', CAST(N'2018-10-10T00:00:00' AS SmallDateTime), NULL, N'ca2f5247ba9449ebc2cbb1028c51a99e', N'profilpic/icon.png', N'cckX83mQ-0s:APA91bGifBuq-z18mhf7uljSK4-FAdAMoRVtvrjrgSiLh5g0D7FRF4ITh7OgZXRoX-cNiZOiXs702sAzJm6A7ygwBZ8dEe3Y6yCAGiufxgutGHxHY2_4KhYVGDeupuvv9cZewJ7ouxEK', 1, 1)
INSERT [dbo].[MovilCiudadano] ([id], [Nombre], [ApellidoP], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [Telefono], [fechaNac], [Contrasena], [Token], [ImgURL], [tokennotif], [fk_id_rol], [Verificacion_Usuario]) VALUES (2095, N'Silvia', N'Morales', NULL, NULL, NULL, NULL, N'moralesperez1977@hotmail.com', NULL, NULL, NULL, N'500cd510fe4d4dfed61114b7db36348d', N'profilpic/icon.png', N'eiB5NXwdgbc:APA91bEzcfkrtKgGxkKDCbMoYdAAms6slXxtNEhgFY-xdWPI-kuwZb3KUAKCcD6fBu6EyF0ZuA5BrPQdJiuhlw1gsfngCb_4w5lhPpq4dbzId-4qzFRqD9-6oJf4VUFuptX5Knw0mqEb', 1, 1)
INSERT [dbo].[MovilCiudadano] ([id], [Nombre], [ApellidoP], [NumeroExt], [Direccion], [IdColonia], [Sexo], [CorreoE], [Telefono], [fechaNac], [Contrasena], [Token], [ImgURL], [tokennotif], [fk_id_rol], [Verificacion_Usuario]) VALUES (2096, N'Abrhan', N'Antonio Matias', NULL, NULL, NULL, NULL, N'abrahamatias@yahoo.com.mx', NULL, NULL, NULL, N'710a05e2e5029ecb9cbfb72e5be64d8b', N'profilpic/icon.png', N'ev8G8J4MI-k:APA91bG8G0piCzU1u2jkLSlRO-eQk9WCX6hfR4dilmCmJQL41ZnCRbZBsdKh48rtNv5WWfxT3ulNb8M4bKcK4_IfSZTz-uajrbIRKTKZvQ3ehpZHV-3n-7qLw1xH5KbBT49zpfkBwU-Q', 3, 1)
SET IDENTITY_INSERT [dbo].[MovilCiudadano] OFF
SET IDENTITY_INSERT [dbo].[MovilEmergencia] ON 

INSERT [dbo].[MovilEmergencia] ([id_emergencia], [telefono], [extencion], [img_emergencia], [Nombre_emergencia]) VALUES (1009, N'2334400', N'', N'imgemergencia/android.graphics.Bitmap@54c834e.jpg', N'Protección Civil')
INSERT [dbo].[MovilEmergencia] ([id_emergencia], [telefono], [extencion], [img_emergencia], [Nombre_emergencia]) VALUES (1010, N'2330599', N'', N'imgemergencia/android.graphics.Bitmap@69aa06a.jpg', N'Centro De Salud')
INSERT [dbo].[MovilEmergencia] ([id_emergencia], [telefono], [extencion], [img_emergencia], [Nombre_emergencia]) VALUES (1011, N'9231289665', N'', N'imgemergencia/android.graphics.Bitmap@2e0216e.jpg', N'Bomberos')
INSERT [dbo].[MovilEmergencia] ([id_emergencia], [telefono], [extencion], [img_emergencia], [Nombre_emergencia]) VALUES (1012, N'2330348', N'', N'imgemergencia/android.graphics.Bitmap@b0aad0b.jpg', N'Tránsito')
INSERT [dbo].[MovilEmergencia] ([id_emergencia], [telefono], [extencion], [img_emergencia], [Nombre_emergencia]) VALUES (1013, N'2330773', N'', N'imgemergencia/android.graphics.Bitmap@7fa9424.jpg', N'DIF Municipal')
INSERT [dbo].[MovilEmergencia] ([id_emergencia], [telefono], [extencion], [img_emergencia], [Nombre_emergencia]) VALUES (1014, N'2330030', N'', N'imgemergencia/android.graphics.Bitmap@4ffc33e.jpg', N'IMSS')
INSERT [dbo].[MovilEmergencia] ([id_emergencia], [telefono], [extencion], [img_emergencia], [Nombre_emergencia]) VALUES (1015, N'2334097', N'', N'imgemergencia/android.graphics.Bitmap@dda898b.jpg', N'CFE')
INSERT [dbo].[MovilEmergencia] ([id_emergencia], [telefono], [extencion], [img_emergencia], [Nombre_emergencia]) VALUES (1016, N'2330286', N'', N'imgemergencia/android.graphics.Bitmap@defea4.jpg', N'Policía Municipal')
INSERT [dbo].[MovilEmergencia] ([id_emergencia], [telefono], [extencion], [img_emergencia], [Nombre_emergencia]) VALUES (1017, N'2330806', N'', N'imgemergencia/android.graphics.Bitmap@c8e1521.jpg', N'Hospital')
INSERT [dbo].[MovilEmergencia] ([id_emergencia], [telefono], [extencion], [img_emergencia], [Nombre_emergencia]) VALUES (1018, N'2332626', N'', N'imgemergencia/android.graphics.Bitmap@6627018.jpg', N'Cruz Roja')
SET IDENTITY_INSERT [dbo].[MovilEmergencia] OFF
SET IDENTITY_INSERT [dbo].[MovilRol] ON 

INSERT [dbo].[MovilRol] ([id_rol], [rol]) VALUES (1, N'Ciudadano')
INSERT [dbo].[MovilRol] ([id_rol], [rol]) VALUES (2, N'Trabajador')
INSERT [dbo].[MovilRol] ([id_rol], [rol]) VALUES (3, N'Administrador')
SET IDENTITY_INSERT [dbo].[MovilRol] OFF
INSERT [dbo].[RelSolCiud] ([IdCiudadano], [IdSolicitud]) VALUES (1, 1)
INSERT [dbo].[RelSolCiud] ([IdCiudadano], [IdSolicitud]) VALUES (2, 2)
INSERT [dbo].[RelSolCiud] ([IdCiudadano], [IdSolicitud]) VALUES (3, 3)
INSERT [dbo].[RelSolCiud] ([IdCiudadano], [IdSolicitud]) VALUES (4, 4)
INSERT [dbo].[RelSolCiud] ([IdCiudadano], [IdSolicitud]) VALUES (7, 7)
INSERT [dbo].[RelSolCiud] ([IdCiudadano], [IdSolicitud]) VALUES (5, 5)
INSERT [dbo].[RelSolCiud] ([IdCiudadano], [IdSolicitud]) VALUES (6, 6)
INSERT [dbo].[Seguimiento] ([IdSolicitudEstado], [Comentario]) VALUES (32, N'dtghdfgh')
SET IDENTITY_INSERT [dbo].[Servicio] ON 

INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (1, N'CONTRALORIA', 1, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (2, N'APOYO A TRASLADO', 2, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (3, N'CULTURA', 3, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (4, N'SEGURIDAD', 4, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (5, N'MANTENIMIENTO DE CALLE', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (6, N'AMPLIACION DE DRENAJE', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (7, N'ALCANTARILLADO', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (8, N'POZO', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (9, N'SOLICITUD DE TOPES', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (10, N'RELLENO', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (11, N'APOYO PARA ESCUELA', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (12, N'AYUDA DE CONSTRUCCION', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (13, N'SOLICITUD DE ROLLOS DE ALAMBRE', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (14, N'OBRA', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (15, N'AMPLIACION RED ELECTRICA', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (16, N'ELECTRIFICACION', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (17, N'REHABILITACION DE CALLES Y BANQUETAS', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (18, N'DRENAJE', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (19, N'REPARACION DE PUENTE', 5, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (20, N'TESORERIA', 6, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (21, N'SALUD', 7, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (22, N'RECLUTAMIENTO', 8, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (23, N'APOYO A IGLESIA', 9, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (24, N'PARTICIPACION CIUDADANA', 10, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (25, N'SERVICIOS PUBLICO MUNICIPALES', 11, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (26, N'REGIDURIA 1ra', 12, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (27, N'TURISMO', 13, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (28, N'PRESIDENCIA', 14, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (29, N'APOYO PARA TRANSPORTE', 15, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (30, N'SOLICITUD DE ASISTENCIA DEL PRESIDENTE A EVENTO', 15, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (31, N'VISITA A COLONIAS', 15, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (32, N'AYUDA CON ARBOL', 16, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (33, N'PROTEGER ANIMALES DE LA CALLE', 16, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (34, N'TRAMITE DE ANIMALES', 16, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (35, N'REGIDURIA 5ta', 17, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (36, N'SALUID', 18, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (37, N'INGRESOS', 19, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (38, N'UNIDAD DE TRANSPARENCIA', 20, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (39, N'APOYO AL DEPORTISTA', 21, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (40, N'INFORMATICA', 22, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (41, N'RELACIONES LABORALES', 23, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (42, N'REGISTRO CIVIL', 24, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (43, N'FOMENTO AGROPECUARIO', 25, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (44, N'SERVICIOS PUBLICOS', 26, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (45, N'EQUIDAD Y GENERO', 27, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (46, N'DESCUENTO PAGO PREDIAL', 28, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (47, N'ACLARACION PREDIAL', 28, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (48, N'REGIDURIA 4ta', 29, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (49, N'SECRETARIA DEL AYUNTAMIENTO', 30, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (50, N'SEDESOL', 31, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (51, N'SINDICATURA', 32, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (52, N'BIBLIOTECAS', 33, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (53, N'REGIDURIA 3ra', 34, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (54, N'INSTALACION DE LAMPARAS', 35, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (55, N'CAMBIO DE LAMPARAS', 35, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (56, N'AMPLIACION ILUMINACION', 35, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (57, N'RECOLECCION DE BASURA', 36, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (58, N'COMUNICACION SOCIAL', 37, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (59, N'EVENTOS ESPECIALES', 38, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (60, N'PATRIMONIO', 39, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (61, N'REGIDOR 2do', 40, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (62, N'JUVENTUD', 41, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (63, N'JURIDICO', 42, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (64, N'MANTENIMIENTO AL PARQUE', 43, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (65, N'IVEA', 44, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (66, N'REGIDURIA 2da', 45, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (67, N'DIVERSIDAD SEXUAL', 46, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (68, N'RASTRO MUNICIPAL', 47, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (69, N'EDUCACION', 48, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (70, N'APOYO DESPENSAS', 49, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (71, N'JARDIN DE NIÑOS', 49, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (72, N'APOYO A MADRE SOLTERA', 49, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (73, N'ADULTOS MAYORES', 49, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (74, N'CASA HOGAR NIÑOS', 49, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (75, N'APOYO A DISCAPACITADOS', 49, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (76, N'APOYO PARA PENSION', 49, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (77, N'OFICINA', 50, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (78, N'CLINICA DIF', 51, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (79, N'CLINICA', 52, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (80, N'RECUPERACION DE PROPIEDAD', 53, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (81, N'REGULARIZACION TERRENO', 53, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (82, N'REHABILITACION DE CALLE', 53, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (83, N'PROBLEMA EN CALLE', 53, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (84, N'INVASION TERRENO PUBLICO', 53, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (85, N'LIBERACION DE OBRA', 53, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (86, N'PERMISO DE CONSTRUCCION', 53, N'.')
INSERT [dbo].[Servicio] ([Id], [Servicio], [IdDependencia], [Descripcion]) VALUES (87, N'TRAMITE POSESION DE DERECHOS', 53, N'.')
SET IDENTITY_INSERT [dbo].[Servicio] OFF
SET IDENTITY_INSERT [dbo].[Solicitud] ON 

INSERT [dbo].[Solicitud] ([Id], [Descripcion], [IdServicio], [IdColonia], [Calle], [Ref1], [Ref2], [idformacontacto], [prioritario], [idtmp]) VALUES (1, N'APOYO PARA REGULARISACION DE TERRENO', 60, 31, N'venustiano carranza', N'callejon chellen', N'', 2, 0, NULL)
INSERT [dbo].[Solicitud] ([Id], [Descripcion], [IdServicio], [IdColonia], [Calle], [Ref1], [Ref2], [idformacontacto], [prioritario], [idtmp]) VALUES (2, N'AMPLIACION DE ENERGIA ELECTRICA', 24, 16, N'manuel fuentes', N'ferrocaril', N'', 2, 0, NULL)
INSERT [dbo].[Solicitud] ([Id], [Descripcion], [IdServicio], [IdColonia], [Calle], [Ref1], [Ref2], [idformacontacto], [prioritario], [idtmp]) VALUES (3, N'SOLICITUD DE RETRO PARA PESCADO O CAMARON', 43, 22, N'fco y madero', N'amiliano zapata', N'', 2, 0, NULL)
INSERT [dbo].[Solicitud] ([Id], [Descripcion], [IdServicio], [IdColonia], [Calle], [Ref1], [Ref2], [idformacontacto], [prioritario], [idtmp]) VALUES (4, N'peticion de alumbrado', 55, 19, N'', N'', N'', 2, 0, NULL)
INSERT [dbo].[Solicitud] ([Id], [Descripcion], [IdServicio], [IdColonia], [Calle], [Ref1], [Ref2], [idformacontacto], [prioritario], [idtmp]) VALUES (5, N'Respuesta en apoyo de escombro o llantas en la parte del rio', 2, 58, N'', N'', N'', 2, 0, NULL)
INSERT [dbo].[Solicitud] ([Id], [Descripcion], [IdServicio], [IdColonia], [Calle], [Ref1], [Ref2], [idformacontacto], [prioritario], [idtmp]) VALUES (6, N'Respuesta en apoyo de escombro o llantas en la parte del rio', 2, 58, N'eduardo soto ines', N'lazaro cardenas', N'', 2, 0, NULL)
INSERT [dbo].[Solicitud] ([Id], [Descripcion], [IdServicio], [IdColonia], [Calle], [Ref1], [Ref2], [idformacontacto], [prioritario], [idtmp]) VALUES (7, N'reavilitacion de calle', 24, 27, N'veracruz', N'lorenzo barcelata', N'', 2, 0, NULL)
SET IDENTITY_INSERT [dbo].[Solicitud] OFF
SET IDENTITY_INSERT [dbo].[SolicitudEstado] ON 

INSERT [dbo].[SolicitudEstado] ([IdSolicitudEstado], [IdSolicitud], [IdEstado], [FechaHora], [IdCaptura]) VALUES (1, 1, 1, CAST(N'2018-10-29T12:25:00' AS SmallDateTime), N'AUDIENCIA')
INSERT [dbo].[SolicitudEstado] ([IdSolicitudEstado], [IdSolicitud], [IdEstado], [FechaHora], [IdCaptura]) VALUES (2, 2, 1, CAST(N'2018-10-29T12:32:00' AS SmallDateTime), N'AUDIENCIA')
INSERT [dbo].[SolicitudEstado] ([IdSolicitudEstado], [IdSolicitud], [IdEstado], [FechaHora], [IdCaptura]) VALUES (3, 3, 1, CAST(N'2018-10-29T12:44:00' AS SmallDateTime), N'AUDIENCIA')
INSERT [dbo].[SolicitudEstado] ([IdSolicitudEstado], [IdSolicitud], [IdEstado], [FechaHora], [IdCaptura]) VALUES (4, 4, 1, CAST(N'2018-10-29T12:50:00' AS SmallDateTime), N'AUDIENCIA')
INSERT [dbo].[SolicitudEstado] ([IdSolicitudEstado], [IdSolicitud], [IdEstado], [FechaHora], [IdCaptura]) VALUES (5, 5, 1, CAST(N'2018-10-29T12:58:00' AS SmallDateTime), N'AUDIENCIA')
INSERT [dbo].[SolicitudEstado] ([IdSolicitudEstado], [IdSolicitud], [IdEstado], [FechaHora], [IdCaptura]) VALUES (6, 6, 1, CAST(N'2018-10-29T13:05:00' AS SmallDateTime), N'AUDIENCIA')
INSERT [dbo].[SolicitudEstado] ([IdSolicitudEstado], [IdSolicitud], [IdEstado], [FechaHora], [IdCaptura]) VALUES (7, 7, 1, CAST(N'2018-10-29T13:27:00' AS SmallDateTime), N'AUDIENCIA')
INSERT [dbo].[SolicitudEstado] ([IdSolicitudEstado], [IdSolicitud], [IdEstado], [FechaHora], [IdCaptura]) VALUES (32, 1, 2, CAST(N'2018-11-06T12:47:00' AS SmallDateTime), N'AUDIENCIA')
SET IDENTITY_INSERT [dbo].[SolicitudEstado] OFF
SET IDENTITY_INSERT [dbo].[TiempoRespuesta] ON 

INSERT [dbo].[TiempoRespuesta] ([idTiempo], [descripcion], [verde], [amarillo], [naranja], [rojo]) VALUES (1, N'TIEMPO DE RESPUESTA INDEFINIDO', 0, 0, 0, 0)
INSERT [dbo].[TiempoRespuesta] ([idTiempo], [descripcion], [verde], [amarillo], [naranja], [rojo]) VALUES (2, N'1 d¡a de tiempo de respuesta', 24, 48, 72, 72)
INSERT [dbo].[TiempoRespuesta] ([idTiempo], [descripcion], [verde], [amarillo], [naranja], [rojo]) VALUES (3, N'Un d¡a y medio de tiempo de respuesta', 36, 48, 72, 82)
INSERT [dbo].[TiempoRespuesta] ([idTiempo], [descripcion], [verde], [amarillo], [naranja], [rojo]) VALUES (4, N'3 DÍA DE TIEMPO DE RESPUSTA', 72, 82, 94, 120)
SET IDENTITY_INSERT [dbo].[TiempoRespuesta] OFF
SET IDENTITY_INSERT [seguridad].[esAppRoles] ON 

INSERT [seguridad].[esAppRoles] ([iAppRoleID], [iAppID], [sRole]) VALUES (14, 11, N'Administrador')
INSERT [seguridad].[esAppRoles] ([iAppRoleID], [iAppID], [sRole]) VALUES (15, 11, N'Supervisor')
INSERT [seguridad].[esAppRoles] ([iAppRoleID], [iAppID], [sRole]) VALUES (16, 11, N'Operador Dependencia')
INSERT [seguridad].[esAppRoles] ([iAppRoleID], [iAppID], [sRole]) VALUES (17, 11, N'Operador Recepción')
INSERT [seguridad].[esAppRoles] ([iAppRoleID], [iAppID], [sRole]) VALUES (18, 11, N'Alcalde')
INSERT [seguridad].[esAppRoles] ([iAppRoleID], [iAppID], [sRole]) VALUES (20, 11, N'Operador Calidad')
SET IDENTITY_INSERT [seguridad].[esAppRoles] OFF
INSERT [seguridad].[esApps] ([iAppID], [sAppName], [sDesc], [sURL]) VALUES (11, N'SIRC', N'Sistema Integral de Relación con Ciudadanos', N'http::\\')
SET IDENTITY_INSERT [seguridad].[esAppWebUsuario] ON 

INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (1, 1, N'JMATIAS', N'ABRHAN ANTONIO MATIAS', N'JABRHANM@GMAIL.COM', N'f4M1PpVw9Xk=', 1, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (2, NULL, N'AUDIENCIA', N'AUDIENCIAS PÚBLICAS', N'SIMAC@COATZACOALCOS.GOB.MX', N'f4M1PpVw9Xk=', 1, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (5, NULL, N'JCABALLERO', N'JOAQUIN CABALLERO ROSIÑOL', N'FABY1310@HOTMAIL.COM', N'cnVpL80qhJxu+6HnHHENtg==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (6, NULL, N'FRAMOS', N'FERNANDO RAMOS', N'FRAMOS@GMAIL.COM', N'DnNyMvaqd0g=', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (7, NULL, N'GIBARRA', N'GUILLERMO IBARRA', N'GIBARRA@GMIAL.COM', N'1XpdyVmrGMo=', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (8, NULL, N'BANELLY', N'BANELLY OBRAS PÚBLICAS', N'B@CORREO.COM', N'f4M1PpVw9Xk=', 1, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (9, NULL, N'ALICIA', N'ALICIA PALMER LOPEZ', N'FABY1310@HOTMAIL.COM', N'f4M1PpVw9Xk=', 1, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10, NULL, N'SCUEVAS', N'SARAHIT CUEVAS', N'FABY1310@HOTMAIL.COM', N'ftvo3zsdG/g=', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (11, NULL, N'GTOREA', N'GRETEL TOREA', N'FABY1310@HOTMAIL.COM', N'7Q4Rns9W+jg=', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (13, NULL, N'PORTAL', N'SISTEMA WEB', N'FABY1310@HOTMAIL.COM', N'f4M1PpVw9Xk=', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (15, 7, N'audiencia', N'Usuario de audiencia', N'correo', N'fQrJZqW+7+rqNZ13WxGTAA==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (16, 6, N'demo', N'usuario demo', N'.', N'7OH04dX3eKs=', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (17, 2, N'pacomale', N'francisco', N'pacovillaseca28@gmail.com', N'GYncFzKI6/iD9EZXncVvKg==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (18, 3, N'alumbradop', N'nombre del encargado', N'correo@correo.com', N'milKY+UNvFHUmf+gIlhpFw==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (19, 2, N'aciudadana', N'aciudadana', N'correo@correo.com', N'Fwirtg6afxt0JhCAiMNcnQ==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10018, 3, N'auroramdz', N'Aurora Mendoza', N'correo@correo.com', N'XneGrCwMXael6hu1JsMCRA==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10019, 3, N'juanasaori', N'Juana Saori Alejandro', N'corre@correo.com', N'XneGrCwMXael6hu1JsMCRA==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10020, 3, N'eduardohdz', N'Eduardo Hernandez', N'correo@corre.com', N'XneGrCwMXael6hu1JsMCRA==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10021, 3, N'juanamaria', N'Juana Maria Cadena', N'correo@correo.com', N'XneGrCwMXael6hu1JsMCRA==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10022, 3, N'raulromar', N'Raul R rios', N'correo@corre.com', N'XneGrCwMXael6hu1JsMCRA==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10023, 3, N'ernestogp', N'ernesto Gallegos Perez', N'', N'UUs+bjV4OGI/3yR5EDLnug==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10024, 3, N'victorbr', N'victor Bravo', N'', N'UUs+bjV4OGI/3yR5EDLnug==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10025, 3, N'eduardorm', N'Eduardo Raymundo Maldonado', N'', N'bWfixkmbfLQ=', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10026, 3, N'silviagr', N'Silvia Gonzalez Rios', N'', N'fAjwYWPrWY+l6hu1JsMCRA==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10027, 2, N'tomasgg', N'Tomás Gutierrez Gomez', N'', N'MC25zZiwhfWC94q7cDCu+A==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10028, 3, N'zaideyt', N'zaide yamel tannos alejandro', N'', N'MC25zZiwhfXJ+YJgiirnOQ==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10029, 2, N'karenct', N'Karen Contreras', N'', N'rd7gDtVZUw6l6hu1JsMCRA==', 0, 1)
INSERT [seguridad].[esAppWebUsuario] ([iAppID], [IDROL], [iAppLogin], [iAppNombreC], [iAppCorreo], [iAppPwd], [iAppAudiencia], [iAppActivo]) VALUES (10030, 3, N'paulhp', N'Paul Henry Perez Arias', N'', N'12zExfLlwu2l6hu1JsMCRA==', 0, 1)
SET IDENTITY_INSERT [seguridad].[esAppWebUsuario] OFF
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (30, 1, N'Carlos Omar', N'Constantino Estrada', 1, 22, N'constitución #49', N'la bomba', N'922 223 1520', N'minatitlán', N'karl_el82@yahoo.com.mx', N'Innovación gubernamental')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (35, 1, N'Fabiola', N'Patraca', 2, 0, N'', N'', N'', N'', N'fpatraca@coatzacoalcos.gob.mx', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (36, 1, N'Alan', N'Medina', 1, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (37, 1, N'Esperanza', N'Guillen', 2, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (41, 1, N'karen selene', N'de Constantino', 2, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (42, 1, N'polo', N'', 1, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (43, 1, N'd', N'', 1, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (44, 1, N'Naxhielii', N'Entar', 2, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (45, 1, N'Secretaría', N'de Gobernación', 1, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (46, 1, N'Mtro. Iván Hillman', N'', 1, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (47, 1, N'Francisco R.', N'Martínez Villaseca', 1, 28, N'S. Diaz Miron 1201', N'Maria de la Piedad', N'921 211 0817', N'Coatzacoalcos', N'fmartinez@coatzacoalcos.gob.mx', N'Innovacion Gubernamental')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (48, 1, N'atencion', N'ciudadana', 1, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (49, 1, N'limpia', N'publica', 1, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (50, 1, N'María Miricia', N'Pérez González', 2, 0, N'', N'', N'', N'', N'', N'Coordinación de Servicios a la Ciudadanía')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (51, 1, N'Jaime', N'Santiago Petris', 1, 0, N'', N'', N'', N'', N'', N'Coordinación de Servicios a la Ciudadanía')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (52, 1, N'Beatriz', N'Fernández García', 2, 0, N'', N'', N'', N'', N'', N'Presidencia')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (53, 1, N'Alan', N'Medina Atilano', 1, 0, N'', N'', N'', N'', N'coatzatel@coatzacoalcos.gob.mx', N'Coatzatel')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (54, 1, N'Esperanza', N'Guillén Hernández', 2, 0, N'', N'', N'', N'', N'coatzatel@coatzacoalcos.gob.mx', N'Coatzatel')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (55, 1, N'Naxhieli', N'Entar de Jesús', 2, 0, N'', N'', N'', N'', N'coatzatel@coatzacoalcos.gob.mx', N'Coatzatel')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (56, 1, N'Fabiola', N'Patraca Antonio', 2, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (57, 1, N'Bertha Juliana', N'Vera', 2, 0, N'', N'', N'', N'', N'', N'Obras Públicas y Desarrollo Urbano')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (58, 1, N'Gerardo', N'Hernández Aguilar', 1, 0, N'', N'', N'', N'', N'', N'Secretaría de Gobierno')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (59, 1, N'Ing. Manuel', N'Peña Sánchez', 1, 0, N'', N'', N'', N'', N'', N'Obras Públicas Y Servicios Municipales')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (60, 1, N'Lic. Marco Antonio', N'Ramírez', 2, 0, N'', N'', N'', N'', N'', N'Presidencia')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (61, 1, N'Guadalupe', N'Medina', 2, 0, N'', N'', N'', N'', N'', N'SRIA. DE OBRAS PÚBLICAS Y DESARROLLO URBANO')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (62, 1, N'Nohemí', N'Ortiz Reyes', 2, 0, N'', N'', N'', N'', N'', N'SECRETARÍA DE GOBIERNO')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (63, 1, N'Dulce Vanessa', N'Guerra Mendoza', 2, 0, N'', N'', N'', N'', N'', N'DIRECCIÓN DE OBRAS PÚBLICAS Y SERV. MUNICIPALES')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (64, 1, N'Edgar', N'Quintero Yong', 1, 0, N'', N'', N'', N'', N'', N'DIRECCIÓN DE OBRAS PÚBLICAS Y SERV. MUNICIPALES')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (65, 1, N'Inés', N'Valencia Pavón', 1, 0, N'', N'', N'', N'', N'', N'DEPARTAMENT0 DE LIMPIA PÚBLICA')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (66, 1, N'Karina', N'Guillén Baltazar', 1, 0, N'', N'', N'', N'', N'', N'DEPARTAMENT0 DE LIMPIA PÚBLICA')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (67, 1, N'Octavio', N'De los Reyes Trejo', 1, 0, N'', N'', N'', N'', N'', N'DEPARTAMENTO DE ORNATOS')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (68, 1, N'Francisco Javier', N'Lira Vargas', 1, 0, N'', N'', N'', N'', N'', N'DEPARTAMENTO DE ORNATOS')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (69, 1, N'José Manuel', N'De la Cruz Méndez', 1, 0, N'', N'', N'', N'', N'', N'DEPARTAMENTO DE ALUMBRADO PÚBLICO')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (70, 1, N'Sarahit', N'Cuevas Maldonado', 1, 0, N'', N'', N'', N'', N'', N'DEPARTAMENTO DE ALUMBRADO PÚBLICO')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (71, 1, N'Luis De Jesús', N'Castro Mendizábal', 1, 0, N'', N'', N'', N'', N'', N'UNIDAD MUNICIPAL DE PROTECCIÓN CIVIL')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (72, 1, N'Erika', N'Solórzano Salazar', 1, 0, N'', N'', N'', N'', N'', N'UNIDAD MUNICIPAL DE PROTECCIÓN CIVIL')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (73, 1, N'Isamel', N'Franco Torres', 1, 0, N'', N'', N'', N'', N'', N'DEPARTAMENTO DE MAQUINARIA PESADA')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (74, 1, N'Argelia', N'Carrasco Domínguez', 1, 0, N'', N'', N'', N'', N'', N'DEPARTAMENTO DE MAQUINARIA PESADA')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (75, 1, N'Pablo César', N'Rebolledo Aponte', 1, 0, N'', N'', N'', N'', N'', N'DIRECCIÓN DE DESARROLLO URBANO Y ECOLOGÍA')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (76, 1, N'Nidia', N'Molina Sánchez', 1, 0, N'', N'', N'', N'', N'', N'DIRECCIÓN DE DESARROLLO URBANO Y ECOLOGÍA')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (77, 1, N'Daniel', N'Izquierdo Pineda', 1, 0, N'', N'', N'', N'', N'', N'SECRETARÍA DEL AYUNTAMIENTO')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (78, 1, N'Conrado', N'Navarrete Gregorio', 1, 0, N'', N'', N'', N'', N'', N'SECRETARÍA DEL AYUNTAMIENTO')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (79, 1, N'Gustavo Alonso', N'Linares Yépez', 1, 0, N'', N'', N'', N'', N'', N'DIF MUNICIPAL')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (80, 1, N'Esmeralda', N'Ramón Carless', 1, 0, N'', N'', N'', N'', N'', N'DIF MUNICIPAL')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (81, 1, N'Evelyn', N'Canche Limuz', 1, 0, N'', N'', N'', N'', N'', N'SUBDIRECCIÓN DE SERVICIOS MUNICIPALES')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (82, 1, N'Ernesto', N'Tapia', 1, 0, N'', N'', N'', N'', N'', N'SUBDIRECCIÓN DE SERVICIOS MUNICIPALES')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (83, 1, N'Erika', N'Sánchez Herrera', 1, 0, N'', N'', N'', N'', N'', N'SUBDIRECCIÓN DE SERVICIOS MUNICIPALES')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (84, 1, N'Estela', N'Barrientos', 1, 0, N'', N'', N'', N'', N'', N'SUBDIRECCIÓN DE SERVICIOS MUNICIPALES')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (85, 1, N'Lorena', N'Franyutti Aguirre', 2, 0, N'', N'', N'', N'', N'', N'Atención Ciudadana')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (86, 1, N'Martha', N'Pineda', 2, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (87, 1, N'Gabriel', N'Alemán González', 1, 0, N'', N'', N'', N'', N'', N'Secretaría de Gobierno')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (88, 1, N'Josefa', N'Tadeo Vadillo', 2, 0, N'', N'', N'', N'', N'', N'Subdirección de Infraestructura')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (89, 1, N'Ing. José Jorge', N'Calderón Todd', 1, 0, N'', N'', N'', N'', N'', N'Sria. Obras Públicas y Ayuntamiento')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (90, 1, N'Felipe', N'Córdoba', 1, 26, N'', N'', N'', N'', N'', N'Dirección de Gobernación')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (91, 1, N'Lic. Mariano', N'Moreno Canepa', 1, 0, N'', N'', N'', N'', N'', N'Tesorería')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (92, 1, N'Luis Daniel', N'Capiz Alemàn', 1, 0, N'', N'', N'', N'', N'', N'Secretarìa del Ayuntamiento')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (93, 1, N'Ana María', N'Rueda', 2, 0, N'', N'', N'', N'', N'', N'Limpia pública')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (94, 1, N'Arturo', N'Sainz', 1, 0, N'', N'', N'', N'', N'', N'Subdirección de Infraestructura')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (95, 1, N'Comisión Municipal', N'de Agua y Saneamiento', 1, 0, N'', N'', N'', N'', N'', N'CMAS')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (96, 1, N'Denisse', N'Estrada', 2, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (97, 1, N'Victoria Eugenia', N'Cuevas Sánchez', 2, 0, N'', N'', N'', N'', N'', N'OP Enlace Ciudadano')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (98, 1, N'Paula', N'Cervera Mendiola', 2, 0, N'', N'', N'', N'', N'', N'Alumbrado')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (99, 1, N'Lorena', N'Ocampo', 2, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (100, 1, N'Edelmira', N'Coliaza', 2, 0, N'', N'', N'', N'', N'', N'')
INSERT [seguridad].[esDetallesUsers] ([iUserID], [iAppID], [sNombre], [sApellido], [iSexo], [iEdad], [sDireccion], [sColonia], [sTelefono], [sCiudad], [sCorreoE], [sDependencia]) VALUES (101, NULL, N'Operador', N'Calidad', 1, 0, N'', N'', N'', N'', N'', N'')
SET IDENTITY_INSERT [seguridad].[MODULO] ON 

INSERT [seguridad].[MODULO] ([IDMODULO], [DESCRIPCION], [MODULO], [URL], [ACTIVO]) VALUES (1, N'CONSULTAS VARIAS', N'CONSULTA', N'#', 1)
INSERT [seguridad].[MODULO] ([IDMODULO], [DESCRIPCION], [MODULO], [URL], [ACTIVO]) VALUES (3, N'VER REPORTES Y ENTRADAS TEMPORALES', N'VER', N'#', 1)
INSERT [seguridad].[MODULO] ([IDMODULO], [DESCRIPCION], [MODULO], [URL], [ACTIVO]) VALUES (4, N'AUDIENCIAS PÚBLICAS', N'AUDIENCIAS', N'#', 1)
INSERT [seguridad].[MODULO] ([IDMODULO], [DESCRIPCION], [MODULO], [URL], [ACTIVO]) VALUES (5, N'VER REPORTES POR ESTADO', N'VERREPORTE', N'#', 1)
INSERT [seguridad].[MODULO] ([IDMODULO], [DESCRIPCION], [MODULO], [URL], [ACTIVO]) VALUES (6, N'VER MIS CAPTURAS', N'VERMISCAPTURAS', N'#', 1)
INSERT [seguridad].[MODULO] ([IDMODULO], [DESCRIPCION], [MODULO], [URL], [ACTIVO]) VALUES (7, N'VER LOS CATALOGOS', N'VERCATALOGOS', N'#', 1)
INSERT [seguridad].[MODULO] ([IDMODULO], [DESCRIPCION], [MODULO], [URL], [ACTIVO]) VALUES (10, N'TODO LO REFERENTE A SEGURIDAD', N'SEGURIDAD', N'#', 1)
SET IDENTITY_INSERT [seguridad].[MODULO] OFF
SET IDENTITY_INSERT [seguridad].[PAGINA] ON 

INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (1, 1, N'Consulta dependencias', N'repDependencia.aspx', N'cdep', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (2, 3, N'captura de reportes entrantes', N'capturaReporeByDependenciaPag.aspx', N'crdep', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (3, 4, N'Control Asistencia audiencias públicas', N'audienciaCtrlAsistencia.aspx', N'acasis', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (4, 5, N'ver reportes entrantes', N'SolicitudesEntrantes.aspx', N'repEntrante', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (5, 6, N'capturas del dia', N'misCapturasDelDiaPag.aspx', N'capdia', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (6, 7, N'Catalogo de colonia', N'CapturaColoniasCat.aspx', N'catCol', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (7, 1, N'consulta de servicios', N'repServicio.aspx', N'cserv', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (8, 1, N'consulta de estados', N'#', N'cedo', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (9, 1, N'consulta de colonias', N'repColonias.aspx', N'ccol', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (10, 1, N'consulta de graficas', N'repGraficasTop10.aspx', N'cgraph', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (11, 1, N'consulta de folios', N'epBuscarPorFolio.aspx', N'cbfol', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (12, 3, N'consulta de reportes', N'consultaReporteByDependenciaPag.aspx', N'crdep02', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (13, 3, N'Entradas temporales por mobil', N'entradasTemporalesMobilPag.aspx', N'etmobil', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (14, 3, N'Entradas temporales por web', N'capturaTemporalesWebPag.aspx', N'etweb', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (15, 4, N'Audiencias publicias', N'audiencia.aspx', N'aaudi', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (16, 5, N'ver reportes en proceso', N'reportesEnProceso.aspx', N'repProceso', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (17, 5, N'ver reportes en gestión', N'reporteProcesodeGestion.aspx', N'repGestion', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (18, 5, N'ver reportes suspendidas', N'capturaSuspendidas.aspx', N'repSuspendidas', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (19, 5, N'ver reportes por confirmar', N'reporteRealizadosConfirmar.aspx', N'repRealizadas', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (20, 5, N'ver reportes caso de éxito', N'reporteCasoExito.aspx', N'repExito', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (21, 6, N'capturas devueltas', N'capturasdevueltaspag.aspx', N'capdev', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (22, 7, N'catalogo de dependencias', N'CapturaDependenciasCat.aspx', N'catdep', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (23, 7, N'catalogo de localidades', N'CapturaLocalidadCat.aspx', N'catloc', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (24, 7, N'catalogo de servicio', N'CapturaServiciosCat.aspx', N'catserv', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (25, 7, N'catalogo de tiempo de respuesta', N'CapturaTiempoRespuestaCat.aspx', N'cattiempor', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (26, 10, N'Cambio de contraseña', N'Cambiocontraseña.aspx', N'seg01', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (27, 10, N'Asignación de privilegios', N'PermisosRoles.aspx', N'seg02', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (28, 10, N'Gestion de usuarios', N'PerfilesUsuarios.aspx', N'seg03', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (29, 10, N'Asignar dependencia a usuarios', N'PermisosUsrDep.aspx', N'seg04', 1)
INSERT [seguridad].[PAGINA] ([IDPAGINA], [IDMODULO], [TITULO], [PAGINA], [CODIGO], [ACTIVO]) VALUES (30, 4, N'Consulta Audiencias', N'audienciaConsultapag.aspx', N'aaudic', 1)
SET IDENTITY_INSERT [seguridad].[PAGINA] OFF
SET IDENTITY_INSERT [seguridad].[PERMISOROL] ON 

INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (1, 1, 1, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (2, 2, 1, 3)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (3, 3, 1, 4)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (5, 5, 1, 6)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (6, 6, 1, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (7, 7, 1, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (8, 8, 1, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (9, 9, 1, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (10, 10, 1, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (11, 11, 1, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (12, 12, 1, 3)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (13, 13, 1, 3)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (14, 14, 1, 3)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (15, 15, 1, 4)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (16, 16, 1, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (17, 17, 1, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (18, 18, 1, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (19, 19, 1, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (20, 20, 1, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (21, 21, 1, 6)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (22, 22, 1, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (23, 23, 1, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (24, 24, 1, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (25, 25, 1, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (26, 26, 1, 10)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (27, 27, 1, 10)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (28, 4, 2, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (29, 28, 1, 10)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (30, 15, 7, 4)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (31, 3, 7, 4)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (32, 29, 1, 10)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (33, 4, 1, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (34, 30, 7, 4)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (35, 30, 1, 4)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (36, 1, 2, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (37, 7, 2, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (38, 8, 2, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (39, 9, 2, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (40, 10, 2, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (41, 11, 2, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (42, 20, 6, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (43, 19, 6, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (44, 21, 6, 6)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (45, 6, 6, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (46, 22, 6, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (47, 23, 6, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (48, 24, 6, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (49, 25, 6, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (50, 11, 6, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (51, 30, 2, 4)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (52, 12, 6, 3)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (53, 16, 2, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (54, 17, 2, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (55, 18, 2, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (56, 19, 2, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (57, 20, 2, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (58, 2, 2, 3)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (59, 5, 3, 6)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (60, 21, 3, 6)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (61, 4, 3, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (62, 16, 3, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (63, 17, 3, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (64, 18, 3, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (65, 19, 3, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (66, 20, 3, 5)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (67, 26, 3, 10)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (68, 11, 3, 1)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (70, 12, 3, 3)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (71, 12, 2, 3)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (72, 13, 2, 3)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (73, 14, 2, 3)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (74, 3, 2, 4)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (75, 15, 2, 4)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (76, 5, 2, 6)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (77, 21, 2, 6)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (78, 6, 2, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (79, 22, 2, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (80, 23, 2, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (81, 24, 2, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (82, 25, 2, 7)
INSERT [seguridad].[PERMISOROL] ([IDPERMISOROL], [IDPAGINA], [IDROL], [IDMODULO]) VALUES (83, 26, 2, 10)
SET IDENTITY_INSERT [seguridad].[PERMISOROL] OFF
SET IDENTITY_INSERT [seguridad].[RELUSERDEP] ON 

INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1, 35, 18, CAST(N'2018-11-05T14:44:26.380' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (2, 35, 19, CAST(N'2018-11-05T15:43:36.433' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (3, 9, 19, CAST(N'2018-11-05T15:43:36.460' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (4, 33, 19, CAST(N'2018-11-05T15:43:36.463' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (5, 28, 19, CAST(N'2018-11-05T15:43:36.467' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (6, 52, 19, CAST(N'2018-11-05T15:43:36.473' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (7, 51, 19, CAST(N'2018-11-05T15:43:36.473' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (8, 21, 19, CAST(N'2018-11-05T15:43:36.477' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (9, 37, 19, CAST(N'2018-11-05T15:43:36.480' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (10, 1, 19, CAST(N'2018-11-05T15:43:36.483' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (11, 3, 19, CAST(N'2018-11-05T15:43:36.483' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (12, 53, 19, CAST(N'2018-11-05T15:43:36.487' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (13, 49, 19, CAST(N'2018-11-05T15:43:36.490' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (14, 46, 19, CAST(N'2018-11-05T15:43:36.490' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (15, 16, 19, CAST(N'2018-11-05T15:43:36.493' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (16, 48, 19, CAST(N'2018-11-05T15:43:36.497' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (17, 27, 19, CAST(N'2018-11-05T15:43:36.497' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (18, 38, 19, CAST(N'2018-11-05T15:43:36.500' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (19, 25, 19, CAST(N'2018-11-05T15:43:36.500' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (20, 15, 19, CAST(N'2018-11-05T15:43:36.503' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (21, 22, 19, CAST(N'2018-11-05T15:43:36.507' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (22, 19, 19, CAST(N'2018-11-05T15:43:36.507' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (23, 44, 19, CAST(N'2018-11-05T15:43:36.510' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (24, 42, 19, CAST(N'2018-11-05T15:43:36.510' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (25, 41, 19, CAST(N'2018-11-05T15:43:36.513' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (26, 36, 19, CAST(N'2018-11-05T15:43:36.517' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (27, 5, 19, CAST(N'2018-11-05T15:43:36.520' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (28, 50, 19, CAST(N'2018-11-05T15:43:36.520' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (29, 43, 19, CAST(N'2018-11-05T15:43:36.523' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (30, 10, 19, CAST(N'2018-11-05T15:43:36.527' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (31, 39, 19, CAST(N'2018-11-05T15:43:36.527' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (32, 14, 19, CAST(N'2018-11-05T15:43:36.530' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (33, 2, 19, CAST(N'2018-11-05T15:43:36.533' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (34, 47, 19, CAST(N'2018-11-05T15:43:36.533' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (35, 8, 19, CAST(N'2018-11-05T15:43:36.537' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (36, 40, 19, CAST(N'2018-11-05T15:43:36.540' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (37, 12, 19, CAST(N'2018-11-05T15:43:36.540' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (38, 45, 19, CAST(N'2018-11-05T15:43:36.543' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (39, 34, 19, CAST(N'2018-11-05T15:43:36.550' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (40, 29, 19, CAST(N'2018-11-05T15:43:36.550' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (41, 17, 19, CAST(N'2018-11-05T15:43:36.553' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (42, 24, 19, CAST(N'2018-11-05T15:43:36.560' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (43, 23, 19, CAST(N'2018-11-05T15:43:36.563' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (44, 7, 19, CAST(N'2018-11-05T15:43:36.563' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (45, 18, 19, CAST(N'2018-11-05T15:43:36.567' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (46, 30, 19, CAST(N'2018-11-05T15:43:36.570' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (47, 31, 19, CAST(N'2018-11-05T15:43:36.570' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (48, 4, 19, CAST(N'2018-11-05T15:43:36.573' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (49, 11, 19, CAST(N'2018-11-05T15:43:36.577' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (50, 26, 19, CAST(N'2018-11-05T15:43:36.577' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (51, 32, 19, CAST(N'2018-11-05T15:43:36.580' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (52, 6, 19, CAST(N'2018-11-05T15:43:36.580' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (53, 13, 19, CAST(N'2018-11-05T15:43:36.583' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (54, 20, 19, CAST(N'2018-11-05T15:43:36.587' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1001, 35, 10018, CAST(N'2018-11-08T00:13:25.403' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1002, 11, 10018, CAST(N'2018-11-08T00:13:25.407' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1003, 35, 10019, CAST(N'2018-11-08T00:14:27.617' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1004, 26, 10019, CAST(N'2018-11-08T00:14:27.620' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1005, 35, 10020, CAST(N'2018-11-08T00:15:23.970' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1006, 26, 10020, CAST(N'2018-11-08T00:15:23.973' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1007, 4, 10021, CAST(N'2018-11-08T00:18:09.260' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1008, 4, 10022, CAST(N'2018-11-08T00:18:36.310' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1009, 38, 10023, CAST(N'2018-11-09T00:53:39.923' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1010, 38, 10024, CAST(N'2018-11-09T00:54:27.043' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1011, 38, 10025, CAST(N'2018-11-09T00:55:38.800' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1012, 6, 10026, CAST(N'2018-11-09T00:56:22.207' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1013, 19, 10027, CAST(N'2018-11-09T00:57:00.720' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1014, 19, 10028, CAST(N'2018-11-09T00:59:07.693' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1015, 35, 10029, CAST(N'2018-11-09T00:59:39.857' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1016, 9, 10029, CAST(N'2018-11-09T00:59:39.860' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1017, 33, 10029, CAST(N'2018-11-09T00:59:39.863' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1018, 28, 10029, CAST(N'2018-11-09T00:59:39.863' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1019, 52, 10029, CAST(N'2018-11-09T00:59:39.867' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1020, 51, 10029, CAST(N'2018-11-09T00:59:39.870' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1021, 21, 10029, CAST(N'2018-11-09T00:59:39.870' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1022, 37, 10029, CAST(N'2018-11-09T00:59:39.873' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1023, 1, 10029, CAST(N'2018-11-09T00:59:39.873' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1024, 3, 10029, CAST(N'2018-11-09T00:59:39.877' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1025, 53, 10029, CAST(N'2018-11-09T00:59:39.880' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1026, 49, 10029, CAST(N'2018-11-09T00:59:39.883' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1027, 46, 10029, CAST(N'2018-11-09T00:59:39.890' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1028, 16, 10029, CAST(N'2018-11-09T00:59:39.890' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1029, 48, 10029, CAST(N'2018-11-09T00:59:39.893' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1030, 27, 10029, CAST(N'2018-11-09T00:59:39.893' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1031, 38, 10029, CAST(N'2018-11-09T00:59:39.897' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1032, 25, 10029, CAST(N'2018-11-09T00:59:39.900' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1033, 15, 10029, CAST(N'2018-11-09T00:59:39.900' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1034, 22, 10029, CAST(N'2018-11-09T00:59:39.903' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1035, 19, 10029, CAST(N'2018-11-09T00:59:39.903' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1036, 44, 10029, CAST(N'2018-11-09T00:59:39.907' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1037, 42, 10029, CAST(N'2018-11-09T00:59:39.910' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1038, 41, 10029, CAST(N'2018-11-09T00:59:39.913' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1039, 36, 10029, CAST(N'2018-11-09T00:59:39.917' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1040, 5, 10029, CAST(N'2018-11-09T00:59:39.920' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1041, 50, 10029, CAST(N'2018-11-09T00:59:39.920' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1042, 43, 10029, CAST(N'2018-11-09T00:59:39.923' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1043, 10, 10029, CAST(N'2018-11-09T00:59:39.927' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1044, 39, 10029, CAST(N'2018-11-09T00:59:39.930' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1045, 14, 10029, CAST(N'2018-11-09T00:59:39.933' AS DateTime))
GO
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1046, 2, 10029, CAST(N'2018-11-09T00:59:39.933' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1047, 47, 10029, CAST(N'2018-11-09T00:59:39.937' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1048, 8, 10029, CAST(N'2018-11-09T00:59:39.940' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1049, 40, 10029, CAST(N'2018-11-09T00:59:39.940' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1050, 12, 10029, CAST(N'2018-11-09T00:59:39.943' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1051, 45, 10029, CAST(N'2018-11-09T00:59:39.943' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1052, 34, 10029, CAST(N'2018-11-09T00:59:39.947' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1053, 29, 10029, CAST(N'2018-11-09T00:59:39.950' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1054, 17, 10029, CAST(N'2018-11-09T00:59:39.950' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1055, 24, 10029, CAST(N'2018-11-09T00:59:39.953' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1056, 23, 10029, CAST(N'2018-11-09T00:59:39.953' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1057, 7, 10029, CAST(N'2018-11-09T00:59:39.957' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1058, 18, 10029, CAST(N'2018-11-09T00:59:39.960' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1059, 30, 10029, CAST(N'2018-11-09T00:59:39.960' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1060, 31, 10029, CAST(N'2018-11-09T00:59:39.963' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1061, 4, 10029, CAST(N'2018-11-09T00:59:39.963' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1062, 11, 10029, CAST(N'2018-11-09T00:59:39.967' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1063, 26, 10029, CAST(N'2018-11-09T00:59:39.970' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1064, 32, 10029, CAST(N'2018-11-09T00:59:39.973' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1065, 6, 10029, CAST(N'2018-11-09T00:59:39.973' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1066, 13, 10029, CAST(N'2018-11-09T00:59:39.977' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1067, 20, 10029, CAST(N'2018-11-09T00:59:39.980' AS DateTime))
INSERT [seguridad].[RELUSERDEP] ([idrel], [iddep], [iAppID], [fecha]) VALUES (1068, 53, 10030, CAST(N'2018-11-09T01:00:04.573' AS DateTime))
SET IDENTITY_INSERT [seguridad].[RELUSERDEP] OFF
SET IDENTITY_INSERT [seguridad].[ROL] ON 

INSERT [seguridad].[ROL] ([IDROL], [ROL], [DESCRIPCION]) VALUES (1, N'Administrador', N'Administrador del sistema')
INSERT [seguridad].[ROL] ([IDROL], [ROL], [DESCRIPCION]) VALUES (2, N'Supervisor', N'Supervisor del sistema')
INSERT [seguridad].[ROL] ([IDROL], [ROL], [DESCRIPCION]) VALUES (3, N'Operador Dependencia', N'Operación por dependencia')
INSERT [seguridad].[ROL] ([IDROL], [ROL], [DESCRIPCION]) VALUES (4, N'Operador Recepción', N'Operador de la recepción')
INSERT [seguridad].[ROL] ([IDROL], [ROL], [DESCRIPCION]) VALUES (5, N'Alcalde', N'Consulta de toma de decisiones')
INSERT [seguridad].[ROL] ([IDROL], [ROL], [DESCRIPCION]) VALUES (6, N'Operador Calidad', N'Operador de calidad')
INSERT [seguridad].[ROL] ([IDROL], [ROL], [DESCRIPCION]) VALUES (7, N'Audiencia', N'Control de audiencias')
SET IDENTITY_INSERT [seguridad].[ROL] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Dependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Dependencia] ON [dbo].[Dependencia]
(
	[Dependencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Estado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Estado] ON [dbo].[Estado]
(
	[Estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Localidad]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Localidad] ON [dbo].[Localidad]
(
	[Localidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Seguimiento]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Seguimiento] ON [dbo].[Seguimiento]
(
	[IdSolicitudEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Servicio]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Servicio] ON [dbo].[Servicio]
(
	[Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ServicioRealizado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ServicioRealizado] ON [dbo].[ServicioRealizado]
(
	[IdSolicitudEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SolicitudEstado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_SolicitudEstado] ON [dbo].[SolicitudEstado]
(
	[IdSolicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK__SEGURIDA__64890E4F32CB82C6]    Script Date: 25/12/2018 12:41:27 p. m. ******/
ALTER TABLE [seguridad].[MODULO] ADD  CONSTRAINT [PK__SEGURIDA__64890E4F32CB82C6] PRIMARY KEY NONCLUSTERED 
(
	[IDMODULO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [audiencia].[AudienciaTemp] ADD  CONSTRAINT [DF_AudienciaTemp_fechaHora]  DEFAULT (getdate()) FOR [fechaHora]
GO
ALTER TABLE [dbo].[Ciudadano] ADD  CONSTRAINT [DF_Ciudadano_Sexo]  DEFAULT (0) FOR [Sexo]
GO
ALTER TABLE [dbo].[Colonia] ADD  CONSTRAINT [DF_Colonia_Ejido]  DEFAULT ((0)) FOR [IdLocalidad]
GO
ALTER TABLE [dbo].[Dependencia] ADD  CONSTRAINT [DF_Dependencia_esOP]  DEFAULT ((1)) FOR [esOP]
GO
ALTER TABLE [dbo].[Dependencia] ADD  CONSTRAINT [DF_Dependencia_idTiempo]  DEFAULT ((0)) FOR [idTiempo]
GO
ALTER TABLE [dbo].[ServicioRealizado] ADD  CONSTRAINT [DF_ServicioRealizado_Fecha]  DEFAULT (getdate()) FOR [FechaRealizacion]
GO
ALTER TABLE [dbo].[Solicitud] ADD  CONSTRAINT [DF_Solicitud_prioritario]  DEFAULT ((0)) FOR [prioritario]
GO
ALTER TABLE [dbo].[SolicitudEstado] ADD  CONSTRAINT [DF_SolicitudEstado_FechaHora]  DEFAULT (getdate()) FOR [FechaHora]
GO
ALTER TABLE [dbo].[SolicitudTemp] ADD  CONSTRAINT [DF_SolicitudTemp_FechaHora]  DEFAULT (getdate()) FOR [FechaHora]
GO
ALTER TABLE [dbo].[SolicitudTemp] ADD  CONSTRAINT [DF_SolicitudTemp_Eliminado]  DEFAULT (0) FOR [Eliminado]
GO
ALTER TABLE [dbo].[SolicitudTempMovil] ADD  CONSTRAINT [DF_SolicitudTempMovil_fechahora]  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[SolicitudTempMovil] ADD  CONSTRAINT [DF_SolicitudTempMovil_eliminado]  DEFAULT ((0)) FOR [eliminado]
GO
ALTER TABLE [dbo].[SolicitudTempMovil] ADD  CONSTRAINT [DF_SolicitudTempMovil_fechaNac]  DEFAULT (getdate()) FOR [fechaNac]
GO
ALTER TABLE [seguridad].[esAppWebUsuario] ADD  CONSTRAINT [DF_esAppWebUsuario_iAppAudiencia]  DEFAULT ((0)) FOR [iAppAudiencia]
GO
ALTER TABLE [seguridad].[esAppWebUsuario] ADD  CONSTRAINT [DF_esAppWebUsuario_iAppActivo]  DEFAULT ((1)) FOR [iAppActivo]
GO
ALTER TABLE [seguridad].[MODULO] ADD  CONSTRAINT [DF_MODULO_ACTIVO]  DEFAULT ((1)) FOR [ACTIVO]
GO
ALTER TABLE [seguridad].[PAGINA] ADD  CONSTRAINT [DF_PAGINA_ACTIVO]  DEFAULT ((1)) FOR [ACTIVO]
GO
ALTER TABLE [seguridad].[RELUSERDEP] ADD  CONSTRAINT [DF_REL_USUARIO_DEPENDENCIA_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[Ciudadano]  WITH NOCHECK ADD  CONSTRAINT [FK_Ciudadano_Colonia] FOREIGN KEY([IdColonia])
REFERENCES [dbo].[Colonia] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ciudadano] CHECK CONSTRAINT [FK_Ciudadano_Colonia]
GO
ALTER TABLE [dbo].[Colonia]  WITH CHECK ADD  CONSTRAINT [FK_Colonia_Localidad] FOREIGN KEY([IdLocalidad])
REFERENCES [dbo].[Localidad] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Colonia] CHECK CONSTRAINT [FK_Colonia_Localidad]
GO
ALTER TABLE [dbo].[Dependencia]  WITH CHECK ADD  CONSTRAINT [FK_Dependencia_TiempoRespuesta] FOREIGN KEY([idTiempo])
REFERENCES [dbo].[TiempoRespuesta] ([idTiempo])
GO
ALTER TABLE [dbo].[Dependencia] CHECK CONSTRAINT [FK_Dependencia_TiempoRespuesta]
GO
ALTER TABLE [dbo].[MovilAlertas]  WITH CHECK ADD  CONSTRAINT [FK_MovilAlertas_MovilCategoria] FOREIGN KEY([fk_id_categoria])
REFERENCES [dbo].[MovilCategoria] ([id])
GO
ALTER TABLE [dbo].[MovilAlertas] CHECK CONSTRAINT [FK_MovilAlertas_MovilCategoria]
GO
ALTER TABLE [dbo].[MovilAlertas]  WITH CHECK ADD  CONSTRAINT [FK_MovilAlertas_MovilCiudadano] FOREIGN KEY([fk_id_ciudadano])
REFERENCES [dbo].[MovilCiudadano] ([id])
GO
ALTER TABLE [dbo].[MovilAlertas] CHECK CONSTRAINT [FK_MovilAlertas_MovilCiudadano]
GO
ALTER TABLE [dbo].[MovilCiudadano]  WITH CHECK ADD  CONSTRAINT [FK_MovilCiudadano_MovilRol] FOREIGN KEY([fk_id_rol])
REFERENCES [dbo].[MovilRol] ([id_rol])
GO
ALTER TABLE [dbo].[MovilCiudadano] CHECK CONSTRAINT [FK_MovilCiudadano_MovilRol]
GO
ALTER TABLE [dbo].[MovilComentario]  WITH CHECK ADD  CONSTRAINT [FK_MovilComentario_MovilAlertas] FOREIGN KEY([fk_id_alerta])
REFERENCES [dbo].[MovilAlertas] ([id_alerta])
GO
ALTER TABLE [dbo].[MovilComentario] CHECK CONSTRAINT [FK_MovilComentario_MovilAlertas]
GO
ALTER TABLE [dbo].[MovilComentario]  WITH CHECK ADD  CONSTRAINT [FK_MovilComentario_MovilCiudadano] FOREIGN KEY([fk_id_ciudadano])
REFERENCES [dbo].[MovilCiudadano] ([id])
GO
ALTER TABLE [dbo].[MovilComentario] CHECK CONSTRAINT [FK_MovilComentario_MovilCiudadano]
GO
ALTER TABLE [dbo].[MovilSolicitud_Temp]  WITH CHECK ADD  CONSTRAINT [FK_MovilSolicitud_Temp_MovilCiudadano] FOREIGN KEY([fk_id_ciudadano])
REFERENCES [dbo].[MovilCiudadano] ([id])
GO
ALTER TABLE [dbo].[MovilSolicitud_Temp] CHECK CONSTRAINT [FK_MovilSolicitud_Temp_MovilCiudadano]
GO
ALTER TABLE [dbo].[MovilTiene_reaccion]  WITH CHECK ADD  CONSTRAINT [FK_MovilTiene_reaccion_MovilAlertas] FOREIGN KEY([fk_id_alerta])
REFERENCES [dbo].[MovilAlertas] ([id_alerta])
GO
ALTER TABLE [dbo].[MovilTiene_reaccion] CHECK CONSTRAINT [FK_MovilTiene_reaccion_MovilAlertas]
GO
ALTER TABLE [dbo].[MovilTiene_reaccion]  WITH CHECK ADD  CONSTRAINT [FK_MovilTiene_reaccion_MovilCiudadano] FOREIGN KEY([fk_id_ciudadano])
REFERENCES [dbo].[MovilCiudadano] ([id])
GO
ALTER TABLE [dbo].[MovilTiene_reaccion] CHECK CONSTRAINT [FK_MovilTiene_reaccion_MovilCiudadano]
GO
ALTER TABLE [dbo].[MovilTiene_reaccion]  WITH CHECK ADD  CONSTRAINT [FK_MovilTiene_reaccion_MovilReaccion] FOREIGN KEY([fk_id_reaccion])
REFERENCES [dbo].[MovilReaccion] ([id])
GO
ALTER TABLE [dbo].[MovilTiene_reaccion] CHECK CONSTRAINT [FK_MovilTiene_reaccion_MovilReaccion]
GO
ALTER TABLE [dbo].[RelSolCiud]  WITH NOCHECK ADD  CONSTRAINT [FK_RelSolCiud_Ciudadano] FOREIGN KEY([IdCiudadano])
REFERENCES [dbo].[Ciudadano] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RelSolCiud] CHECK CONSTRAINT [FK_RelSolCiud_Ciudadano]
GO
ALTER TABLE [dbo].[RelSolCiud]  WITH CHECK ADD  CONSTRAINT [FK_RelSolCiud_Solicitud] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitud] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RelSolCiud] CHECK CONSTRAINT [FK_RelSolCiud_Solicitud]
GO
ALTER TABLE [dbo].[SectorColonia]  WITH CHECK ADD  CONSTRAINT [FK_SectorColonia_Colonia] FOREIGN KEY([IdColonia])
REFERENCES [dbo].[Colonia] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SectorColonia] CHECK CONSTRAINT [FK_SectorColonia_Colonia]
GO
ALTER TABLE [dbo].[SectorColonia]  WITH CHECK ADD  CONSTRAINT [FK_SectorColonia_Sector] FOREIGN KEY([IdSector])
REFERENCES [dbo].[Sector] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SectorColonia] CHECK CONSTRAINT [FK_SectorColonia_Sector]
GO
ALTER TABLE [dbo].[Seguimiento]  WITH CHECK ADD  CONSTRAINT [FK_Seguimiento_SolicitudEstado] FOREIGN KEY([IdSolicitudEstado])
REFERENCES [dbo].[SolicitudEstado] ([IdSolicitudEstado])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Seguimiento] CHECK CONSTRAINT [FK_Seguimiento_SolicitudEstado]
GO
ALTER TABLE [dbo].[Servicio]  WITH NOCHECK ADD  CONSTRAINT [FK_Servicio_Dependencia] FOREIGN KEY([IdDependencia])
REFERENCES [dbo].[Dependencia] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Servicio] CHECK CONSTRAINT [FK_Servicio_Dependencia]
GO
ALTER TABLE [dbo].[ServicioRealizado]  WITH CHECK ADD  CONSTRAINT [FK_ServicioRealizado_SolicitudEstado] FOREIGN KEY([IdSolicitudEstado])
REFERENCES [dbo].[SolicitudEstado] ([IdSolicitudEstado])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServicioRealizado] CHECK CONSTRAINT [FK_ServicioRealizado_SolicitudEstado]
GO
ALTER TABLE [dbo].[Solicitud]  WITH CHECK ADD  CONSTRAINT [FK_Solicitud_Colonia] FOREIGN KEY([IdColonia])
REFERENCES [dbo].[Colonia] ([Id])
GO
ALTER TABLE [dbo].[Solicitud] CHECK CONSTRAINT [FK_Solicitud_Colonia]
GO
ALTER TABLE [dbo].[Solicitud]  WITH CHECK ADD  CONSTRAINT [FK_Solicitud_FormaContacto] FOREIGN KEY([idformacontacto])
REFERENCES [dbo].[FormaContacto] ([idformacontacto])
GO
ALTER TABLE [dbo].[Solicitud] CHECK CONSTRAINT [FK_Solicitud_FormaContacto]
GO
ALTER TABLE [dbo].[Solicitud]  WITH NOCHECK ADD  CONSTRAINT [FK_Solicitud_Servicio] FOREIGN KEY([IdServicio])
REFERENCES [dbo].[Servicio] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Solicitud] CHECK CONSTRAINT [FK_Solicitud_Servicio]
GO
ALTER TABLE [dbo].[SolicitudEstado]  WITH NOCHECK ADD  CONSTRAINT [FK_SolicitudEstado_Estado] FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estado] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SolicitudEstado] CHECK CONSTRAINT [FK_SolicitudEstado_Estado]
GO
ALTER TABLE [dbo].[SolicitudEstado]  WITH CHECK ADD  CONSTRAINT [FK_SolicitudEstado_Solicitud] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitud] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[SolicitudEstado] CHECK CONSTRAINT [FK_SolicitudEstado_Solicitud]
GO
ALTER TABLE [seguridad].[esAppRoles]  WITH NOCHECK ADD  CONSTRAINT [FK__esAppRole__iAppI__1FCDBCEB] FOREIGN KEY([iAppID])
REFERENCES [seguridad].[esApps] ([iAppID])
GO
ALTER TABLE [seguridad].[esAppRoles] CHECK CONSTRAINT [FK__esAppRole__iAppI__1FCDBCEB]
GO
ALTER TABLE [seguridad].[esAppWebUsuario]  WITH CHECK ADD  CONSTRAINT [FK_esAppWebUsuario_ROL] FOREIGN KEY([IDROL])
REFERENCES [seguridad].[ROL] ([IDROL])
GO
ALTER TABLE [seguridad].[esAppWebUsuario] CHECK CONSTRAINT [FK_esAppWebUsuario_ROL]
GO
ALTER TABLE [seguridad].[esDetallesUsers]  WITH CHECK ADD  CONSTRAINT [FK_esDetallesUsers_esAppWebUsuario] FOREIGN KEY([iAppID])
REFERENCES [seguridad].[esAppWebUsuario] ([iAppID])
GO
ALTER TABLE [seguridad].[esDetallesUsers] CHECK CONSTRAINT [FK_esDetallesUsers_esAppWebUsuario]
GO
ALTER TABLE [seguridad].[PAGINA]  WITH CHECK ADD  CONSTRAINT [FK_PAGINA_MODULO] FOREIGN KEY([IDMODULO])
REFERENCES [seguridad].[MODULO] ([IDMODULO])
GO
ALTER TABLE [seguridad].[PAGINA] CHECK CONSTRAINT [FK_PAGINA_MODULO]
GO
ALTER TABLE [seguridad].[PERMISOROL]  WITH CHECK ADD  CONSTRAINT [FK_PERMISOROL_MODULO] FOREIGN KEY([IDMODULO])
REFERENCES [seguridad].[MODULO] ([IDMODULO])
GO
ALTER TABLE [seguridad].[PERMISOROL] CHECK CONSTRAINT [FK_PERMISOROL_MODULO]
GO
ALTER TABLE [seguridad].[PERMISOROL]  WITH CHECK ADD  CONSTRAINT [FK_PERMISOROL_PAGINA] FOREIGN KEY([IDPAGINA])
REFERENCES [seguridad].[PAGINA] ([IDPAGINA])
GO
ALTER TABLE [seguridad].[PERMISOROL] CHECK CONSTRAINT [FK_PERMISOROL_PAGINA]
GO
ALTER TABLE [seguridad].[PERMISOROL]  WITH CHECK ADD  CONSTRAINT [FK_PERMISOROL_ROL] FOREIGN KEY([IDROL])
REFERENCES [seguridad].[ROL] ([IDROL])
GO
ALTER TABLE [seguridad].[PERMISOROL] CHECK CONSTRAINT [FK_PERMISOROL_ROL]
GO
ALTER TABLE [seguridad].[RELUSERDEP]  WITH CHECK ADD  CONSTRAINT [FK_REL_USUARIO_DEPENDENCIA_Dependencia] FOREIGN KEY([iddep])
REFERENCES [dbo].[Dependencia] ([Id])
GO
ALTER TABLE [seguridad].[RELUSERDEP] CHECK CONSTRAINT [FK_REL_USUARIO_DEPENDENCIA_Dependencia]
GO
ALTER TABLE [seguridad].[RELUSERDEP]  WITH CHECK ADD  CONSTRAINT [FK_REL_USUARIO_DEPENDENCIA_esAppWebUsuario] FOREIGN KEY([iAppID])
REFERENCES [seguridad].[esAppWebUsuario] ([iAppID])
GO
ALTER TABLE [seguridad].[RELUSERDEP] CHECK CONSTRAINT [FK_REL_USUARIO_DEPENDENCIA_esAppWebUsuario]
GO
/****** Object:  StoredProcedure [audiencia].[audienciaByDia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [audiencia].[audienciaByDia]
(@f1 varchar(15),@f2 varchar(15))
AS

SELECT  
	a.idAudiencia, 
	a.nombre + ' ' + a.apellidoPaterno + ' ' + a.apellidoMaterno as Nombre, 
	 l.localidad, c.Colonia,a.direccion,	
	a.telefono,	a.peticion
FROM   audiencia.AudienciaTemp a
inner join dbo.Localidad l on l.Id=a.idLocalidad
inner join dbo.Colonia c on c.id=a.idColonia
WHERE (CAST(fechaHora as date) >= CAST(@f1 AS DATE))
and
(CAST(fechaHora as date) <= CAST(@f2 AS DATE)) 


--exec dbo.audienciaByDia '11/10/2018','11/10/2018'
GO
/****** Object:  StoredProcedure [audiencia].[proc_addAudiencia_Temporal]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [audiencia].[proc_addAudiencia_Temporal]
	(		
		@idAudiencia bigint=0  OUTPUT,
		@nombre varchar(50)='',
		@apellidoPaterno varchar (50) = '',
		@apellidoMaterno varchar (50)='',
		@direccion varchar(70)='',
		@idLocalidad smallint=0,
		@idColonia int=0,		
		@telefono varchar (30)=null,		
		@CorreoElectronico varchar(60)=null,
		@peticion varchar(1024)=''

	)
AS
	SET NOCOUNT ON 		
	INSERT INTO audiencia.AudienciaTemp (
		nombre
		,apellidoPaterno
		,apellidoMaterno
		,direccion
		,idLocalidad
		,idColonia
		,telefono
		,correoElectronico
		,peticion
		,fechaHora)
	VALUES (@nombre, @apellidoPaterno, @apellidoMaterno, @direccion, @idLocalidad, @idColonia, 
		@telefono,  @CorreoElectronico, @peticion,  GETDATE())

	SET @idAudiencia=@@IDENTITY 



GO
/****** Object:  StoredProcedure [audiencia].[proc_getAudiencia_Temporal]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [audiencia].[proc_getAudiencia_Temporal]
	(		
		@idAudiencia bigint
	)
AS
	SET NOCOUNT ON 		
	SELECT idAudiencia, nombre, apellidoPaterno, apellidoMaterno, direccion, idLocalidad, idColonia, telefono, correoElectronico, peticion, fechaHora
FROM   audiencia.AudienciaTemp
where idAudiencia=@idAudiencia
GO
/****** Object:  StoredProcedure [dbo].[AddAppWeb]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddAppWeb]
	(
		@iAppID int,
		@sAppName varchar(255),
		@sDesc varchar (1024),
		@sURL varchar (1024)
	)
AS
	SET NOCOUNT ON
	DECLARE 
		@AID int,
		@AN int,
		@Lnk int
--Comprobar que no existan los elementos
	SELECT @AID=COUNT(iAppID) FROM esApps WHERE iAppID=@iAppID
	SELECT @AN=COUNT(sAppName) FROM esApps WHERE sAppName=@sAppName
	SELECT @Lnk=COUNT(sURL) FROM esApps WHERE sURL=@sURL
	IF @AID=0 AND @AN=0 AND @Lnk=0
		BEGIN
			   INSERT INTO esApps( iAppID,sAppName, sDesc, sURL) 
					VALUES( @iAppID, @sAppName, @sDesc, @sURL) 		
		END
RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AddRolesToAppWeb]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[AddRolesToAppWeb]
	(
		@sAppName varchar(255),
		@sRole varchar(50)
	)
AS
	SET NOCOUNT ON 
	
	DECLARE
		@RID INTEGER,
		@AID INTEGER

	SET @AID = dbo.GetAppIdByName(@sAppName)
	SET @RID =dbo.IsRoleInApp(@sAppName, @sRole)
	IF @AID>0 AND @RID=0 
		BEGIN
			INSERT INTO esAppRoles ( iAppID,sRole) 
				VALUES( @AID,@sRole)
		END
RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppGetCiudadano]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[AppGetCiudadano]
	(
		@idCiudadano int
	)
AS
	BEGIN	
		SET NOCOUNT ON 		
		SELECT Ciudadano.Id, Nombre ,  ApellidoP,  ApellidoM, Direccion, NumeroExt, Colonia, Localidad, Sexo, CorreoE, Telefono, TelefonoAlt, Asociacion, Ciudadano.fechaNac
		FROM Localidad INNER JOIN Colonia ON Localidad.Id = Colonia.IdLocalidad
		INNER JOIN Ciudadano ON Ciudadano.IdColonia = Colonia.Id
		WHERE Ciudadano.Id=@idCiudadano
	END
GO
/****** Object:  StoredProcedure [dbo].[AppGetLista]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AppGetLista]	
AS
	BEGIN		
		SELECT     esUsers.sLoginID as Login, esDetallesUsers.sNombre as Nombre, esDetallesUsers.sApellido as Apellido,esDetallesUsers.sDependencia as Dependencia
		FROM         esUsers INNER JOIN
		                      esDetallesUsers ON esUsers.iUserID = esDetallesUsers.iUserID		
	END
GO
/****** Object:  StoredProcedure [dbo].[AppGetUserByID]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[AppGetUserByID]
(
	@idUser int
)
AS
	BEGIN		
SELECT sNombre + ' '+ sApellido  as captura, sRole as rol
FROM esDetallesUsers
INNER JOIN esUsers ON esDetallesUsers.iUserID=esUsers.iUserID
INNER JOIN esAppUserRoles ON esUsers.iUserID = esAppUserRoles.iUserID
INNER JOIN esAppRoles ON esAppUserRoles.iAppRoleID = esAppRoles.iAppRoleID
INNER JOIN esApps ON esAppRoles.iAppID = esApps.iAppID
WHERE esDetallesUsers.iUserID = @idUser  and sAppName='SIRC'
	END
GO
/****** Object:  StoredProcedure [dbo].[AppIsSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[AppIsSolicitud]
	(
		@SolicitudID int
	)
AS
	BEGIN		
		SELECT Count(id)
		FROM 	Solicitud 
		WHERE id=@SolicitudID
		IF (@@ROWCOUNT>0)
			RETURN 1
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[AppSolicitudGetComentarios]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[AppSolicitudGetComentarios]
	(
		@SolicitudID int
	)
AS
	BEGIN	
		SET LANGUAGE Español	
		SELECT Estado.Estado,Estado.Descripcion, cast(SolicitudEstado.FechaHora as varchar(50)) as FechaHora, (select comentario from seguimiento where SolicitudEstado.IDSolicitudEstado= Seguimiento.IdSolicitudEstado)AS Comentario, idCaptura
		FROM Solicitud
		INNER JOIN SolicitudEstado
		ON Solicitud.id=SolicitudEstado.IdSolicitud
		INNER JOIN Estado
		ON SolicitudEstado.IdEstado=Estado.id
		WHERE Solicitud.id=@SolicitudID
	END

GO
/****** Object:  StoredProcedure [dbo].[AppSolicitudGetConfirmado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[AppSolicitudGetConfirmado]
	(
		@SolicitudID int
	)
AS
	BEGIN		
		SELECT SolicitudEstado.FechaHora, ServicioRealizado.FechaRealizacion,ServicioRealizado.Encargado, ServicioRealizado.Solucion
		FROM Solicitud
		INNER JOIN SolicitudEstado
		ON Solicitud.id=SolicitudEstado.IdSolicitud
		INNER JOIN ServicioRealizado
		ON SolicitudEstado.IDSolicitudEstado= ServicioRealizado.IdSolicitudEstado
		INNER JOIN Estado
		ON SolicitudEstado.IdEstado=Estado.id
		WHERE Solicitud.id=@SolicitudID
		AND Estado.Estado='Realizado' 
	END
GO
/****** Object:  StoredProcedure [dbo].[AppSolicitudGetEntrante]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AppSolicitudGetEntrante]
	(
		@SolicitudID int
	)
AS
	BEGIN		
		SET NOCOUNT ON
		SELECT distinct (SolicitudTemp.Id), Nombre, ApellidoP, ApellidoM, Direccion, NumeroExt, NumeroInt,
		(select Localidad.Localidad from Localidad inner join Colonia on localidad.id = colonia.idLocalidad where Colonia.id = SolicitudTemp.IdColonia)as LocalidadCiud, 
		(select Colonia.Colonia from Colonia where Colonia.id = SolicitudTemp.IdColonia) as ColoniaCiud, 
		Sexo, CorreoE, CorreoEAlt, Asociacion, Edad, Telefono, TelefonoAlt,
		Descripcion,
		(select Localidad.Localidad from Localidad inner join Colonia on localidad.id = colonia.idLocalidad where Colonia.id = SolicitudTemp.IdCol)as LocalidadRep,
		(select Colonia.Colonia from Colonia WHERE Colonia.id = SolicitudTemp.IdCol)as ColoniaRep,
		Calle, Ref1, Ref2, FechaHora
		FROM SolicitudTemp, Colonia, Localidad
		WHERE SolicitudTemp.id=@SolicitudID
	END
GO
/****** Object:  StoredProcedure [dbo].[AppSolicitudGetLastEstado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[AppSolicitudGetLastEstado]
	(
		@SolicitudID int
	)
AS
	BEGIN		
		SELECT FechaHora, EstadoCiudadano, Estado
		FROM SolicitudEstado 
		INNER JOIN Estado
		ON SolicitudEstado.idEstado=Estado.Id
		WHERE SolicitudEstado.IdSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(@SolicitudID)
	END
GO
/****** Object:  StoredProcedure [dbo].[AppSolicitudGetOriginal]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[AppSolicitudGetOriginal]
	(
		@SolicitudID int
	)
AS
	BEGIN		
		SET NOCOUNT ON
		SELECT SolicitudEstado.FechaHora, Servicio.Servicio, Dependencia.Dependencia, Solicitud.Descripcion, SolicitudEstado.IdCaptura, Solicitud.Calle, Solicitud.Ref1, Solicitud.Ref2, Localidad, Colonia, Dependencia.EsOP
		FROM 
		Localidad INNER JOIN Colonia
		ON Localidad.Id = Colonia.IdLocalidad
		INNER JOIN Solicitud
		ON Colonia.Id=Solicitud.IdColonia
		INNER JOIN SolicitudEstado
		ON Solicitud.id=SolicitudEstado.idSolicitud
		INNER JOIN Servicio
		ON Servicio.id=Solicitud.idServicio
		INNER JOIN Dependencia
		ON Servicio.IdDependencia=Dependencia.id
		WHERE SolicitudEstado.IdSolicitudEstado=dbo.GetFirstSolicitudEstadoByIdSolicitud(@SolicitudID)
	END
GO
/****** Object:  StoredProcedure [dbo].[AppSolicitudIsRealizado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[AppSolicitudIsRealizado]
	(
		@SolicitudID int
	)
AS
	BEGIN		
		SELECT Count(Solicitud.id)
		FROM Solicitud
		INNER JOIN SolicitudEstado
		ON Solicitud.id=SolicitudEstado.IdSolicitud
		INNER JOIN ServicioRealizado
		ON SolicitudEstado.IDSolicitudEstado= ServicioRealizado.IdSolicitudEstado
		INNER JOIN Estado
		ON SolicitudEstado.IdEstado=Estado.id
		WHERE Solicitud.id=@SolicitudID
		AND Estado.Estado='Realizado' --OR Estado.IdEdoCiudadano=6
	END
GO
/****** Object:  StoredProcedure [dbo].[AppUserAdd]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Añade a un usuario a una aplicacion especificada
CREATE PROCEDURE  [dbo].[AppUserAdd]
	(
		@User varchar(255),	
		@AppId int
	)
AS
	SET NOCOUNT ON 
	
	DECLARE 
		@UID int		
	
	SET @UID =dbo.GetUserIDByLoginID(@User)
	IF (@UID>0) --el usuario existe en el sistema
		IF (dbo.IsUserIdInAppId(@UID,@AppId )=0)--si el usuario no existe en la app
			BEGIN
				INSERT INTO esAppsUsers ( iAppID,iUserID) --añadirlo a la app
					VALUES( @AppId,@UID)
			END	
RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppUserAddRoles]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Añade un nuevo rol al usuario en la aplicacion especificada
--el rol debe de existir en la base de datos
CREATE PROCEDURE  [dbo].[AppUserAddRoles]
	(
		@LoginID varchar(255),
		@AppId int,
		@RoleName varchar (50)
	)
AS
	SET NOCOUNT ON 	
	DECLARE 				          
		@UID INTEGER,
		@RID int,
		@AID int, 
		@XCount int
--Comprobamos que los datos existan en realidad
--Los valores devueltos son mayores a 0 en caso correcto
	SET @UID = dbo.GetUserIDByLoginID(@LoginID)
	SET @AID= dbo.ValidateAppId(@AppId)
	SET @RID = dbo.IsRoleInAppId(@RoleName, @AppId)
	IF (@AppId>0 AND @UID >0 AND @RID>0)	
	BEGIN
		SET @XCount=dbo.IsRoleInAppIdAndUserId(@RoleName, @AppId, @UID)
		IF (@XCount=0)	--Si no ha sido ya agregado el rol antes agregarlo
			BEGIN
			INSERT INTO esAppUserRoles ( iAppID, iAppRoleID,iUserID ) 
				VALUES( @AppId, dbo.GetRoleIdByRoleNameAndAppId(@RoleName,@AID), @UID)
			END
		ELSE 
			BEGIN								
				 UPDATE esAppUserRoles SET iAppID=@AppId, iAppRoleID=dbo.GetRoleIdByRoleNameAndAppId(@RoleName,@AID), iUserID=@UID			
					WHERE iAppID=@AppId AND iUserID=@UID
				
			END
	END

RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppUserAll]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--Añade a un usuario a una aplicacion especificada
CREATE PROCEDURE  [dbo].[AppUserAll]
(
	@cuantos int OUTPUT
)
AS

SET NOCOUNT ON 			
	select *
	from esusers 
	LEFT  JOIN esdetallesusers
	on esusers.iuserid=esdetallesusers.iuserid		

SET @cuantos=@@ROWCOUNT
RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppUserChangePassword]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[AppUserChangePassword]
	(
		@Name varchar(256),
		@NewPassword char(128)
	)
AS
	SET NOCOUNT ON 			
	DECLARE @UID int

	SET @UID= dbo.GetUserIDByLoginID(@Name)
	IF (@UID>0)
		BEGIN
		   UPDATE  esUsers SET sPassword=@NewPassword  WHERE iUserID= @UID
		END
RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppUserDelete]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--Elimina al usuario de la aplicacion especificada
CREATE PROCEDURE [dbo].[AppUserDelete]
	(
		@LoginID varchar(255),
		@AppId int
	)
AS
	SET NOCOUNT ON 
	
	DECLARE 
		@UID INTEGER	
--Si existen (ka aplicacion y el usuario su id sera mayor a 0)
	SET @UID = dbo.GetUserIDByLoginID(@LoginID)	
	IF (@AppId>0 AND @UID >0)
		BEGIN
			DELETE FROM esAppsUsers 
					WHERE @AppId=iAppID
					AND @UID=iUserID
		END
RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppUserDeleteRoles]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[AppUserDeleteRoles]
	(
		@LoginID varchar(255),
		@AppId int,
		@RoleName varchar (50)
	)
AS
	SET NOCOUNT ON 	
	DECLARE 				          
		@UID INTEGER,		
		@RID int
--Comprobamos que los datos existan en realidad
--Los valores devueltos son mayores a 0 en caso correcto	
	SET @UID = dbo.GetUserIDByLoginID(@LoginID)
	SET @RID = dbo.IsRoleInAppId(@RoleName,@AppId)
	IF (@AppId>0 AND @UID >0 AND @RID>0)
		BEGIN
			DELETE FROM esAppUsersRoles 
				WHERE iAppID=@AppId
					AND iAppRoleID=@RID
					AND iUserID=@UID
		END
RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppUserGetDependenciaID]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[AppUserGetDependenciaID]
	(
		@iUser int 
	)
AS
	BEGIN		
		select sDependencia from esdetallesusers
		where iUserId =@iUser
	END
GO
/****** Object:  StoredProcedure [dbo].[AppUserGetLista]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[AppUserGetLista]
	(
		@appID int 
	)
AS
	BEGIN		
		SELECT esUsers.iUserID ,esUsers.sLoginID , esAppRoles.sRole 
		FROM esUsers 
		INNER JOIN esAppsUsers
		ON esUsers.iUserID=esAppsUsers.iUserID
		INNER JOIN esAppUserRoles
		ON esUsers.iUserID= esAppUserRoles.iUserID
		INNER JOIN esAppRoles
		ON esAppRoles.iAppRoleID=esAppUserRoles.iAppRoleID
		WHERE esAppsUsers.iAppID=@appID
		ORDER BY esAppRoles.sRole
	END
GO
/****** Object:  StoredProcedure [dbo].[AppUserRegister]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[AppUserRegister]
	(
		@Name varchar(256),
		@Password char(128)
	)
AS
	SET NOCOUNT ON 			
	IF (dbo.GetUserIDByLoginID(@Name)=0)
		BEGIN
		   INSERT INTO esUsers( sLoginID,sPassword) 
				VALUES( @Name,@Password) 		
		END
RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppUserSelectAll]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--Añade a un usuario a una aplicacion especificada
CREATE PROCEDURE  [dbo].[AppUserSelectAll]
(
	@iUser int 
)
AS

SET NOCOUNT ON 			
	select *
	from esusers 
	INNER JOIN esdetallesusers
	on esusers.iuserid=esdetallesusers.iuserid	
	Where esUsers.iUserId=@iUser



RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppUserUpdateConfigUserDependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[AppUserUpdateConfigUserDependencia]
	(		
		@id int=0,
		@dep int=0
	)
AS
	SET NOCOUNT ON 	
	DECLARE @ED int
		
	IF(@id >0)--si UID >0 el usuario existe y tiene un ID = UID
		BEGIN
		SELECT @ED=COUNT(*) FROM ConfigUser WHERE UserID=@id
		IF (@ED<>0)
			BEGIN
			 UPDATE ConfigUser SET					
					  IdDependencia=@dep
					WHERE UserID=@id
			END	
		ELSE	
			BEGIN
			INSERT INTO ConfigUser(UserID, IdDependencia)  
				VALUES (@id,@dep)
			END
		END
	RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppUserUpdateDetalles]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AppUserUpdateDetalles]
	(
		@User varchar(256),
		@sNombre varchar(50)='',
		@sApellido varchar (64)='',
		@iSexo int=1,
		@iEdad int=0,
		@sDireccion varchar(64)='',
		@sColonia varchar (64)='',
		@sTelefono varchar (25)='',
		@sCiudad varchar (64)='',
		@sCorreoE varchar (128)='',
		@sDependencia varchar (128)='',
		@iTurno int=0
	)
AS
	SET NOCOUNT ON 	
	DECLARE @UID int,
		@ED int

	SET @UID=dbo.GetUserIdByLoginId(@User) 
	IF(@UID >0)--si UID >0 el usuario existe y tiene un ID = UID
		BEGIN
		SELECT @ED=COUNT(*) FROM esDetallesUsers WHERE iUserID=@UID
		IF (@ED<>0)
			BEGIN
			 UPDATE esDetallesUsers SET
					 sNombre=@sNombre,sApellido=@sApellido, 
					  iSexo=@iSexo, iEdad=@iEdad, sDireccion=@sDireccion,sColonia=@sColonia, 
					  sTelefono=@sTelefono, sCiudad=@sCiudad, sCorreoE=@sCorreoE,
					  sDependencia=@sDependencia, iTurno=@iTurno
					WHERE iUserID=@UID
			END	
		ELSE	
			BEGIN
			INSERT INTO esDetallesUsers (iUserID,sNombre, sApellido, 
					  iSexo, iEdad, sDireccion,sColonia, 
					  sTelefono, sCiudad, sCorreoE,
					  sDependencia, iTurno)  
				VALUES (@UID,@sNombre, @sApellido, 
					  @iSexo, @iEdad, @sDireccion, @sColonia, 
					  @sTelefono, @sCiudad, @sCorreoE,
					  @sDependencia, @iTurno)
			END
		END
	RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[AppUserUpdateToOneRole]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--Añade un nuevo rol al usuario en la aplicacion especificada
--el rol debe de existir en la base de datos
CREATE PROCEDURE  [dbo].[AppUserUpdateToOneRole]
	(
		@LoginID varchar(255),
		@AppId int,
		@RoleName varchar (50)
	)
AS
	SET NOCOUNT ON 	
	DECLARE 				          
		@UID INTEGER,
		@RID int,
		@AID int, 
		@XCount int
--Comprobamos que los datos existan en realidad
--Los valores devueltos son mayores a 0 en caso correcto
	SET @UID = dbo.GetUserIDByLoginID(@LoginID)
	SET @AID= dbo.ValidateAppId(@AppId)
	SET @RID = dbo.IsRoleInAppId(@RoleName, @AppId)
	IF (@AppId>0 AND @UID >0 AND @RID>0)	
	BEGIN
		DELETE FROM esAppUserRoles WHERE iAppID=@AppId AND iUserID=@UID
		INSERT INTO esAppUserRoles ( iAppID, iAppRoleID,iUserID ) 
			VALUES( @AppId, dbo.GetRoleIdByRoleNameAndAppId(@RoleName,@AID), @UID)		
	END

RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[audienciaByDia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[audienciaByDia]
(@f1 varchar(15),@f2 varchar(15))
AS

SELECT  
	a.idAudiencia, 
	a.nombre + ' ' + a.apellidoPaterno + ' ' + a.apellidoMaterno as Nombre, 
	 l.localidad, c.Colonia,a.direccion,	
	a.telefono,	a.peticion
FROM   audiencia.AudienciaTemp a
inner join dbo.Localidad l on l.Id=a.idLocalidad
inner join dbo.Colonia c on c.id=a.idColonia
WHERE (CAST(fechaHora as date) >= CAST(@f1 AS DATE))
and
(CAST(fechaHora as date) <= CAST(@f2 AS DATE)) 


exec dbo.audienciaByDia '11/10/2018','11/10/2018'
GO
/****** Object:  StoredProcedure [dbo].[CambiarEstado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[CambiarEstado]
	(			
		@idSolicitud int,
		@idCaptura int,
		@NuevoEstado varchar (20)='',
		@Comentario varchar(1024)=''
	)
AS
	SET NOCOUNT ON 		
	
	DECLARE @NumSolicitudEstado int,
		@idEstado smallint
		
	IF(@NuevoEstado<>'')			
		SET @idEstado=dbo.GetEstadoIDByName(@NuevoEstado)	
	ELSE
		SET @idEstado=dbo.GetEstadoIDByName(dbo.GetLastEstadoByIdSolicitud(@idSolicitud))


	INSERT INTO SolicitudEstado (IdSolicitud, IdEstado, FechaHora, IdCaptura)
		VALUES (@idSolicitud, @idEstado, GETDATE(), @idCaptura)

	SET @NumSolicitudEstado= @@IDENTITY 

	IF (@Comentario<>'')
		BEGIN
		INSERT INTO Seguimiento (IdSolicitudEstado,Comentario)
			VALUES (@NumSolicitudEstado, @Comentario)
		END

	RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[CoincidenciasCiudadano]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[CoincidenciasCiudadano]
	(
		@Nombre varchar(30),
		@ApellidoP varchar(30),
		@ApellidoM varchar(30),
		@IdColonia smallint		
	)
AS
	BEGIN	
		SET NOCOUNT ON 
		SELECT Ciudadano.Id, Nombre + ' ' + ApellidoP + ' ' + ApellidoM as Ciudadano, Direccion, NumeroExt,  Colonia
		FROM Ciudadano INNER JOIN Colonia ON Ciudadano.IdColonia = Colonia.Id
		WHERE Nombre like @Nombre and ApellidoP like @ApellidoP and ApellidoM like @ApellidoM and IdColonia = @IdColonia
	END
GO
/****** Object:  StoredProcedure [dbo].[CoincidenciasColService]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[CoincidenciasColService]
	(
		@IdServicio smallint,
		@IdColonia smallint
	)
AS
	BEGIN	
		SET NOCOUNT ON
		SELECT     dbo.RelSolCiud.IdCiudadano, dbo.RelSolCiud.IdSolicitud, dbo.Ciudadano.ApellidoP +space(1)+dbo.Ciudadano.ApellidoM+space(1)+dbo.Ciudadano.Nombre as Ciudadano, dbo.Solicitud.Descripcion, dbo.Solicitud.IdColonia, 
                      dbo.Colonia.Id as IdColonia,dbo.Colonia.Colonia, dbo.Colonia.IdLocalidad, dbo.Localidad.Localidad, dbo.Solicitud.IdServicio, dbo.Servicio.Servicio,dbo.GetFechaCreacion(Solicitud.Id) AS FechaCreacion
					FROM         dbo.RelSolCiud INNER JOIN
                      dbo.Ciudadano ON dbo.RelSolCiud.IdCiudadano = dbo.Ciudadano.Id INNER JOIN
                      dbo.Solicitud ON dbo.RelSolCiud.IdSolicitud = dbo.Solicitud.Id INNER JOIN
                      dbo.Colonia ON dbo.Ciudadano.IdColonia = dbo.Colonia.Id AND dbo.Solicitud.IdColonia = dbo.Colonia.Id INNER JOIN
                      dbo.Localidad ON dbo.Colonia.IdLocalidad = dbo.Localidad.Id INNER JOIN
                      dbo.Servicio ON dbo.Solicitud.IdServicio = dbo.Servicio.Id
                      WHERE dbo.Colonia.Id=@IdColonia and IdServicio=@IdServicio
	END
GO
/****** Object:  StoredProcedure [dbo].[CoincidenciasReporte]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[CoincidenciasReporte]
	(
		@Calle varchar(30),
		@IdColonia smallint,
		@IdServicio smallint
	)
AS
	BEGIN	
		SET NOCOUNT ON 
		SELECT Solicitud.Id, Solicitud.Descripcion, dbo.GetFechaCreacion(Solicitud.Id) AS FechaCreacion
		FROM Solicitud INNER JOIN Servicio ON Solicitud.IdServicio = Servicio.Id
		WHERE Calle like @Calle and IdColonia=@IdColonia and IdServicio=@IdServicio
	END
GO
/****** Object:  StoredProcedure [dbo].[Consultar]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Consultar]
AS
	BEGIN		
--	SET NOCOUNT ON
	--convert, 101 mm/dd/yy, 103 dd/mm/yy --103
	SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion, Estado.Estado,  Servicio.IdDependencia,Solicitud.IdServicio, 
			Servicio.Servicio, colonia.Id,Colonia.Colonia, CONVERT(char(20), dbo.getfechacreacion(solicitud.id), 113)  as Fecha,
			DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as  'hrs'
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.Colonia
		ON solicitud.idCOlonia = Colonia.id
		INNER JOIN dbo.Servicio
		ON Solicitud.idServicio=Servicio.id
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id)		
		ORDER BY Solicitud.Id
		ASC
	END

GO
/****** Object:  StoredProcedure [dbo].[ConsultarByColonia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create PROCEDURE [dbo].[ConsultarByColonia]
	(
		@idCol smallint=null
	)
AS	
	
	BEGIN		
--	SET NOCOUNT ON
	--convert, 101 mm/dd/yy, 103 dd/mm/yy --103
	SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion, Estado.Estado,  Servicio.IdDependencia,Solicitud.IdServicio, 
			Servicio.Servicio, colonia.Id,Colonia.Colonia, CONVERT(char(20), dbo.getfechacreacion(solicitud.id), 113)  as Fecha,
			DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as  'hrs'
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.Colonia
		ON solicitud.idCOlonia = Colonia.id
		INNER JOIN dbo.Servicio
		ON Solicitud.idServicio=Servicio.id
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) and colonia.Id=@idCol 		
		ORDER BY Solicitud.Id
		ASC
	END

GO
/****** Object:  StoredProcedure [dbo].[ConsultarByDependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create PROCEDURE [dbo].[ConsultarByDependencia]
	(
		@idDep smallint=null
	)
AS	
	
	BEGIN		
--	SET NOCOUNT ON
	--convert, 101 mm/dd/yy, 103 dd/mm/yy --103
	SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion, Estado.Estado,  Servicio.IdDependencia,Solicitud.IdServicio, 
			Servicio.Servicio, colonia.Id,Colonia.Colonia, CONVERT(char(20), dbo.getfechacreacion(solicitud.id), 113)  as Fecha,
			DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as  'hrs'
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.Colonia
		ON solicitud.idCOlonia = Colonia.id
		INNER JOIN dbo.Servicio
		ON Solicitud.idServicio=Servicio.id
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) and Servicio.IdDependencia=@idDep 		
		ORDER BY Solicitud.Id
		ASC
	END

GO
/****** Object:  StoredProcedure [dbo].[ConsultarByServicio]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ConsultarByServicio]
	(
		@idServicio smallint=null
	)
AS	
	
	BEGIN		
--	SET NOCOUNT ON
	--convert, 101 mm/dd/yy, 103 dd/mm/yy --103
	SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion, Estado.Estado,  Servicio.IdDependencia,Solicitud.IdServicio, 
			Servicio.Servicio, colonia.Id,Colonia.Colonia, CONVERT(char(20), dbo.getfechacreacion(solicitud.id), 113)  as FechaCreacion,
			DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as  'hrs'
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.Colonia
		ON solicitud.idCOlonia = Colonia.id
		INNER JOIN dbo.Servicio
		ON Solicitud.idServicio=Servicio.id
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) and Servicio.Id=@idServicio 		
		ORDER BY Servicio.Id
		ASC
	END

GO
/****** Object:  StoredProcedure [dbo].[ConsultarPorFecha]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ConsultarPorFecha]
	(
		@fecha1 datetime,
		@fecha2 datetime
	)
AS
	BEGIN		
--		SET NOCOUNT ON
		SELECT Solicitud.Id as IdSolicitud, Solicitud.Descripcion, Estado.Estado
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.Id)
		--AND CONVERT(char(12), (SELECT min(FechaHora)FROM SolicitudEstado WHERE idSolicitud=Solicitud.id), 103) between CONVERT(char(12), @fecha1, 103) and CONVERT(char(12), @fecha2, 103)
		AND (SELECT min(FechaHora)FROM SolicitudEstado WHERE idSolicitud=Solicitud.id) between  @fecha1 and  @fecha2
		ORDER BY idsolicitud ASC
	END 
GO
/****** Object:  StoredProcedure [dbo].[ConsultarPorNombre]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConsultarPorNombre]
	(
		@Nombre varchar(30),
		@ApellidoP varchar(30)
	)
AS
	BEGIN	
--		SET NOCOUNT ON
		SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion,Estado.Estado, Ciudadano.CorreoE as correoE
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.RelSolCiud
		ON Solicitud.id = RelSolCiud.idSolicitud
		INNER JOIN dbo.Ciudadano
		ON RelSolCiud.idCiudadano=Ciudadano.id
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id)
		AND Ciudadano.Nombre like @Nombre AND Ciudadano.ApellidoP like @ApellidoP
		ORDER BY Solicitud.Id
	END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarPorSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[ConsultarPorSolicitud]
	(
		@SolicitudID int
	)
AS
	BEGIN		
--		SET NOCOUNT ON
		SELECT DISTINCT Solicitud.Id as IdSolicitud, Solicitud.Descripcion, Estado.Estado, Ciudadano.CorreoE as correoE
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.RelSolCiud
		ON Solicitud.id = RelSolCiud.idSolicitud
		INNER JOIN dbo.Ciudadano
		ON RelSolCiud.idCiudadano=Ciudadano.id		
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.Id)
		AND Solicitud.Id=@SolicitudID
	END
GO
/****** Object:  StoredProcedure [dbo].[CuantasSolicitudesByEstado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[CuantasSolicitudesByEstado]
(
	@Estado varchar(20)
)
AS
	BEGIN
		SELECT Count(Solicitud.Id)
		FROM SolicitudEstado
		INNER JOIN Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN Servicio
		ON Solicitud.idServicio=Servicio.id
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(idSolicitud)
		AND idEstado = (select id FROM dbo.Estado WHERE Estado=@Estado)
	END
GO
/****** Object:  StoredProcedure [dbo].[DeleteAppOfUser]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteAppOfUser]
	(
		@LoginID varchar(255),
		@AppName varchar(255)
	)
AS
	SET NOCOUNT ON 
	
	DECLARE 
		@UID INTEGER,
		@AID INTEGER
--Si existen (ka aplicacion y el usuario su id sera mayor a 0)
	SET @AID =dbo.GetAppIdByName(@AppName)
	SET @UID = dbo.GetUserIDByLoginID(@LoginID)	
	IF (@AID>0 AND @UID >0)
		BEGIN
			DELETE FROM esAppsUsers 
					WHERE @AID=iAppID
					AND @UID=iUserID
		END
RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[deleteColonia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[deleteColonia]
	(@id smallint, @eliminado bit output)
AS
	BEGIN		
		--SI EXISTE ALGUN CIUDADANO QUE VIVE EN LA COLONIA(@id)
		IF
		( 
			(SELECT COUNT (ciudadano.id) FROM dbo.Ciudadano 
				WHERE Ciudadano.idColonia= @id)  >0
		)
		SET @eliminado = 0
		ELSE			
				BEGIN				
					DELETE dbo.Colonia 
					WHERE Colonia.id= @id
					SET @eliminado = 1
				END		
	END
GO
/****** Object:  StoredProcedure [dbo].[deleteDependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[deleteDependencia]
	(@id smallint, @eliminado bit output)
AS
	BEGIN		
		--SI EXISTE ALGUNA SOLICITUD QUE TENGA ASOCIADO ALGUN SERVICIO PERTENECIENTE A ESA DEPENDENCIA (@id)
		IF
		( 
			(SELECT COUNT (dbo.Solicitud.id) FROM dbo.Solicitud 
				WHERE Solicitud.idServicio IN (SELECT id FROM dbo.Servicio WHERE Servicio.idDependencia = @id) ) >0
		)
			SET @eliminado = 0    --RETURN 110003 --NO SE PUEDE ELIMINAR LA DEPENDENCIA PORQUE EXISTE UNA SOLICITUD A LA QUE HACE REFERENCIA
		ELSE			
				BEGIN				
					DELETE dbo.Dependencia 
					WHERE Dependencia.id= @id
					SET @eliminado = 1
				END		
	END
GO
/****** Object:  StoredProcedure [dbo].[deleteLocalidad]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[deleteLocalidad]
	(@id smallint, @eliminado bit output)
AS
	BEGIN		
		--SI EXISTE ALGUN CIUDADANO QUE VIVE EN ALGUNA COLONIA PERTENECIENTE A ESA LOCALIDAD (@id)
		IF
		( 
			(SELECT COUNT (Ciudadano.Id) FROM dbo.Ciudadano 
				WHERE Ciudadano.idColonia IN (SELECT Id FROM dbo.Colonia WHERE Colonia.IdLocalidad = @id) ) >0
		)
		SET @eliminado=0	  --RETURN 110001 --NO SE PUEDE ELIMINAR ESTA LOCALIDAD PORQUE EXISTE UN CIUDADANO DADO DE ALTA
		ELSE			
				BEGIN				
					DELETE dbo.Localidad 
					WHERE Localidad.id= @id
					SET @eliminado=1
				END		
	END
GO
/****** Object:  StoredProcedure [dbo].[deleteServicio]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[deleteServicio]
	(@id smallint, @eliminado bit output )
AS
	BEGIN		
		--SI EXISTE ALGUNA SOLICITUD QUE TENGA ASIGNADO EL SERVICIO(@id)
		IF
		( 
			(SELECT COUNT (Solicitud.id) FROM dbo.Solicitud 
				WHERE Solicitud.idServicio= @id)  >0
		)
		SET @eliminado = 0	--RETURN 110004 --NO SE PUEDE ELIMINAR EL SERVICIO PORQUE EXISTE UNA SOLICITUD A LA QUE HACE REFERENCIA
		ELSE			
				BEGIN				
					DELETE dbo.Servicio 
					WHERE Servicio.id= @id
					SET @eliminado = 1
				END		
	END
GO
/****** Object:  StoredProcedure [dbo].[deleteSolicitudTemp]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[deleteSolicitudTemp]
	(@id int, @logic bit)
AS
	BEGIN		
		IF @logic = 0
			DELETE FROM SolicitudTemp WHERE ID = @id
		ELSE
			UPDATE SolicitudTemp SET Eliminado=1 WHERE ID=@id
		
	END
GO
/****** Object:  StoredProcedure [dbo].[deleteTiempoRespuesta]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[deleteTiempoRespuesta]
	(@idTiempo smallint, @eliminado bit output)
AS
	BEGIN		
		--SI EXISTE ALGUN TIEMPO QUE SE ENCUENTRE EN LA DEPENDENCIA
		IF
		( 
			(SELECT COUNT (Dependencia.Id) FROM dbo.Dependencia 
				WHERE Dependencia.idTiempo = @idTiempo ) >0
		)
		SET @eliminado=0	  --RETURN 110001 --NO SE PUEDE ELIMINAR ESTE TIEMPO DE RESPUESTA, PUESTO QUE EXISTE EN UNA DEPENDENCIA
		ELSE			
				BEGIN				
					DELETE dbo.TiempoRespuesta 
					WHERE TiempoRespuesta.idTiempo= @idTiempo
					SET @eliminado=1
				END		
	END

GO
/****** Object:  StoredProcedure [dbo].[error]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[error]
	(
		@Name varchar(255),
		@Password char(128)
	)
AS

		


RAISERROR (50001, 16, 1)

select * FROM gfhg
GO
/****** Object:  StoredProcedure [dbo].[insertColonia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insertColonia]
	(
		@Colonia varchar (50),
		@idLocalidad smallint,
		@insertado bit output
	)
AS	
	BEGIN
		SET NOCOUNT ON 	
		IF dbo.ExisteColonia(@Colonia, @idLocalidad)=0
			BEGIN
				INSERT INTO dbo.Colonia (Colonia,idLocalidad)	VALUES ( @Colonia, @idLocalidad)
				SET @insertado=1
			END
		ELSE
			SET @insertado=0
	END
GO
/****** Object:  StoredProcedure [dbo].[insertDependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[insertDependencia]
	(
		@esOp bit,
		@Dependencia varchar (50),
		@Descripcion varchar(256),
		@Ubicacion varchar(50),
		@Telefono varchar(20),
		@CorreoE varchar(50),
		@idTiempo smallint,
		@insertado bit output
	)
AS	
	BEGIN
		SET NOCOUNT ON		

		IF dbo.ExisteDependencia(@Dependencia)=0
			BEGIN
				INSERT INTO dbo.Dependencia (esOP,Dependencia, Descripcion, Ubicacion, Telefono, CorreoE, idTiempo) 
				VALUES ( @esOp,@Dependencia, @Descripcion, @Ubicacion, @Telefono, @CorreoE, @idTiempo)
				SET @insertado=1
			END
		ELSE
			SET @insertado=0
	END

GO
/****** Object:  StoredProcedure [dbo].[insertLocalidad]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[insertLocalidad]
	(
		@Localidad varchar (50),
		@insertado bit output
	)
AS	
	BEGIN
		SET NOCOUNT ON 		

		IF dbo.ExisteLocalidad(@Localidad)=0
			BEGIN
				INSERT INTO dbo.Localidad (Localidad)	VALUES ( @Localidad)
				SET @insertado=1
			END
		ELSE
			SET @insertado=0
	END
GO
/****** Object:  StoredProcedure [dbo].[insertServicio]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[insertServicio]
	(
		@IDServicios int=0  OUTPUT,
		@Servicio varchar (50),
		@idDependencia smallint,
		@Descripcion varchar(256)
		--@insertado bit output
	)
AS	
	BEGIN
		SET @IDServicios=0
		SET NOCOUNT ON 		
			
			BEGIN
				INSERT INTO dbo.Servicio (Servicio, idDependencia, Descripcion)
				VALUES (@Servicio, @idDependencia, @Descripcion )
				SET @IDServicios=1
			END
		
	END
GO
/****** Object:  StoredProcedure [dbo].[insertSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[insertSolicitud]
	(
		@Nombre varchar(30)='',
		@ApellidoP varchar (30) = '',
		@ApellidoM varchar (30)='',
		@Direccion varchar(50)='',
		@idColonia smallint=0,
--		@Calle1 varchar(50)='',
--		@Calle2 varchar(50)='',
		@NumeroExt varchar(5)='',
		--@NumeroInt varchar(5)='',
		@Sexo bit=1,
		--@Edad smallint=1,		
		@Telefono varchar (20)='',
		@TelefonoAlt varchar (20)='',
		@CorreoE varchar(50)='',
		@fechaNac smalldatetime=null,
		--@CorreoEAlt varchar(50)='',
		--@Asociacion varchar (50)='',

		@Descripcion varchar(1024)='',
		@idServicio smallint=0,
		@Calle varchar(50)='',
		@Ref1 varchar(50)='',
		@Ref2 varchar(50)='',
		@idCol smallint=0,

		@idCaptura varchar(50)='',
		@Estado varchar(20)='',

		@idSol int=0,
		@idCiud int=0,
		@idformacontacto smallint=0,
		@idSolicitud int=0  OUTPUT,
		@idCiudadano int=0 OUTPUT

	)
AS
	SET NOCOUNT ON 		
	DECLARE @NumCiudadano int,
		@NumSolicitud int,
		@es smallint

	SET @es=dbo.GetEstadoIdByName(@Estado)

	IF (@idCiud=0) 
	BEGIN
		INSERT INTO dbo.Ciudadano (Nombre, ApellidoP, ApellidoM,  Direccion, IdColonia, NumeroExt,/*NumeroInt,*/
		 		Sexo, CorreoE, /*CorreoEAlt,*/ fechaNac, Telefono, TelefonoAlt/*,  Asociacion*/)
		VALUES (@Nombre, @ApellidoP, @ApellidoM, @Direccion, @idColonia, @NumeroExt, /*@NumeroInt,*/
			  @Sexo, @CorreoE,/* @CorreoEAlt,*/ @fechaNac, @Telefono, @TelefonoAlt/*, @Asociacion*/)
		SET @NumCiudadano= @@IDENTITY 
		SET  @idCiudadano = @NumCiudadano
	END
	ELSE SET @idCiudadano=@idCiud

	IF (@idSol=0) 
	BEGIN
		INSERT INTO Solicitud (Descripcion, IdServicio, Calle, Ref1, Ref2, IdColonia,idformacontacto)
				VALUES(@Descripcion, @idServicio, @Calle, @Ref1, @Ref2, @IdCol,@idformacontacto)
		SET @NumSolicitud=@@IDENTITY 
		SET @idSolicitud=@NumSolicitud
		INSERT INTO SolicitudEstado (idSolicitud, idEstado, FechaHora, IdCaptura)
			VALUES (@idSolicitud, @es, GETDATE(), @idCaptura)
	END
	ELSE SET @idSolicitud=@idSol

	INSERT INTO RelSolCiud(IdCiudadano,IdSolicitud) VALUES (@idCiudadano, @idSolicitud)
	
	SELECT @idSolicitud
	RETURN @@ERROR

GO
/****** Object:  StoredProcedure [dbo].[insertSolicitudTemp]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insertSolicitudTemp]
	(
		@Nombre varchar(30)='',
		@ApellidoP varchar (30) = '',
		@ApellidoM varchar (30)='',
		@Direccion varchar(50)='',
		@idColonia smallint=0,
		@NumeroExt varchar(5)='',
		--@NumeroInt varchar(5)='',
		@Sexo bit=1,
		--@Edad smallint=1,		
		@fechaNac smalldatetime=null,
		@Telefono varchar (20)='',
		@TelefonoAlt varchar (20)='',
		@CorreoE varchar(50)='',
		
		--@CorreoEAlt varchar(50)='',
		--@Asociacion varchar (50)='',

		@Descripcion 	varchar(1024)='',
		@Calle varchar(50)='',
		@Ref1 varchar(50)='',
		@Ref2 varchar(50)='',
		@idCol smallint=0

	)
AS
	SET NOCOUNT ON 		
	INSERT INTO dbo.SolicitudTemp (Nombre, ApellidoP, ApellidoM,  Direccion, IdColonia, NumeroExt,/*NumeroInt,*/ Sexo, CorreoE, /*CorreoEAlt, Edad,*/ fechaNac, Telefono, TelefonoAlt,  /*Asociacion,*/
			Descripcion,  Calle, Ref1, Ref2, IdCol, Eliminado, FechaHora)
	VALUES (@Nombre, @ApellidoP, @ApellidoM, @Direccion, @idColonia, @NumeroExt, /*@NumeroInt, */ @Sexo, @CorreoE, /*@CorreoEAlt, @Edad,*/ @fechaNac, @Telefono, @TelefonoAlt, /*@Asociacion,*/
		@Descripcion,  @Calle, @Ref1, @Ref2, @IdCol, 0, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[insertTiempoRespuesta]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[insertTiempoRespuesta]
	(
		@descripcion varchar (60),	
		@verde smallint,
		@amarillo smallint,
		@naranja smallint,
		@rojo smallint,			
		@insertado bit output
	)
AS	
	BEGIN
		SET NOCOUNT ON 		

		IF dbo.ExisteTiempoRespuesta(@verde)=0
			BEGIN
				INSERT INTO dbo.tiempoRespuesta (descripcion,verde,amarillo,naranja,rojo)	
				VALUES (@descripcion,@verde,@amarillo,@naranja,@rojo)
				SET @insertado=1
			END
		ELSE
			SET @insertado=0
	END




GO
/****** Object:  StoredProcedure [dbo].[proc_AddChangeSolicitudByEstado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[proc_AddChangeSolicitudByEstado]
	(
		@idSolicitud int=0,		
		@idCaptura varchar(50)=''
	)
AS
	SET NOCOUNT ON 		
	DECLARE @es smallint
		
	SET @es=dbo.GetEstadoIdByName('Entrante')

		INSERT INTO dbo.SolicitudEstado(IdSolicitud,IdEstado,FechaHora,IdCaptura)
		VALUES (@idSolicitud,@es,GETDATE(),@idCaptura)
					
	RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[proc_AddEstadosBySolicitudesEntrantes]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[proc_AddEstadosBySolicitudesEntrantes]
	(
		@idSolEdo int out,
		@idSolicitud int=0,
		@idServicio smallint=0,
		@comentario varchar(1024)=null,
		@estado varchar(20)='',
		@idCaptura varchar(50)=''
	)
AS
	SET NOCOUNT ON 		
	DECLARE @es smallint
	
	SET @es=dbo.GetEstadoIdByName(@estado)
	
	INSERT INTO dbo.SolicitudEstado(IdSolicitud,IdEstado,FechaHora,IdCaptura)
	VALUES (@idSolicitud,@es,GETDATE(),@idCaptura)
	SET @idSolEdo= @@IDENTITY 		
	------------------
	UPDATE dbo.Solicitud set IdServicio=@idServicio where Id=@idSolicitud
	----------------
	IF @comentario is not null	
	INSERT INTO Seguimiento(IdSolicitudEstado,Comentario) VALUES (@idSolEdo, @comentario)	
	
	--select @idSolEdo
	RETURN @@ERROR




GO
/****** Object:  StoredProcedure [dbo].[proc_AddSeguimiento]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[proc_AddSeguimiento]
	(
		@IdSolicitudEstado int,
		@comentario varchar(1024)		
	)
AS	
	BEGIN
		SET NOCOUNT ON 			
		INSERT INTO dbo.Seguimiento(IdSolicitudEstado,Comentario)	VALUES ( @IdSolicitudEstado, @comentario)
	END

GO
/****** Object:  StoredProcedure [dbo].[proc_addseguridad]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[proc_addseguridad]
	(		
		@IDSeguridad bigint=0  OUTPUT,
		@iAppLogin varchar(20)='',
		@iAppNombreC varchar (250) = '',
		@iAppCorreo varchar (255)='',
		@iAppPwd varchar(250)='',
		@iAppAudiencia bit=0
	)
AS
	BEGIN
	SET NOCOUNT ON 	
	IF dbo.ExisteUserId(@iAppLogin)=0
		BEGIN	
			INSERT INTO dbo.esAppWebUsuario (iAppLogin,iAppNombreC,iAppCorreo,iAppPwd,iAppAudiencia)
			VALUES (@iAppLogin, @iAppNombreC, @iAppCorreo,@iAppPwd,@iAppAudiencia)
			SET @IDSeguridad=@@IDENTITY 
		END
		ELSE
			SET @IDSeguridad=0
	END



GO
/****** Object:  StoredProcedure [dbo].[proc_addSolicitud_Temporal]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[proc_addSolicitud_Temporal]
	(		
		@IDSolicitud_Temporal int=0  OUTPUT,
		@Nombre varchar(30)='',
		@ApellidoP varchar (30) = '',
		@ApellidoM varchar (30)='',
		@Direccion varchar(50)='',
		@idColonia smallint=0,
		@NumeroExt varchar(5)='',
		@NumeroInt varchar(5)='',
		@Sexo bit=1,
		--@Edad smallint=1,		
		@fechaNac smalldatetime=null,
		@Telefono varchar (20)=null,
		@TelefonoAlt varchar (20)=null,
		@CorreoE varchar(50)=null,
		
		--@CorreoEAlt varchar(50)='',
		--@Asociacion varchar (50)='',

		@Descripcion 	varchar(1024)='',
		@Calle varchar(50)='',
		@Ref1 varchar(50)='',
		@Ref2 varchar(50)='',
		@idCol smallint=0,
		@formaContacto tinyint=0

	)
AS
	SET NOCOUNT ON 		
	INSERT INTO dbo.SolicitudTemp (Nombre, ApellidoP, ApellidoM,  Direccion, IdColonia, NumeroExt,NumeroInt, Sexo, CorreoE, /*CorreoEAlt, Edad,*/ fechaNac, Telefono, TelefonoAlt,  /*Asociacion,*/
			Descripcion,  Calle, Ref1, Ref2, IdCol, Eliminado, FechaHora,formaContacto)
	VALUES (@Nombre, @ApellidoP, @ApellidoM, @Direccion, @idColonia, @NumeroExt, @NumeroInt, @Sexo, @CorreoE, /*@CorreoEAlt, @Edad,*/ @fechaNac, @Telefono, @TelefonoAlt, /*@Asociacion,*/
		@Descripcion,  @Calle, @Ref1, @Ref2, @IdCol, 0, GETDATE(),@formaContacto)

	SET @IDSolicitud_Temporal=@@IDENTITY 



GO
/****** Object:  StoredProcedure [dbo].[proc_addSolicitud_Temporal_Movil]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


--CREATE TABLE [dbo].[SolicitudTempMovil](
--	[idtmp] [bigint] IDENTITY(1,1) NOT NULL,
--	[nombrecompleto] [varchar](200) NULL,
--	[idcolonia] [smallint] NULL,
--	[direccion] [varchar](255) NULL,
--	[telefono] [varchar](50) NULL,
--	[correoe] [varchar](150) NULL,
--	[problema] [varchar](1024) NULL,
--	[idcoloniap] [smallint] NULL,
--	[ref01] [varchar](100) NULL,
--	[ref02] [varchar](100) NULL,
-- CONSTRAINT [PK_SolicitudTempMovil] PRIMARY KEY CLUSTERED 


CREATE PROCEDURE [dbo].[proc_addSolicitud_Temporal_Movil]
	(		
		@idtmp bigint=0  OUTPUT,
		@nombrecompleto varchar(200)='',	
		@idcolonia smallint=0,
		@direccion varchar(255)='',
		@telefono varchar(50)='',		
		@correoe varchar(150)='',	
		@problema varchar(1024)='',
		@idcoloniap smallint=0,		
		@ref01 varchar(100)='',
		@ref02 varchar(100)=''
	)
AS
	SET NOCOUNT ON 		
	INSERT INTO dbo.SolicitudTempMovil (nombrecompleto,idcolonia,direccion,telefono,correoe,problema,idcoloniap,ref01,ref02)
	VALUES (@nombrecompleto,@idcolonia,@direccion,@telefono,@correoe,@problema,@idcoloniap,@ref01,@ref02)

	SET @idtmp=@@IDENTITY 


GO
/****** Object:  StoredProcedure [dbo].[proc_addSolicitudAudienciaSolucionado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[proc_addSolicitudAudienciaSolucionado]
	(
		@Nombre varchar(30)='',
		@ApellidoP varchar (30) = '',
		@ApellidoM varchar (30)='',
		@Direccion varchar(50)='',
		@idColonia smallint=0,--		
		@NumeroExt varchar(5)='',		
		@Sexo bit=1,	
		@Telefono varchar (20)='',
		@TelefonoAlt varchar (20)='',
		@CorreoE varchar(50)='',
		@fechaNac datetime=null,
		@Descripcion varchar(1024)='',
		@idServicio smallint=0,
		@Calle varchar(50)='',
		@Ref1 varchar(50)='',
		@Ref2 varchar(50)='',
		@idCol smallint=0,

		@idCaptura varchar(50)='',
		@Encargado varchar(50)='',
		@Solucion varchar(1024)='',
		--@Estado varchar(20)='',

		@idSol int=0,
		@idCiud int=0,
		@idformacontacto smallint=0,
		@idSolicitud int=0  OUTPUT,
		@idCiudadano int=0 OUTPUT,
		@idSolEstado int=0 OUTPUT

	)
AS
	SET NOCOUNT ON 		
	DECLARE @NumCiudadano int,
		@NumSolicitud int,
		@es smallint,
		@es2 smallint,
		@es3 smallint,
		@NumSolEstado int		

	SET @es=dbo.GetEstadoIdByName('Entrante')
	SET @es2=dbo.GetEstadoIdByName('En Proceso')
	SET @es3=dbo.GetEstadoIdByName('Realizado')
	

	IF (@idCiud=0) 
	BEGIN
		INSERT INTO dbo.Ciudadano (Nombre, ApellidoP, ApellidoM,  Direccion, IdColonia, NumeroExt,/*NumeroInt,*/
		 		Sexo, CorreoE, /*CorreoEAlt,*/ fechaNac, Telefono, TelefonoAlt/*,  Asociacion*/)
		VALUES (@Nombre, @ApellidoP, @ApellidoM, @Direccion, @idColonia, @NumeroExt, /*@NumeroInt,*/
			  @Sexo, @CorreoE,/* @CorreoEAlt,*/ cast(@fechaNac as smalldatetime), @Telefono, @TelefonoAlt/*, @Asociacion*/)
		SET @NumCiudadano= @@IDENTITY 
		SET  @idCiudadano = @NumCiudadano
	END
	ELSE SET @idCiudadano=@idCiud

	IF (@idSol=0) 
	BEGIN
		--Se generá la inserción de la solicitud
		INSERT INTO Solicitud (Descripcion, IdServicio, Calle, Ref1, Ref2, IdColonia,idformacontacto)
				VALUES(@Descripcion, @idServicio, @Calle, @Ref1, @Ref2, @IdCol,@idformacontacto)
		SET @NumSolicitud=@@IDENTITY 
		SET @idSolicitud=@NumSolicitud
		--Se insertan los estados
		--Entrante
		INSERT INTO SolicitudEstado (idSolicitud, idEstado, FechaHora, IdCaptura)
			VALUES (@idSolicitud, @es, GETDATE(), @idCaptura)
		--SET @idSolEstado= @@IDENTITY 
		--INSERT INTO Seguimiento(IdSolicitudEstado,Comentario) VALUES (@idSolEstado, 'Captura en audiencias publicas '+ GETDATE())	
	
		--En Proceso
		INSERT INTO SolicitudEstado (idSolicitud, idEstado, FechaHora, IdCaptura)
			VALUES (@idSolicitud, @es2, GETDATE(), @idCaptura)
		--SET @idSolEstado= @@IDENTITY 
		--INSERT INTO Seguimiento(IdSolicitudEstado,Comentario) VALUES (@idSolEstado, 'Captura en audiencias publicas '+ GETDATE())	

		--Solucionado
		INSERT INTO SolicitudEstado (idSolicitud, idEstado, FechaHora, IdCaptura)
			VALUES (@idSolicitud, @es3, GETDATE(), @idCaptura)
		--Asignamos la última inserción a la variable ...
		SET @NumSolEstado= @@IDENTITY 
		SET  @idSolEstado = @NumSolEstado
			
		INSERT INTO Seguimiento(IdSolicitudEstado,Comentario) VALUES (@idSolEstado, 'Captura en audiencias publicas '+ convert(varchar(20),GETDATE() ,103))	

		--Insertamos el comentarios en la tabla realizado ...
		INSERT INTO ServicioRealizado (IdSolicitudEstado, FechaRealizacion, Encargado, Solucion)
		VALUES (@idSolEstado, GETDATE(), @Encargado, @Solucion)
		
	END
	ELSE SET @idSolicitud=@idSol

	INSERT INTO RelSolCiud(IdCiudadano,IdSolicitud) VALUES (@idCiudadano, @idSolicitud)
	
	SELECT @idSolicitud
	RETURN @@ERROR




GO
/****** Object:  StoredProcedure [dbo].[proc_AddSolicitudByEstadoAndSeg]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[proc_AddSolicitudByEstadoAndSeg]
	(
		@idSolicitud int=0,
		@comentario varchar(1024)='',
		@idCaptura varchar(50)='',
		@idSolEstado int=0
	

	)
AS
	SET NOCOUNT ON 		
	DECLARE @idSolEdo int,
		@estado varchar(20),
		@es smallint
	
	SET @estado=dbo.GetLastEstadoByIdSolicitud(@idSolicitud)
	SET @es=dbo.GetEstadoIdByName(@estado)

	IF (@idSolEstado=0) 
	BEGIN
		INSERT INTO dbo.SolicitudEstado(IdSolicitud,IdEstado,FechaHora,IdCaptura)
		VALUES (@idSolicitud,@es,GETDATE(),@idCaptura)
		SET @idSolEdo= @@IDENTITY 		
	END
	ELSE SET @idSolEdo=@idSolEstado

	INSERT INTO Seguimiento(IdSolicitudEstado,Comentario) VALUES (@idSolEdo, @comentario)
	RETURN @@ERROR
GO
/****** Object:  StoredProcedure [dbo].[proc_AddSolicitudByEstadoAndSegAndChgEdo]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[proc_AddSolicitudByEstadoAndSegAndChgEdo]
	(
		@idSolicitud int=0,
		@comentario varchar(1024)='',
		@idCaptura varchar(50)='',
		@estado varchar(20)='',
		@idSolEstado int=0		

	)
AS
	SET NOCOUNT ON 		
	DECLARE @idSolEdo int,
		@es smallint	
	--SET @estado=dbo.GetLastEstadoByIdSolicitud(@idSolicitud)
	SET @es=dbo.GetEstadoIdByName(@estado)

	IF (@idSolEstado=0) 
	BEGIN
		INSERT INTO dbo.SolicitudEstado(IdSolicitud,IdEstado,FechaHora,IdCaptura)
		VALUES (@idSolicitud,@es,GETDATE(),@idCaptura)
		SET @idSolEdo= @@IDENTITY 		
	END
	ELSE 
	begin
		INSERT INTO dbo.SolicitudEstado(IdSolicitud,IdEstado,FechaHora,IdCaptura)
		VALUES (@idSolicitud,@es,GETDATE(),@idCaptura)
		SET @idSolEdo= @@IDENTITY 
		update ServicioRealizado set IdSolicitudEstado=@idSolEdo where IdSolicitudEstado=@idSolEstado;
	end

	INSERT INTO Seguimiento(IdSolicitudEstado,Comentario) VALUES (@idSolEdo, @comentario)	

	RETURN @@ERROR


GO
/****** Object:  StoredProcedure [dbo].[proc_AddSolicitudByEstadoAndSegAndChgEdoAndDep]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[proc_AddSolicitudByEstadoAndSegAndChgEdoAndDep]
	(
		@idSolicitud int=0,
		@comentario varchar(1024)='',
		@idCaptura varchar(50)='',
		@estado varchar(20)='',
		@idSolEstado int=0,
		@idServicio smallint=0		

	)
AS
	SET NOCOUNT ON 		
	DECLARE @idSolEdo int,
		@es smallint	
	--SET @estado=dbo.GetLastEstadoByIdSolicitud(@idSolicitud)
	SET @es=dbo.GetEstadoIdByName(@estado)

	IF (@idSolEstado=0) 
	BEGIN
		INSERT INTO dbo.SolicitudEstado(IdSolicitud,IdEstado,FechaHora,IdCaptura)
		VALUES (@idSolicitud,@es,GETDATE(),@idCaptura)
		SET @idSolEdo= @@IDENTITY 		
	END
	ELSE SET @idSolEdo=@idSolEstado

	INSERT INTO Seguimiento(IdSolicitudEstado,Comentario) VALUES (@idSolEdo, @comentario)	
	UPDATE dbo.Solicitud SET IdServicio=@idServicio WHERE Id=@idSolicitud
	RETURN @@ERROR


GO
/****** Object:  StoredProcedure [dbo].[proc_addSolicitudEntrante]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create PROCEDURE [dbo].[proc_addSolicitudEntrante]
	(
		@Nombre varchar(30)='',
		@ApellidoP varchar (30) = '',
		@ApellidoM varchar (30)='',
		@Direccion varchar(50)='',
		@idColonia smallint=0,
--		@Calle1 varchar(50)='',
--		@Calle2 varchar(50)='',
		@NumeroExt varchar(5)='',
		--@NumeroInt varchar(5)='',
		@Sexo bit=1,
		--@Edad smallint=1,		
		@Telefono varchar (20)='',
		@TelefonoAlt varchar (20)='',
		@CorreoE varchar(50)='',
		@fechaNac datetime=null,
		--@CorreoEAlt varchar(50)='',
		--@Asociacion varchar (50)='',

		@Descripcion varchar(1024)='',
		@idServicio smallint=0,
		@Calle varchar(50)='',
		@Ref1 varchar(50)='',
		@Ref2 varchar(50)='',
		@idCol smallint=0,

		@idCaptura varchar(50)='',
		@Estado varchar(20)='',

		@idSol int=0,
		@idCiud int=0,
		@idformacontacto smallint=0,
		@idSolicitud int=0  OUTPUT,
		@idCiudadano int=0 OUTPUT

	)
AS
	SET NOCOUNT ON 		
	DECLARE @NumCiudadano int,
		@NumSolicitud int,
		@es smallint

	SET @es=dbo.GetEstadoIdByName(@Estado)

	IF (@idCiud=0) 
	BEGIN
		INSERT INTO dbo.Ciudadano (Nombre, ApellidoP, ApellidoM,  Direccion, IdColonia, NumeroExt,/*NumeroInt,*/
		 		Sexo, CorreoE, /*CorreoEAlt,*/ fechaNac, Telefono, TelefonoAlt/*,  Asociacion*/)
		VALUES (@Nombre, @ApellidoP, @ApellidoM, @Direccion, @idColonia, @NumeroExt, /*@NumeroInt,*/
			  @Sexo, @CorreoE,/* @CorreoEAlt,*/ cast(@fechaNac as smalldatetime), @Telefono, @TelefonoAlt/*, @Asociacion*/)
		SET @NumCiudadano= @@IDENTITY 
		SET  @idCiudadano = @NumCiudadano
	END
	ELSE SET @idCiudadano=@idCiud

	IF (@idSol=0) 
	BEGIN
		INSERT INTO Solicitud (Descripcion, IdServicio, Calle, Ref1, Ref2, IdColonia,idformacontacto)
				VALUES(@Descripcion, @idServicio, @Calle, @Ref1, @Ref2, @IdCol,@idformacontacto)
		SET @NumSolicitud=@@IDENTITY 
		SET @idSolicitud=@NumSolicitud
		INSERT INTO SolicitudEstado (idSolicitud, idEstado, FechaHora, IdCaptura)
			VALUES (@idSolicitud, @es, GETDATE(), @idCaptura)
	END
	ELSE SET @idSolicitud=@idSol

	INSERT INTO RelSolCiud(IdCiudadano,IdSolicitud) VALUES (@idCiudadano, @idSolicitud)
	
	SELECT @idSolicitud
	RETURN @@ERROR



GO
/****** Object:  StoredProcedure [dbo].[proc_addSolicitudEntranteNube]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[proc_addSolicitudEntranteNube]
	(
		@Nombre varchar(30)='',
		@ApellidoP varchar (30) = '',
		@ApellidoM varchar (30)='',
		@Direccion varchar(50)='',
		@idColonia smallint=0,
--		@Calle1 varchar(50)='',
--		@Calle2 varchar(50)='',
		@NumeroExt varchar(5)='',
		--@NumeroInt varchar(5)='',
		@Sexo bit=1,
		--@Edad smallint=1,		
		@Telefono varchar (20)='',
		@TelefonoAlt varchar (20)='',
		@CorreoE varchar(50)='',
		@fechaNac datetime=null,
		--@CorreoEAlt varchar(50)='',
		--@Asociacion varchar (50)='',

		@Descripcion varchar(1024)='',
		@idServicio smallint=0,
		@Calle varchar(50)='',
		@Ref1 varchar(50)='',
		@Ref2 varchar(50)='',
		@idCol smallint=0,

		@idCaptura varchar(50)='',
		@Estado varchar(20)='',

		@commt varchar(max)='',
		@idtmp int=0,
		@idSol int=0,
		@idCiud int=0,
		@idformacontacto smallint=0,
		@type smallint=0,
		@idSolicitud int=0  OUTPUT,
		@idCiudadano int=0 OUTPUT

	)
AS
	SET NOCOUNT ON 		
	DECLARE @NumCiudadano int,
		@NumSolicitud int,@idsoledo int,
		@es smallint

	SET @es=dbo.GetEstadoIdByName(@Estado)

	IF (@idCiud=0) 
	BEGIN
		INSERT INTO dbo.Ciudadano (Nombre, ApellidoP, ApellidoM,  Direccion, IdColonia, NumeroExt,/*NumeroInt,*/
		 		Sexo, CorreoE, /*CorreoEAlt,*/ fechaNac, Telefono, TelefonoAlt/*,  Asociacion*/)
		VALUES (@Nombre, @ApellidoP, @ApellidoM, @Direccion, @idColonia, @NumeroExt, /*@NumeroInt,*/
			  @Sexo, @CorreoE,/* @CorreoEAlt,*/ cast(@fechaNac as smalldatetime), @Telefono, @TelefonoAlt/*, @Asociacion*/)
		SET @NumCiudadano= @@IDENTITY 
		SET  @idCiudadano = @NumCiudadano
	END
	ELSE SET @idCiudadano=@idCiud

	IF (@idSol=0) 
	BEGIN
		INSERT INTO Solicitud (Descripcion, IdServicio, Calle, Ref1, Ref2, IdColonia,idformacontacto,idtmp)
				VALUES(@Descripcion, @idServicio, @Calle, @Ref1, @Ref2, @IdCol,@idformacontacto,@idtmp)
		SET @NumSolicitud=@@IDENTITY 
		SET @idSolicitud=@NumSolicitud
		INSERT INTO SolicitudEstado (idSolicitud, idEstado, FechaHora, IdCaptura)
			VALUES (@idSolicitud, @es, GETDATE(), @idCaptura)
			set @idsoledo=@@IDENTITY 
		insert into dbo.Seguimiento (IdSolicitudEstado,Comentario) values(@idsoledo,@commt)
	END
	ELSE SET @idSolicitud=@idSol

	INSERT INTO RelSolCiud(IdCiudadano,IdSolicitud) VALUES (@idCiudadano, @idSolicitud)
	
	if(@type=1)
		update dbo.SolicitudTempMovil set eliminado='1' where idtmp=@idtmp
	if(@type=2)
		update dbo.SolicitudTemp set eliminado='1' where Id=@idtmp

	SELECT @idSolicitud
	RETURN @@ERROR



GO
/****** Object:  StoredProcedure [dbo].[proc_AddSolicitudPrioritarios]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[proc_AddSolicitudPrioritarios]
	(
		@Nombre varchar(30)='',
		@ApellidoP varchar (30) = '',
		@ApellidoM varchar (30)='',
		@Direccion varchar(50)='',
		@idColonia smallint=0,
--		@Calle1 varchar(50)='',
--		@Calle2 varchar(50)='',
		@NumeroExt varchar(5)='',
		--@NumeroInt varchar(5)='',
		@Sexo bit=1,
		--@Edad smallint=1,		
		@Telefono varchar (20)='',
		@TelefonoAlt varchar (20)='',
		@CorreoE varchar(50)='',
		@fechaNac smalldatetime=null,
		--@CorreoEAlt varchar(50)='',
		--@Asociacion varchar (50)='',

		@Descripcion varchar(1024)='',
		@idServicio smallint=0,
		@Calle varchar(50)='',
		@Ref1 varchar(50)='',
		@Ref2 varchar(50)='',
		@idCol smallint=0,

		@idCaptura varchar(50)='',
		@Estado varchar(20)='',

		@idSol int=0,
		@idCiud int=0,
		@idformacontacto smallint=0,
		@idSolicitud int=0  OUTPUT,
		@idCiudadano int=0 OUTPUT

	)
AS
	SET NOCOUNT ON 		
	DECLARE @NumCiudadano int,
		@NumSolicitud int,
		@es smallint

	SET @es=dbo.GetEstadoIdByName(@Estado)

	IF (@idCiud=0) 
	BEGIN
		INSERT INTO dbo.Ciudadano (Nombre, ApellidoP, ApellidoM,  Direccion, IdColonia, NumeroExt,/*NumeroInt,*/
		 		Sexo, CorreoE, /*CorreoEAlt,*/ fechaNac, Telefono, TelefonoAlt/*,  Asociacion*/)
		VALUES (@Nombre, @ApellidoP, @ApellidoM, @Direccion, @idColonia, @NumeroExt, /*@NumeroInt,*/
			  @Sexo, @CorreoE,/* @CorreoEAlt,*/ @fechaNac, @Telefono, @TelefonoAlt/*, @Asociacion*/)
		SET @NumCiudadano= @@IDENTITY 
		SET  @idCiudadano = @NumCiudadano
	END
	ELSE SET @idCiudadano=@idCiud

	IF (@idSol=0) 
	BEGIN
		INSERT INTO Solicitud (Descripcion, IdServicio, Calle, Ref1, Ref2, IdColonia,idformacontacto,prioritario)
				VALUES(@Descripcion, @idServicio, @Calle, @Ref1, @Ref2, @IdCol,@idformacontacto,1)
		SET @NumSolicitud=@@IDENTITY 
		SET @idSolicitud=@NumSolicitud
		INSERT INTO SolicitudEstado (idSolicitud, idEstado, FechaHora, IdCaptura)
			VALUES (@idSolicitud, @es, GETDATE(), @idCaptura)
	END
	ELSE SET @idSolicitud=@idSol

	INSERT INTO RelSolCiud(IdCiudadano,IdSolicitud) VALUES (@idCiudadano, @idSolicitud)
	
	SELECT @idSolicitud
	RETURN @@ERROR


GO
/****** Object:  StoredProcedure [dbo].[proc_addSolicitudSolucionadoExcel]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_addSolicitudSolucionadoExcel]
(
	@idServicio smallint=null,
	@idCiudadano int=null
	--@Encargado varchar(150)=null
)
AS

-- Abrimos una transacción
BEGIN TRY
	
	SET NOCOUNT ON 		
	DECLARE @Nombre varchar(30),
		@ApellidoP varchar (30),
		@ApellidoM varchar (30),
		@Direccion varchar(50),
		@idColonia smallint,	
		@NumeroExt varchar(5),		
		@Sexo bit,	
		@Telefono varchar (20),		
		@CorreoE varchar(50),	
		@Descripcion varchar(1024),		
		@Calle varchar(50),
		@Ref1 varchar(50),
		@Ref2 varchar(50),
		@idCol smallint=0,
		@idCaptura varchar(50),
		@Encargado varchar(50),
		@Solucion varchar(1024),
		@fecha smalldatetime,
		@fechaSol smalldatetime,
		@atendio varchar(50),
		@capturo varchar(50),		
		@idformacontacto smallint	
	
	DECLARE @NumCiudadano int,
		@NumSolicitud int,
		@es smallint,
		@es2 smallint,
		@es3 smallint,
		@NumSolEstado int		

	SET @es=dbo.GetEstadoIdByName('Entrante')
	SET @es2=dbo.GetEstadoIdByName('En Proceso')
	SET @es3=dbo.GetEstadoIdByName('Realizado')
	
	set @Sexo=1
	set @Ref1='x'
	set @Ref2='x'
	set @idformacontacto=2
	--set @idServicio=180
	--set @Encargado=@atendio --'Liliana Rodriguez Díaz'
	
	BEGIN TRAN
	--Crear tabla temporal para el resultado final
	create table #CursorOut(
	idCiudadano int not null,
	idSolicitud int not null,
	idSolEstado int not null,
	fechaAudit datetime
	)
	
Declare curExcel cursor for
	-- se realiza la consulta que debe embeber el cursor
	SELECT Nombre, ApellidoP, ApellidoM, IdColonia, Direccion, NumeroExt, Fecha, 
	FechaSol, Descripcion, IdCol,Calle, Telefono, CorreoE, Solucion, Atendio, Capturo, UsuarioDep
	FROM SolicitudTmpExce
	
	--Abrimos el cursor e insertamos los registros a
	--las variables declaradas
	Open curExcel
	fetch Next From curExcel into @Nombre,@ApellidoP,@ApellidoM,@idColonia,@Direccion,@NumeroExt,@fecha,
	@fechaSol,@Descripcion,@idCol,@Calle,@Telefono,@CorreoE,@Solucion,@atendio,@capturo,@idCaptura
	
	while @@FETCH_STATUS = 0 begin
	
		set @Encargado=@atendio
		--Insertamos el ciudadano en la tabla con los datos del cursor
		IF (@idCiudadano=0) 
		BEGIN
		INSERT INTO dbo.Ciudadano	(Nombre, ApellidoP, ApellidoM,  Direccion, IdColonia, NumeroExt,Sexo, CorreoE,Telefono)
							VALUES	(@Nombre, @ApellidoP, @ApellidoM, @Direccion, @idColonia, @NumeroExt,@Sexo, @CorreoE, @Telefono)
							SET @NumCiudadano= @@IDENTITY 
		END
		ELSE SET @NumCiudadano=@idCiudadano
		
		--Se generá la inserción de la solicitud
		INSERT INTO Solicitud (Descripcion, IdServicio, Calle, Ref1, Ref2, IdColonia,idformacontacto)
						VALUES(@Descripcion, @idServicio, @Calle, @Ref1, @Ref2, @IdCol,@idformacontacto)
						SET @NumSolicitud=@@IDENTITY 		
	
		--Entrante
		INSERT INTO SolicitudEstado (idSolicitud, idEstado, FechaHora, IdCaptura)
			VALUES (@NumSolicitud, @es, @fecha, @idCaptura)
			
		--En Proceso
		INSERT INTO SolicitudEstado (idSolicitud, idEstado, FechaHora, IdCaptura)
			VALUES (@NumSolicitud, @es2, @fecha, @idCaptura)
		
		--Solucionado
		INSERT INTO SolicitudEstado (idSolicitud, idEstado, FechaHora, IdCaptura)
			VALUES (@NumSolicitud, @es3, @fechaSol, @idCaptura)
		--Asignamos la última inserción a la variable ...
		SET @NumSolEstado= @@IDENTITY 		
			
		INSERT INTO Seguimiento(IdSolicitudEstado,Comentario) VALUES (@NumSolEstado, 'Fecha de importación al sistema '+ convert(varchar(20),GETDATE() ,103) + '\n Atendio: '+ @atendio + ', Capturo: '+@capturo+', con fecha: '+ convert(varchar(20),@fecha ,103))	
		--INSERT INTO Seguimiento(IdSolicitudEstado,Comentario) VALUES (@NumSolEstado, 'Atendio: '+ @atendio + ', Capturo: '+@capturo+', con fecha: '+ convert(varchar(20),@fecha ,103))	

		--Insertamos el comentarios en la tabla realizado ...
		INSERT INTO ServicioRealizado (IdSolicitudEstado, FechaRealizacion, Encargado, Solucion)
		VALUES (@NumSolEstado, @fechaSol, @Encargado,isnull(@Solucion,'SOLUCIONADO'))
		
	

	INSERT INTO RelSolCiud(IdCiudadano,IdSolicitud) VALUES (@NumCiudadano, @NumSolicitud)
	
	--Insertar en tabla temporal
	insert into #CursorOut (idCiudadano,idSolicitud,idSolEstado, fechaAudit)
	values(@NumCiudadano,@NumSolicitud,@NumSolEstado,GETDATE())
	
	--Se genera la siguiente linea del cursor
	fetch Next From curExcel into @Nombre,@ApellidoP,@ApellidoM,@idColonia,@Direccion,@NumeroExt,@fecha,
	@fechaSol,@Descripcion,@idCol,@Calle,@Telefono,@CorreoE,@Solucion,@atendio,@capturo,@idCaptura
	
	end --End of fetch
	
	select * from #CursorOut
	
	close curExcel
	deallocate curExcel
	truncate table SolicitudTmpExce
COMMIT
					
END TRY	
BEGIN CATCH
	--IF @@TRANCOUNT > 0
	--	BEGIN
			ROLLBACK TRAN
			print ERROR_MESSAGE() 
			close curExcel
			deallocate curExcel
		--END 
END CATCH


GO
/****** Object:  StoredProcedure [dbo].[proc_delSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[proc_delSolicitud]
	(@id int, @eliminado bit output )
AS
	BEGIN		
		--SI NO EXISTE ALGUNA SOLICITUD
		IF
		( 
			(SELECT COUNT (Solicitud.id) FROM dbo.Solicitud 
				WHERE Solicitud.Id= @id) = 0
		)
		SET @eliminado = 0	--RETURN 110004 --LA SOLICITUD NO EXISTE POR ELLO NO SE PUEDE PROCEDER
		ELSE			
				BEGIN				
					WITH cteSolicitud AS
						(
							SELECT  se.IdSolicitud, se.IdSolicitudEstado 
							  ,ROW_NUMBER() OVER(PARTITION BY se.IdSolicitudEstado ORDER BY se.IdSolicitudEstado DESC) AS 'RowN'
							FROM dbo.SolicitudEstado se
							INNER JOIN dbo.Seguimiento s ON s.IdSolicitudEstado = se.IdSolicitudEstado where se.IdSolicitud=@id
						)
						DELETE FROM dbo.Seguimiento
						FROM cteSolicitud cs
						WHERE dbo.Seguimiento.IdSolicitudEstado = cs.IdSolicitudEstado AND cs.RowN > 1
						delete from dbo.SolicitudEstado where IdSolicitud=@id
						delete from dbo.Solicitud where Id=@id
  
					SET @eliminado = 1
				END		
	END
GO
/****** Object:  StoredProcedure [dbo].[proc_delSolicitudTemp_Mobil]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[proc_delSolicitudTemp_Mobil]
	(@id int, @logic bit)
AS
	BEGIN		
		IF @logic = 0
			DELETE FROM SolicitudTempMovil WHERE idtmp = @id
		ELSE
			UPDATE SolicitudTempMovil SET eliminado=1 WHERE idtmp=@id
		
	END
GO
/****** Object:  StoredProcedure [dbo].[proc_editseguridad]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[proc_editseguridad]
	(			
		@iAppLogin varchar(20)='',		
		@iAppPwd varchar(250)=''
	)
AS
	SET NOCOUNT ON 			
	UPDATE dbo.esAppWebUsuario
			SET iAppPwd=@iAppPwd
		WHERE esAppWebUsuario.iAppLogin = @iAppLogin
		
return @@rowcount

GO
/****** Object:  StoredProcedure [dbo].[proc_getCapturasDevueltas]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getCapturasDevueltas]
(
	--@cuantas int output,
	@IdCaptura varchar(50)=null	
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IdCaptura varchar(50)'
    
    SET @QUERY_P1 = N'SELECT Distinct(Solicitud.id), Servicio.Servicio, Solicitud.Descripcion
					FROM Solicitud
					INNER JOIN Servicio ON Solicitud.IdServicio = Servicio.Id
					INNER JOIN SolicitudEstado ON Solicitud.Id = SolicitudEstado.IdSolicitud'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

SET @QUERY_P2 = N'dbo.GetLastEstadoByIdSolicitud(Solicitud.id)='+char(39)+'Correccion'+CHAR(39)+'and solicitudestado.idsolicitudestado=dbo.GetFirstSolicitudEstadoByIdSolicitud(Solicitud.id)'
SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IdCaptura IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			--SET @QUERY_P2 = @QUERY_P2 + N'SolicitudEstado.IdCaptura like %@IdCaptura%'
			SET @QUERY_P2 = @QUERY_P2 + N'SolicitudEstado.IdCaptura like+'+char(39)+'%'+@IdCaptura+'%'+char(39)+''
            SET @PREVIO = 1            
END

-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@IdCaptura
	--SET @cuantas = @@ROWCOUNT
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END





GO
/****** Object:  StoredProcedure [dbo].[proc_getCapturasEnProcesoGestion]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getCapturasEnProcesoGestion]
(
	@cuantas int output,
	@IdCaptura varchar(50)=null,
	@IdDependencia smallint=null		
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IdCaptura varchar(50),@IdDependencia smallint'
    
    SET @QUERY_P1 = N'SELECT Distinct(Solicitud.id), Servicio.Servicio, Solicitud.Descripcion,
					 Servicio.idDependencia,Dependencia.Dependencia,Colonia.Colonia,Colonia.id as IdColonia,
					 CONVERT(char(20),SolicitudEstado.FechaHora, 113)  as FechaHora
					FROM Solicitud
					INNER JOIN Servicio ON Solicitud.IdServicio = Servicio.Id
					INNER JOIN Dependencia ON Dependencia.Id=Servicio.IdDependencia
					INNER JOIN Colonia ON Colonia.id = Solicitud.idcolonia
					INNER JOIN SolicitudEstado ON Solicitud.Id = SolicitudEstado.IdSolicitud'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

SET @QUERY_P2 = N'dbo.GetLastEstadoByIdSolicitud(Solicitud.id)='+char(39)+'En Gestion'+CHAR(39)+'and solicitudestado.idsolicitudestado=dbo.GetFirstSolicitudEstadoByIdSolicitud(Solicitud.id)'
SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IdCaptura IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'SolicitudEstado.IdCaptura=@IdCaptura'           
            SET @PREVIO = 1            
END
---------------------------
IF @IdDependencia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Servicio.IdDependencia=@IdDependencia'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@IdCaptura,@IdDependencia
	SET @cuantas = @@ROWCOUNT
--PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END






GO
/****** Object:  StoredProcedure [dbo].[proc_getCapturasExitosas]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

create PROCEDURE [dbo].[proc_getCapturasExitosas]
(
	@cuantas int output,
	@IdCaptura varchar(50)=null,
	@IdDependencia smallint=null		
)

AS

BEGIN
	SET LANGUAGE Español
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IdCaptura varchar(50),@IdDependencia smallint'
    
    SET @QUERY_P1 = N'SELECT Distinct(Solicitud.id), Servicio.Servicio, Solicitud.Descripcion,
					 Servicio.idDependencia,Dependencia.Dependencia,Colonia.Colonia,Colonia.id as IdColonia,
					 CONVERT(char(20),SolicitudEstado.FechaHora, 113)  as FechaHora
					FROM Solicitud
					INNER JOIN Servicio ON Solicitud.IdServicio = Servicio.Id
					INNER JOIN Dependencia ON Dependencia.Id=Servicio.IdDependencia
					INNER JOIN Colonia ON Colonia.id = Solicitud.idcolonia
					INNER JOIN SolicitudEstado ON Solicitud.Id = SolicitudEstado.IdSolicitud'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

SET @QUERY_P2 = N'dbo.GetLastEstadoByIdSolicitud(Solicitud.id)='+char(39)+'Confirmado'+CHAR(39)+'and solicitudestado.idsolicitudestado=dbo.GetFirstSolicitudEstadoByIdSolicitud(Solicitud.id)'
SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IdCaptura IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'SolicitudEstado.IdCaptura=@IdCaptura'           
            SET @PREVIO = 1            
END
---------------------------
IF @IdDependencia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Servicio.IdDependencia=@IdDependencia'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@IdCaptura,@IdDependencia
	SET @cuantas = @@ROWCOUNT
--PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END








GO
/****** Object:  StoredProcedure [dbo].[proc_getCapturasRealizadas]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getCapturasRealizadas]
(
	@cuantas int output,
	@IdCaptura varchar(50)=null,
	@IdDependencia smallint=null		
)

AS

BEGIN
	SET LANGUAGE Español
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IdCaptura varchar(50),@IdDependencia smallint'
    
    SET @QUERY_P1 = N'SELECT Distinct(Solicitud.id), Servicio.Servicio, Solicitud.Descripcion,
					 Servicio.idDependencia,Dependencia.Dependencia,Colonia.Colonia,Colonia.id as IdColonia,
					 CONVERT(char(20),SolicitudEstado.FechaHora, 113)  as FechaHora
					FROM Solicitud
					INNER JOIN Servicio ON Solicitud.IdServicio = Servicio.Id
					INNER JOIN Dependencia ON Dependencia.Id=Servicio.IdDependencia
					INNER JOIN Colonia ON Colonia.id = Solicitud.idcolonia
					INNER JOIN SolicitudEstado ON Solicitud.Id = SolicitudEstado.IdSolicitud'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

SET @QUERY_P2 = N'dbo.GetLastEstadoByIdSolicitud(Solicitud.id)='+char(39)+'Realizado'+CHAR(39)+'and solicitudestado.idsolicitudestado=dbo.GetFirstSolicitudEstadoByIdSolicitud(Solicitud.id)'
SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IdCaptura IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'SolicitudEstado.IdCaptura=@IdCaptura'           
            SET @PREVIO = 1            
END
---------------------------
IF @IdDependencia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Servicio.IdDependencia=@IdDependencia'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@IdCaptura,@IdDependencia
	SET @cuantas = @@ROWCOUNT
--PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END








GO
/****** Object:  StoredProcedure [dbo].[proc_getCapturasSuspendidas]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getCapturasSuspendidas]
(
	@cuantas int output,
	@IdCaptura varchar(50)=null,
	@IdDependencia smallint=null		
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IdCaptura varchar(50),@IdDependencia smallint'
    
    SET @QUERY_P1 = N'SELECT Distinct(Solicitud.id),Servicio.Id as idservicio, Servicio.Servicio, Solicitud.Descripcion,
					 Servicio.idDependencia,Dependencia.Dependencia,Colonia.id as IdColonia,
					 CONVERT(char(20),SolicitudEstado.FechaHora, 113)  as FechaHora
					FROM Solicitud
					INNER JOIN Servicio ON Solicitud.IdServicio = Servicio.Id
					INNER JOIN Dependencia ON Dependencia.Id=Servicio.IdDependencia
					INNER JOIN Colonia ON Colonia.id = Solicitud.idcolonia
					INNER JOIN SolicitudEstado ON Solicitud.Id = SolicitudEstado.IdSolicitud'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

SET @QUERY_P2 = N'dbo.GetLastEstadoByIdSolicitud(Solicitud.id)='+char(39)+'Correccion'+CHAR(39)+'and solicitudestado.idsolicitudestado=dbo.GetFirstSolicitudEstadoByIdSolicitud(Solicitud.id)'
SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IdCaptura IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'SolicitudEstado.IdCaptura=@IdCaptura'           
            SET @PREVIO = 1            
END
---------------------------
IF @IdDependencia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Servicio.IdDependencia=@IdDependencia'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@IdCaptura,@IdDependencia
	SET @cuantas = @@ROWCOUNT
--PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END






GO
/****** Object:  StoredProcedure [dbo].[proc_GetCiudadanoById]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create PROCEDURE [dbo].[proc_GetCiudadanoById]
	(
		@idCiudadano int		
	)
AS
	BEGIN	
		SET NOCOUNT ON 		
		SELECT Ciudadano.Id, Nombre, ApellidoP, ApellidoM, Direccion, NumeroExt/*, NumeroInt*/, Ciudadano.IdColonia,Colonia,Localidad.Id as 'idLoc', Localidad, Telefono, TelefonoAlt, CorreoE/*, CorreoEAlt, Asociacion*/, Sexo, Ciudadano.fechaNac
		FROM Localidad
		INNER JOIN Colonia ON Localidad.Id = Colonia.idLocalidad
		INNER JOIN Ciudadano ON Ciudadano.IdColonia = Colonia.Id
		INNER JOIN RelSolCiud ON Ciudadano.Id = RelSolCiud.IdCiudadano
		INNER JOIN Solicitud ON RelSolCiud.IdSolicitud=Solicitud.Id
		WHERE Ciudadano.Id=@idCiudadano
	END
GO
/****** Object:  StoredProcedure [dbo].[proc_getColonia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[proc_getColonia]
	(
		@cuantas int output
	)
AS
	BEGIN
		select Colonia.id, Colonia.Colonia,Colonia.IdLocalidad, Localidad.Localidad 
		from dbo.Colonia, dbo.Localidad 
		where Colonia.idLocalidad = Localidad.id order by Localidad, Colonia;
		SET @cuantas=@@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[proc_getColoniasByID]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[proc_getColoniasByID]
(
	@IdColonia int,
	@estado varchar(25)=null
)
AS
BEGIN

	SELECT Estado.id as idEstado, Estado.Estado, servicio.Servicio, solicitud.id, solicitud.descripcion, dbo.GetFechaCreacion(solicitud.id) AS Fecha, 
		Dependencia.Dependencia, Dependencia.Id As IdDependencia,Servicio.Id As IdServicio,Colonia.Id as 'idColonia',Colonia.Colonia,SolicitudEstado.IdCaptura,
		DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),GETDATE()) as  'hrs',
		DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado_02(solicitud.id)) as  'hrsCorriente'
		
	FROM Dependencia
	INNER JOIN Servicio		ON Dependencia.id=Servicio.IdDependencia
	INNER JOIN Solicitud		ON Servicio.id=Solicitud.idServicio
	INNER JOIN SolicitudEstado	ON Solicitud.id=SolicitudEstado.idSolicitud
	INNER JOIN Estado		ON SolicitudEstado.IdEstado= Estado.id
	INNER JOIN Colonia		ON Solicitud.IdColonia=Colonia.Id

	WHERE 
		SolicitudEstado.idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id) 		
		AND Colonia.Id=@IdColonia
		and Estado.id=dbo.GetEstadoIDByName(@estado)	
	ORDER BY Estado.Id, dbo.GetFechaCreacion(solicitud.id)desc

END


GO
/****** Object:  StoredProcedure [dbo].[proc_getConsulta]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getConsulta]
(
	@idCol smallint=null,
	@idDep smallint=null,
	@idServ smallint=null
	
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@idDep smallint,
										@idServ smallint,
										@idCol smallint'
    
    SET @QUERY_P1 = N'SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion, Estado.Estado,  Servicio.IdDependencia,Solicitud.IdServicio, 
			Servicio.Servicio, colonia.Id,Colonia.Colonia, CONVERT(char(20), dbo.getfechacreacion(solicitud.id), 113)  as Fecha,
			DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as hrs
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.Colonia
		ON solicitud.idCOlonia = Colonia.id
		INNER JOIN dbo.Servicio
		ON Solicitud.idServicio=Servicio.id'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

SET @QUERY_P2 = N'idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id)'
SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @idCol IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'colonia.Id=@idCol'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @idDep IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '			
			SET @QUERY_P2 = @QUERY_P2 + N'Servicio.IdDependencia=@idDep'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @idServ IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Solicitud.IdServicio=@idServ'           
            SET @PREVIO = 1        
END

-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N' ORDER BY Solicitud.Id;'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@idDep,@idServ,@idCol
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END



GO
/****** Object:  StoredProcedure [dbo].[proc_GetConsultarByIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[proc_GetConsultarByIdSolicitud]
(
	@idSolicitud int=0
)
AS
	BEGIN		
--	SET NOCOUNT ON
	--convert, 101 mm/dd/yy, 103 dd/mm/yy --103
	SET LANGUAGE Español
	SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion, Estado.Estado,Servicio.IdDependencia,Solicitud.IdServicio, 
			Servicio.Servicio, colonia.Id as 'idColonia',Colonia.Colonia,(datename(dw,dbo.getfechacreacion(solicitud.id))+', '+ CONVERT(char(20), dbo.getfechacreacion(solicitud.id), 113))  as Fecha,
			DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as  'hrs',
			SolicitudEstado.IdCaptura, CONVERT(char(20), dbo.GetLastFechaEstado_02(solicitud.id), 113)  as FechaAvance,
			Dependencia.Dependencia,Localidad.Id as 'idLoc',Localidad.Localidad,Solicitud.Calle,Solicitud.Ref1,Solicitud.Ref2,
			dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) as 'idEstado'
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.Colonia
		ON solicitud.idCOlonia = Colonia.id
		INNER JOIN dbo.Servicio
		ON Solicitud.idServicio=Servicio.id
		INNER JOIN dbo.Dependencia
		ON Dependencia.Id=Servicio.IdDependencia
		INNER JOIN dbo.Localidad
		ON	Localidad.Id=Colonia.IdLocalidad
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) and @idSolicitud=solicitud.id		
		ORDER BY Solicitud.Id
		ASC
	END



GO
/****** Object:  StoredProcedure [dbo].[proc_GetConsultarByIdSolicitudCiudadano]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec [dbo].[proc_GetConsultarByIdSolicitudCiudadano] 8705, 'Entrante'
--exec [dbo].[proc_GetConsultarByIdSolicitud] 6
CREATE PROCEDURE [dbo].[proc_GetConsultarByIdSolicitudCiudadano]
(
	@idSolicitud int=0,
	@estado varchar(25)=null
)
AS
	BEGIN		
--	SET NOCOUNT ON
	--convert, 101 mm/dd/yy, 103 dd/mm/yy --103
	SET LANGUAGE Español
	SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion, Estado.Estado,Servicio.IdDependencia,Solicitud.IdServicio, 
			Servicio.Servicio, colonia.Id as 'idColonia',Colonia.Colonia,(datename(dw,dbo.getfechacreacion(solicitud.id))+', '+ CONVERT(char(20), dbo.getfechacreacion(solicitud.id), 113))  as Fecha,
			DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as  'hrs',
			SolicitudEstado.IdCaptura, CONVERT(char(20), dbo.GetLastFechaEstado_02(solicitud.id), 113)  as FechaAvance,
			Dependencia.Dependencia,Localidad.Id as 'idLoc',Localidad.Localidad,Solicitud.Calle,Solicitud.Ref1,Solicitud.Ref2,
			dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) as 'idEstado',dbo.GetCiudadanoByIdSolicitud(solicitud.id) as 'NombreCiudadano',
			dbo.GetTelCiudadanoByIdSolicitud(solicitud.id) as 'ContactoCiudadano'
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.Colonia
		ON solicitud.idCOlonia = Colonia.id
		INNER JOIN dbo.Servicio
		ON Solicitud.idServicio=Servicio.id
		INNER JOIN dbo.Dependencia
		ON Dependencia.Id=Servicio.IdDependencia
		INNER JOIN dbo.Localidad
		ON	Localidad.Id=Colonia.IdLocalidad		
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) 
		and @idSolicitud=solicitud.id	
		and Estado.id=dbo.GetEstadoIDByName(@estado)	
		ORDER BY Solicitud.Id
		ASC
	END

	--select dbo.GetLastSolicitudEstadoByIdSolicitud(5)
	--select dbo.GetEstadoIDByName('Entrante')	
	--select * from SolicitudEstado where IdSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(5)



GO
/****** Object:  StoredProcedure [dbo].[proc_GetConsultarByIdSolicitudCiudadanoV2]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec [dbo].[proc_GetConsultarByIdSolicitudCiudadano] 8705, 'Entrante'
--exec [dbo].[proc_GetConsultarByIdSolicitud] 6
CREATE PROCEDURE [dbo].[proc_GetConsultarByIdSolicitudCiudadanoV2]
(
	@idSolicitud int=0
)
AS
	BEGIN		
--	SET NOCOUNT ON
	--convert, 101 mm/dd/yy, 103 dd/mm/yy --103
	SET LANGUAGE Español
	SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion, Estado.Estado,Servicio.IdDependencia,Solicitud.IdServicio, 
			Servicio.Servicio, colonia.Id as 'idColonia',Colonia.Colonia,(datename(dw,dbo.getfechacreacion(solicitud.id))+', '+ CONVERT(char(20), dbo.getfechacreacion(solicitud.id), 113))  as Fecha,
			DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as  'hrs',
			SolicitudEstado.IdCaptura, CONVERT(char(20), dbo.GetLastFechaEstado_02(solicitud.id), 113)  as FechaAvance,
			Dependencia.Dependencia,Localidad.Id as 'idLoc',Localidad.Localidad,Solicitud.Calle,Solicitud.Ref1,Solicitud.Ref2,
			dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) as 'idEstado',dbo.GetCiudadanoByIdSolicitud(solicitud.id) as 'NombreCiudadano',
			dbo.GetTelCiudadanoByIdSolicitud(solicitud.id) as 'ContactoCiudadano'
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.Colonia
		ON solicitud.idCOlonia = Colonia.id
		INNER JOIN dbo.Servicio
		ON Solicitud.idServicio=Servicio.id
		INNER JOIN dbo.Dependencia
		ON Dependencia.Id=Servicio.IdDependencia
		INNER JOIN dbo.Localidad
		ON	Localidad.Id=Colonia.IdLocalidad		
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) 
		and @idSolicitud=solicitud.id	
		--and Estado.id=dbo.GetEstadoIDByName(@estado)	
		ORDER BY Solicitud.Id
		ASC
	END

	--select dbo.GetLastSolicitudEstadoByIdSolicitud(5)
	--select dbo.GetEstadoIDByName('Entrante')	
	--select * from SolicitudEstado where IdSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(5)



GO
/****** Object:  StoredProcedure [dbo].[proc_GetConsultarByIdSolicitudGenerico]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec [dbo].[proc_GetConsultarByIdSolicitudCiudadano] 8705, 'Entrante'
--exec [dbo].[proc_GetConsultarByIdSolicitud] 6
create PROCEDURE [dbo].[proc_GetConsultarByIdSolicitudGenerico]
(
	@idSolicitud int=0
	--@estado varchar(25)=null
)
AS
	BEGIN		
--	SET NOCOUNT ON
	--convert, 101 mm/dd/yy, 103 dd/mm/yy --103
	SET LANGUAGE Español
	SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion, Estado.Estado,Servicio.IdDependencia,Solicitud.IdServicio, 
			Servicio.Servicio, colonia.Id as 'idColonia',Colonia.Colonia,(datename(dw,dbo.getfechacreacion(solicitud.id))+', '+ CONVERT(char(20), dbo.getfechacreacion(solicitud.id), 113))  as Fecha,
			DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as  'hrs',
			SolicitudEstado.IdCaptura, CONVERT(char(20), dbo.GetLastFechaEstado_02(solicitud.id), 113)  as FechaAvance,
			Dependencia.Dependencia,Localidad.Id as 'idLoc',Localidad.Localidad,Solicitud.Calle,Solicitud.Ref1,Solicitud.Ref2,
			dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) as 'idEstado',dbo.GetCiudadanoByIdSolicitud(solicitud.id) as 'NombreCiudadano',
			dbo.GetTelCiudadanoByIdSolicitud(solicitud.id) as 'ContactoCiudadano'
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.Colonia
		ON solicitud.idCOlonia = Colonia.id
		INNER JOIN dbo.Servicio
		ON Solicitud.idServicio=Servicio.id
		INNER JOIN dbo.Dependencia
		ON Dependencia.Id=Servicio.IdDependencia
		INNER JOIN dbo.Localidad
		ON	Localidad.Id=Colonia.IdLocalidad		
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) 
		and @idSolicitud=solicitud.id	
		--and Estado.id=dbo.GetEstadoIDByName(@estado)	
		ORDER BY Solicitud.Id
		ASC
	END

	--select dbo.GetLastSolicitudEstadoByIdSolicitud(5)
	--select dbo.GetEstadoIDByName('Entrante')	
	--select * from SolicitudEstado where IdSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(5)



GO
/****** Object:  StoredProcedure [dbo].[proc_GetConsultarByIdSolicitudMobil]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[proc_GetConsultarByIdSolicitudMobil]
(
	@idSolicitud int=0
)
AS
	BEGIN		
--	SET NOCOUNT ON
	--convert, 101 mm/dd/yy, 103 dd/mm/yy --103
	SET LANGUAGE Español
	SELECT Solicitud.Id as idsolicitud, Solicitud.Descripcion, Estado.Estado,Servicio.Servicio, 
			CONVERT(char(20), dbo.GetLastFechaEstado_02(solicitud.id), 113)  as FechaAvance,
			Dependencia.Dependencia
		FROM dbo.Estado
		INNER JOIN dbo.SolicitudEstado
		ON Estado.id=SolicitudEstado.idEstado
		INNER JOIN dbo.Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN dbo.Colonia
		ON solicitud.idCOlonia = Colonia.id
		INNER JOIN dbo.Servicio
		ON Solicitud.idServicio=Servicio.id
		INNER JOIN dbo.Dependencia
		ON Dependencia.Id=Servicio.IdDependencia
		INNER JOIN dbo.Localidad
		ON	Localidad.Id=Colonia.IdLocalidad
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(solicitud.id) and @idSolicitud=solicitud.idtmp	
		ORDER BY Solicitud.Id
		ASC
	END



GO
/****** Object:  StoredProcedure [dbo].[proc_getdependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[proc_getdependencia]
	(
		@cuantas int output,
		@IdUsuario bigint=null,
		@tipo smallint=1
	)
AS
	BEGIN
	if(@tipo=1)
		begin
		SELECT Id
			  ,Dependencia
			  ,Descripcion
			  ,Ubicacion
			  ,Telefono
			  ,CorreoE			  
			  ,idTiempo
			  ,trDescripcion
			  ,trVerde
			  ,trAmarillo
			  ,trNaranja
			  ,trRojo,0 as iAppID, 0 as idrel
  FROM dbo.view_getDependenciaWithTiempos
  order by Dependencia
  end
  if(@tipo=2)
		begin
			SELECT Id, Dependencia, Descripcion, Ubicacion, Telefono, CorreoE, idTiempo, trDescripcion, trVerde, trAmarillo, trNaranja, trRojo, iAppID,idrel
			FROM   view_depenciaByUsuario
			where iAppID=@IdUsuario
			order by Dependencia
		end

SET @cuantas=@@ROWCOUNT
	END



GO
/****** Object:  StoredProcedure [dbo].[proc_getDependenciaByUsuario]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

create PROCEDURE [dbo].[proc_getDependenciaByUsuario]
(
	--@cuantas int output,
	@IdUsuario bigint=null	
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IdUsuario bigint'
    
    SET @QUERY_P1 = N'SELECT Id, Dependencia, Descripcion, Ubicacion, Telefono, CorreoE, idTiempo, trDescripcion, trVerde, trAmarillo, trNaranja, trRojo, iAppID
						FROM   view_depenciaByUsuario'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IdUsuario IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			--SET @QUERY_P2 = @QUERY_P2 + N'SolicitudEstado.IdCaptura like %@IdCaptura%'
			SET @QUERY_P2 = @QUERY_P2 + N'iAppID ='+@IdUsuario
            SET @PREVIO = 1            
END

-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@IdUsuario
	--SET @cuantas = @@ROWCOUNT
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END





GO
/****** Object:  StoredProcedure [dbo].[proc_getDependenciasByID]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[proc_getDependenciasByID]
(
	@IdDependencia int
)
AS
BEGIN

	SELECT Estado.id as idEstado, Estado.Estado,servicio.Id as IdServicio, servicio.Servicio, solicitud.id, solicitud.descripcion, dbo.GetFechaCreacion(solicitud.id) AS FechaCreacion, 
		Dependencia.Dependencia, Dependencia.Id As IdDependencia,Colonia.Id as idColonia, Colonia.Colonia,
		DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),GETDATE()) as  'hrs',
		DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado_02(solicitud.id)) as  'hrsCorriente'
		
	FROM Dependencia
	INNER JOIN Servicio		ON Dependencia.id=Servicio.IdDependencia
	INNER JOIN Solicitud		ON Servicio.id=Solicitud.idServicio
	INNER JOIN SolicitudEstado	ON Solicitud.id=SolicitudEstado.idSolicitud
	INNER JOIN Estado		ON SolicitudEstado.IdEstado= Estado.id
	INNER JOIN Colonia ON Colonia.id = Solicitud.idcolonia

	WHERE 
		SolicitudEstado.idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id) 		
		AND Dependencia.Id=@idDependencia
	ORDER BY Estado.Id, dbo.GetFechaCreacion(solicitud.id)desc

END

GO
/****** Object:  StoredProcedure [dbo].[proc_getEstado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_getEstado]
	(
		@cuantas int output
	)
AS
	BEGIN
		SELECT Id
      ,Estado
      ,Descripcion
      ,EstadoCiudadano
      ,IdEdoCiudadano
  FROM dbo.Estado
		SET @cuantas=@@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[proc_getFormaDeContacto]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[proc_getFormaDeContacto]
	(
		@cuantas int output
	)
AS
	BEGIN
		select * from dbo.formacontacto order by formacontacto.idformacontacto
		SET @cuantas=@@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[proc_getReporteEstadosByDependencias]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[proc_getReporteEstadosByDependencias]
(	
	@cuantas int output
)
AS
	BEGIN
		select count(sol.IdServicio) as Total,d.Id,d.Dependencia ,e.Estado from Solicitud sol
					inner join Servicio s on s.Id=sol.IdServicio
					inner join Dependencia d on d.Id=s.IdDependencia
					inner join SolicitudEstado se on se.IdSolicitud=sol.Id 
					inner join Estado e on e.Id=se.IdEstado
					
					where se.IdSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(sol.Id)
					
					group by d.Id,d.Dependencia,e.Estado
					order by d.Dependencia
		SET @cuantas = @@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[proc_getseguridad]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[proc_getseguridad]
	(			
		@iAppLogin varchar(20)='',		
		@iAppPwd varchar(250)=''
	)
AS
	SET NOCOUNT ON 			
	SELECT u.iAppID
      ,u.iAppLogin
      ,u.iAppNombreC
      ,u.iAppCorreo
      ,u.iAppPwd
      ,u.iAppAudiencia
	  ,u.iAppActivo
	  ,u.IDROL
	  ,r.ROL
  FROM seguridad.esAppWebUsuario u
  inner join seguridad.ROL r
  on r.IDROL=u.IDROL
  where iAppLogin=@iAppLogin and iAppPwd=@iAppPwd 




GO
/****** Object:  StoredProcedure [dbo].[proc_getServicioByID]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[proc_getServicioByID]
(
	@idServicio int
)
AS
BEGIN

	SELECT idEstado, Estado.Estado, servicio.Servicio, solicitud.id, solicitud.descripcion, dbo.GetFechaCreacion(solicitud.id) AS FechaCreacion,
	Servicio.Id As IdServicio,DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),GETDATE()) as  'hrs',
	DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado_02(solicitud.id)) as  'hrsCorriente'
		
	FROM Dependencia
	INNER JOIN Servicio		ON Dependencia.id=Servicio.IdDependencia
	INNER JOIN Solicitud		ON Servicio.id=Solicitud.idServicio
	INNER JOIN SolicitudEstado	ON Solicitud.id=SolicitudEstado.idSolicitud
	INNER JOIN Estado		ON SolicitudEstado.IdEstado= Estado.id

	WHERE 
		SolicitudEstado.idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id) 
		AND Servicio.Id=@idServicio

	ORDER BY Estado.Id, Solicitud.id

END

GO
/****** Object:  StoredProcedure [dbo].[proc_getServicios]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[proc_getServicios]
	(
		@cuantas int output
	)
AS
	BEGIN
		SELECT idServicio
			  ,Servicio
			  ,idDep
			  ,Descripcion
			  ,Dependencia_Dependencia
			  ,trVerde
			  ,trAmarillo
			  ,trNaranja
			  ,trRojo
		FROM dbo.view_getServicio_dependencia_tiempoDepencia
		order by Servicio,Dependencia_Dependencia;
		SET @cuantas=@@ROWCOUNT
	END


GO
/****** Object:  StoredProcedure [dbo].[proc_getSolicitudesFiltradasByDependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getSolicitudesFiltradasByDependencia]
(
	@idSolicitud int=null,
	@idDependencia  smallint=null,
	@Estado varchar(20)=null,
	@idColonia smallint=null,
	@idServicio smallint=null,
	@prioridad bit=null
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(2024)
    DECLARE @QUERY_P2 NVARCHAR(2024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(1024) = '@idSolicitud int,
										@idDependencia  smallint,
										@Estado varchar(20),
										@idColonia smallint,
										@idServicio smallint,
										@prioridad bit'
    
    SET @QUERY_P1 = N'SELECT Solicitud.id, SolicitudEstado.FechaHora as FechaCreacion,Estado.Estado,Estado.id as idEstado, Servicio.Servicio, Colonia.Colonia,Colonia.id as idColonia, Solicitud.Descripcion,Dependencia.id as idDependencia ,
					SolicitudEstado.IdCaptura,CAST((Solicitud.Calle +'+char(39)+', Entre '+char(39)+'+ Solicitud.Ref1 +'+char(39)+' y '+char(39)+'+ Solicitud.Ref2 +'+char(39)+' Col. '+char(39)+'+ Colonia.Colonia) as varchar(255)) as '+char(39)+'Direccion'+char(39)+',
					Localidad.Localidad,Servicio.id as idServicio,
					DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as '+char(39)+'hrs'+char(39)+',
					DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado_02(solicitud.id)) as'+char(39)+'hrsCorriente'+char(39)+'
					FROM SolicitudEstado
					INNER JOIN Solicitud
					ON SolicitudEstado.idSolicitud=Solicitud.id
					INNER JOIN Servicio
					ON Solicitud.idServicio=Servicio.id
					INNER JOIN Colonia
					ON Colonia.id = Solicitud.idcolonia
					INNER JOIN Localidad
					ON Localidad.Id=Colonia.IdLocalidad
					INNER JOIN Estado
					ON SolicitudEstado.IdEstado= Estado.id
					INNER JOIN dbo.Dependencia
					ON Dependencia.Id=Servicio.IdDependencia'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

SET @QUERY_P2 = N'idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id)'
SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @idSolicitud IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Solicitud.id=@idSolicitud'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @idDependencia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Servicio.IdDependencia=@idDependencia'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @Estado IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'idEstado = (select id FROM dbo.Estado WHERE Estado=@Estado)'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @idColonia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Colonia.id=@idColonia'             
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @idServicio IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Servicio.id=@idServicio'             
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @prioridad IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Solicitud.prioritario=@prioridad'             
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@idSolicitud,
										@idDependencia,
										@Estado,
										@idColonia,
										@idServicio,
										@prioridad
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END








GO
/****** Object:  StoredProcedure [dbo].[proc_getSolicitudesFiltradasByDependenciaAndEstado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getSolicitudesFiltradasByDependenciaAndEstado]
(
	@idSolicitud int=null,
	@idDependencia  smallint=null,
	@Estado varchar(20)=null,
	@idColonia smallint=null,
	@idServicio smallint=null,
	@prioridad bit=null,
	@fechaIni varchar(20)=null,
	@fechaFin varchar(20)=null
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(2024)
    DECLARE @QUERY_P2 NVARCHAR(2024)
    DECLARE @PREVIO BIT 
    SET Language Español
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(1024) = '@idSolicitud int,
										@idDependencia  smallint,
										@Estado varchar(20),
										@idColonia smallint,
										@idServicio smallint,
										@prioridad bit,
										@fechaIni varchar(20),
										@fechaFin varchar(20)'
    
    SET @QUERY_P1 = N'SELECT Solicitud.id, convert(char(21),SolicitudEstado.FechaHora,22) as FechaHora, Servicio.Servicio,Solicitud.Descripcion,
					CAST((Solicitud.Calle +'+char(39)+', Entre '+char(39)+'+ Solicitud.Ref1 +'+char(39)+' y '+char(39)+'+ Solicitud.Ref2 +'+char(39)+' Col. '+char(39)+'+ Colonia.Colonia) as varchar(255)) as '+char(39)+'Direccion'+char(39)+',
					dbo.GetLastEstadoByIdSolicitud(solicitud.id) as '+char(39)+'Estatus'+char(39)+',
					DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado(solicitud.id)) as '+char(39)+'hrs'+char(39)+',
					Colonia.Colonia,
					SolicitudEstado.IdCaptura,
					Localidad.Localidad,Servicio.id as idServicio
					FROM SolicitudEstado
					INNER JOIN Solicitud
					ON SolicitudEstado.idSolicitud=Solicitud.id
					INNER JOIN Servicio
					ON Solicitud.idServicio=Servicio.id
					INNER JOIN Colonia
					ON Colonia.id = Solicitud.idcolonia
					INNER JOIN Localidad
					ON Localidad.Id=Colonia.IdLocalidad'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

SET @QUERY_P2 = N'idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id)'
SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @idSolicitud IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Solicitud.id=@idSolicitud'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @idDependencia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Servicio.IdDependencia=@idDependencia'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @Estado IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'idEstado = (select id FROM dbo.Estado WHERE Estado=@Estado)'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @idColonia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Colonia.id=@idColonia'             
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @idServicio IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Servicio.id=@idServicio'             
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @prioridad IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'Solicitud.prioritario=@prioridad'             
            SET @PREVIO = 1            
END

-------------------------------------------------------------------------------------
IF @fechaIni IS NOT NULL and @fechaFin IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'SolicitudEstado.FechaHora between convert(smalldatetime,@fechaIni) and convert(smalldatetime,@fechaFin)'             
            SET @PREVIO = 1            
END

-------------------------------------------------------------------------------------

 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N' order by SolicitudEstado.IdEstado;'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@idSolicitud,
										@idDependencia,
										@Estado,
										@idColonia,
										@idServicio,
										@prioridad,
										@fechaIni,
										@fechaFin
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END










GO
/****** Object:  StoredProcedure [dbo].[proc_getSolicitudesGlobales]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[proc_getSolicitudesGlobales]
(
	@cuantas bigint output
)
AS
BEGIN

	SELECT Estado.id as idEstado, Estado.Estado, servicio.Servicio, solicitud.id, solicitud.descripcion, dbo.GetFechaCreacion(solicitud.id) AS Fecha, 
		Dependencia.Dependencia, Dependencia.Id As IdDependencia,Servicio.Id As IdServicio,Colonia.Id as 'idColonia',Colonia.Colonia,
		DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),GETDATE()) as  'hrs',
		DateDiff(hour,dbo.GetFechaCreacion(solicitud.id),dbo.GetLastFechaEstado_02(solicitud.id)) as  'hrsCorriente'
		
	FROM Dependencia
	INNER JOIN Servicio		ON Dependencia.id=Servicio.IdDependencia
	INNER JOIN Solicitud		ON Servicio.id=Solicitud.idServicio
	INNER JOIN SolicitudEstado	ON Solicitud.id=SolicitudEstado.idSolicitud
	INNER JOIN Estado		ON SolicitudEstado.IdEstado= Estado.id
	INNER JOIN Colonia		ON Solicitud.IdColonia=Colonia.Id

	WHERE 
		SolicitudEstado.idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id) 				
	ORDER BY Estado.Id, dbo.GetFechaCreacion(solicitud.id)desc
	set @cuantas=@@ROWCOUNT

END



GO
/****** Object:  StoredProcedure [dbo].[proc_getSolicitudesGroupByCol_Dep_Anio]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getSolicitudesGroupByCol_Dep_Anio]
(
	@idDependencia  smallint=null,	
	@idColonia smallint=null,	
	@anio varchar(4)=null
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(2024)
    DECLARE @QUERY_P2 NVARCHAR(2024)
    DECLARE @QUERY_GB NVARCHAR(2024)
    DECLARE @PREVIO BIT 
    --declare @f1 varchar(10);
    --declare @f2 varchar(10)   
    --set @f1=N'01-01-'+isnull(@anio,YEAR(getdate()))
    --set @f2=N'31-12-'+isnull(@anio,YEAR(getdate()))
    
    SET Language Español
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(1024) = '@idDependencia  smallint,										
										@idColonia smallint,										
										@anio varchar(4)'
    
    SET @QUERY_P1 = N'select count(sol.IdServicio) as Total,s.Id,s.Servicio from Solicitud sol
					inner join Servicio s on s.Id=sol.IdServicio
					inner join Dependencia d on d.Id=s.IdDependencia
					inner join SolicitudEstado se on se.IdSolicitud=sol.Id'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

SET @QUERY_GB = N' group by s.Id,s.Servicio '
SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @idDependencia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 --+ N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'd.Id=@idDependencia'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @idColonia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'sol.IdColonia=@idColonia'             
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @anio IS NOT NULL
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'dbo.GetFechaCreacion(sol.Id) between convert(datetime, '+char(39)+'01-01-'+@anio+char(39)+') and convert(datetime,'+char(39)+'31-12-'+@anio+char(39)+')'             
            SET @PREVIO = 1            
END

-------------------------------------------------------------------------------------

 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + @QUERY_GB + N'order by Total;'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@idDependencia,										
										@idColonia,
										@anio
									
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END












GO
/****** Object:  StoredProcedure [dbo].[proc_getSolicitudesGroupByCol_Dep_Estado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getSolicitudesGroupByCol_Dep_Estado]
(
	@idDependencia  smallint=null,	
	@idColonia smallint=null,	
	@anio varchar(4)=null,
	@estado smallint=null
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(2024)
    DECLARE @QUERY_P2 NVARCHAR(2024)
    DECLARE @QUERY_GB NVARCHAR(2024)
    DECLARE @PREVIO BIT    
    
    SET Language Español
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(1024) = '@idDependencia  smallint,										
										@idColonia smallint,										
										@anio varchar(4),
										@estado smallint'
    
    SET @QUERY_P1 = N'select count(sol.IdServicio) as Total,s.Id,s.Servicio,e.Estado from Solicitud sol
					inner join Servicio s on s.Id=sol.IdServicio
					inner join Dependencia d on d.Id=s.IdDependencia
					inner join SolicitudEstado se on se.IdSolicitud=sol.Id 
					inner join Estado e on e.Id=se.IdEstado'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

SET @QUERY_GB = N' group by Servicio.Id,s.Id,s.Servicio,e.Estado '
SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @idDependencia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 --+ N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'd.Id=@idDependencia'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @idColonia IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'sol.IdColonia=@idColonia'             
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @anio IS NOT NULL
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'dbo.GetFechaCreacion(sol.Id) between convert(datetime, '+char(39)+'01-01-'+@anio+char(39)+') and convert(datetime,'+char(39)+'31-12-'+@anio+char(39)+')'             
            SET @PREVIO = 1            
END

-------------------------------------------------------------------------------------
IF @estado IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'e.Id=@estado'             
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------

 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + @QUERY_GB + N'order by Total;'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@idDependencia,										
										@idColonia,
										@anio,
										@estado
									
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END












GO
/****** Object:  StoredProcedure [dbo].[proc_getSolicitudesTemp]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE  PROCEDURE [dbo].[proc_getSolicitudesTemp]
	(
		@cuantas int output
	)
AS
	BEGIN
		--use COLLATE  Traditional_Spanish_CI_AS
		--DATENAME(WEEKDAY,FechaHora)  +', '+
		select Id,'Reporte # '+convert(varchar(18),Id) as 'nReporte',
		( CONVERT(varchar(50),FechaHora,113)) AS 'FechaHora01',FechaHora
		from dbo.SolicitudTemp 
		where Eliminado=0 order by FechaHora desc 
		
		SET @cuantas=@@ROWCOUNT
	END



GO
/****** Object:  StoredProcedure [dbo].[proc_getSolicitudesTemp_Movil]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE  PROCEDURE [dbo].[proc_getSolicitudesTemp_Movil]
	(
		@cuantas int output
	)
AS
	BEGIN
		SET LANGUAGE Español
		--use COLLATE  Traditional_Spanish_CI_AS
		--DATENAME(WEEKDAY,FechaHora)  +', '+
		select idtmp,'Reporte # '+convert(varchar(18),idtmp) as 'nReporte',
		( CONVERT(varchar(50),fechahora,113)) AS 'FechaHora01',fechahora,problema
		from dbo.SolicitudTempMovil 
		where eliminado=0 order by fechahora desc 
		
		SET @cuantas=@@ROWCOUNT
	END

	--select *  from dbo.SolicitudTempMovil 




GO
/****** Object:  StoredProcedure [dbo].[proc_getSolicitudesTemporales]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getSolicitudesTemporales]
(
	@cuantas int output,
	@idsoltmp int=null,
	@activo bit=null		
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(2024)
    DECLARE @QUERY_P2 NVARCHAR(2024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(1024) = '@idsoltmp int,@activo bit'
    
    SET @QUERY_P1 = N'SELECT SolicitudTemp.Id
						  ,SolicitudTemp.Nombre
						  ,SolicitudTemp.ApellidoP
						  ,SolicitudTemp.ApellidoM
						  ,SolicitudTemp.Direccion
						  ,SolicitudTemp.NumeroExt
						  ,SolicitudTemp.NumeroInt
						  ,SolicitudTemp.IdColonia as idColCiud
						  ,SolicitudTemp.Sexo
						  ,SolicitudTemp.CorreoE
						  ,SolicitudTemp.CorreoEAlt
						  ,SolicitudTemp.Telefono
						  ,SolicitudTemp.TelefonoAlt
						  ,SolicitudTemp.Asociacion
						  ,SolicitudTemp.Edad
						  ,SolicitudTemp.Descripcion
						  ,SolicitudTemp.IdCol as idColSol
						  ,SolicitudTemp.Calle
						  ,SolicitudTemp.Ref1
						  ,SolicitudTemp.Ref2
						  ,SolicitudTemp.FechaHora
						  ,SolicitudTemp.Eliminado
						  ,isnull(SolicitudTemp.fechaNac,getdate()) as FechaNac						  
						  ,(select IdLocalidad from Colonia where Id=SolicitudTemp.IdCol)as idLocSol
						  ,(select IdLocalidad from Colonia where Id=SolicitudTemp.IdColonia)as idLocCiud
					  FROM dbo.SolicitudTemp					 
					  '
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

--SET @QUERY_P2 = N''--dbo.GetLastEstadoByIdSolicitud(Solicitud.id)='+char(39)+'Correccion'+CHAR(39)+'and solicitudestado.idsolicitudestado=dbo.GetFirstSolicitudEstadoByIdSolicitud(Solicitud.id)'
--SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @idsoltmp IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'SolicitudTemp.Id=@idsoltmp'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @activo IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'SolicitudTemp.Eliminado=@activo'           
            SET @PREVIO = 1            
END

-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@idsoltmp,@activo
	SET @cuantas = @@ROWCOUNT
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END






GO
/****** Object:  StoredProcedure [dbo].[proc_getSolicitudesTemporales_Moviles]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Created by jmatias 18.10.13
-- Procedimiento consulta de solicitudes
*/
	

CREATE PROCEDURE [dbo].[proc_getSolicitudesTemporales_Moviles]
(
	@cuantas int output,
	@idsoltmp int=null,
	@activo bit=null		
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(2024)
    DECLARE @QUERY_P2 NVARCHAR(2024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(1024) = '@idsoltmp int,@activo bit'
    
    SET @QUERY_P1 = N'SELECT SolicitudTempMovil.idtmp
						  ,SolicitudTempMovil.nombrecompleto
						  ,SolicitudTempMovil.idcoloniap
						  ,SolicitudTempMovil.direccion
						  ,SolicitudTempMovil.telefono
						  ,SolicitudTempMovil.correoe
						  ,SolicitudTempMovil.problema
						  ,SolicitudTempMovil.idcolonia as idColCiud
						  ,SolicitudTempMovil.ref01
						  ,SolicitudTempMovil.ref02						 
						  ,SolicitudTempMovil.fechahora
						  ,SolicitudTempMovil.eliminado	
						    ,SolicitudTempMovil.img_solicitud	
							  ,SolicitudTempMovil.logintud	
							    ,SolicitudTempMovil.latitud	
								  ,SolicitudTempMovil.fechaNac						  				  
						  ,(select IdLocalidad from Colonia where Id=SolicitudTempMovil.idcoloniap)as idLocSol
						  ,(select IdLocalidad from Colonia where Id=SolicitudTempMovil.idcolonia)as idLocCiud
					  FROM dbo.SolicitudTempMovil					 
					  '
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

--SET @QUERY_P2 = N''--dbo.GetLastEstadoByIdSolicitud(Solicitud.id)='+char(39)+'Correccion'+CHAR(39)+'and solicitudestado.idsolicitudestado=dbo.GetFirstSolicitudEstadoByIdSolicitud(Solicitud.id)'
--SET @PREVIO = 1
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @idsoltmp IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'SolicitudTempMovil.idtmp=@idsoltmp'           
            SET @PREVIO = 1            
END
-------------------------------------------------------------------------------------
IF @activo IS NOT NULL 
BEGIN 
            IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'SolicitudTempMovil.eliminado=@activo'           
            SET @PREVIO = 1            
END

-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@idsoltmp,@activo
	SET @cuantas = @@ROWCOUNT
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END







GO
/****** Object:  StoredProcedure [dbo].[proc_getTiempoRespuestaByDep]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[proc_getTiempoRespuestaByDep]
	(
		@idDep smallint=0
	)
AS
	SET NOCOUNT ON 		
		select dp.Id, tr.idTiempo,tr.descripcion,tr.verde,tr.amarillo,tr.naranja,tr.rojo 
		from Dependencia dp
		inner join TiempoRespuesta tr
		on dp.idTiempo=tr.idTiempo
		where dp.Id=@idDep

GO
/****** Object:  StoredProcedure [dbo].[proc_sendEmailPLAN]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[proc_sendEmailPLAN]
	(
		@perfil varchar(50)='',		
		@para varchar(200)='',
		@titulo varchar(255)='',
		@cuerpo nvarchar(1024)='',
		@archivo varchar(255)=''
	)
AS
	SET NOCOUNT ON 		
		EXEC  msdb.dbo.sp_send_dbmail	@profile_name=@perfil, 
										@recipients= @para,
										@subject= @titulo,
										@body= @cuerpo,
										@file_attachments = @archivo
	RETURN @@ERROR


GO
/****** Object:  StoredProcedure [dbo].[proc_sendEmailSIMAC]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[proc_sendEmailSIMAC]
	(
		@perfil varchar(50)='',		
		@para varchar(200)='',
		@titulo varchar(255)='',
		@cuerpo nvarchar(1024)=''
	)
AS
	SET NOCOUNT ON 		
		EXEC  msdb.dbo.sp_send_dbmail	@profile_name=@perfil, 
										@recipients= @para,
										@subject= @titulo,
										@body= @cuerpo					
	RETURN @@ERROR

GO
/****** Object:  StoredProcedure [dbo].[proc_sendEmailSIMAC_HTML]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[proc_sendEmailSIMAC_HTML]
	(
		@perfil varchar(50)='',		
		@para varchar(200)='',
		@titulo varchar(255)='',		
		@folio varchar(10)=''
		--@archivo varchar(max)=null
	)
AS
	declare @html varchar(max),
	 @TableTail varchar(max),
	 @file varchar(max)
	SET NOCOUNT ON 	
	Set @TableTail = '</table></body></html>';
	--Set @file = '\\172.16.2.229\E$\Kepler\imgCorreo\fondoSIMAC.jpg';
	--Set @file = '\\172.16.2.229\v$\fondoSIMAC.jpg';
	Set @html=N'<html>
				<head>
				<meta charset="utf-8">
				</head>
				<body>

  <table border="0px" WIDTH="600" height="850" background="http://www.tesoreriacoatzacoalcos.gob.mx/img/fondoSIMAC.png"> 
  
   <tr>  
  <td  style="text-align:left; font-size:25pt; font-style:bold; padding:0; padding-top:50px">
  <p>Estimado Ciudadano:</p></td>		 
  </tr>
   <tr>  
  <td padding: 0;><p style="text-align: justify;  font-size:18pt">
  		 Usted ha generado un reporte en el sistema municipal de atención ciudadano con número de folio: 
		 </p></td>
  </tr>  
   <tr>  
   <td padding: 0;><p><h1 ALIGN=center><big><big><big>'+
  		@folio +'</big></big></big></h1></p>
  		<br/>
  		<p ALIGN=center>
  		<h2><big>
  		Lo invitamos a darle seguimiento a través del portal:<br/>
		www.coatzacoalcos.gob.mx 
		 </h2></big>
  		</p>
  </td>
  </tr>  
   <tr>  
 <td><h1 ALIGN=center>SIMAC </h1><br/>
 <h5 ALIGN=center >(Sistema Municipal de Atención Ciudadana)</h5>
  </td>
  </tr> '+@TableTail;
		
		
		EXEC  msdb.dbo.sp_send_dbmail	@profile_name=@perfil, 
										@recipients=@para,
										@subject=@titulo,
										--@file_attachments=@archivo,
										@body=@html,
										@body_format = 'HTML';					
	RETURN @@ERROR


GO
/****** Object:  StoredProcedure [dbo].[RealizaSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[RealizaSolicitud]
	(			
		@IdSolicitud int,
		@idCaptura varchar(50),
		@Solucion varchar(1024),
		@Encargado varchar(50),
		@Fecha smalldatetime --Se tiene que verificar la forma de guardado
	)
AS
	SET NOCOUNT ON 		
	DECLARE @NumSolicitudEstado int		
	DECLARE @idEstado int
	--SET LANGUAGE us_english

	SET @idEstado=dbo.GetEstadoIDByName('Realizado')

	INSERT INTO SolicitudEstado (IdSolicitud, IdEstado,FechaHora, IdCaptura)
		VALUES (@IdSolicitud, @idEstado, GETDATE(), @idCaptura)

	SET @NumSolicitudEstado= @@IDENTITY 

	INSERT INTO ServicioRealizado (IdSolicitudEstado, FechaRealizacion, Encargado, Solucion)
		VALUES (@NumSolicitudEstado, @Fecha, @Encargado, @Solucion)

	RETURN @@ERROR


GO
/****** Object:  StoredProcedure [dbo].[ReportGlobal]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ReportGlobal]
AS
BEGIN
	SELECT Dependencia.dependencia, Estado.Estado, servicio.Servicio, 
	solicitud.id, solicitud.descripcion, dbo.GetFechaCreacion(solicitud.id) AS 
	FechaCreacion
	FROM Dependencia
	INNER JOIN Servicio		ON Dependencia.id=Servicio.IdDependencia
	INNER JOIN Solicitud		ON Servicio.id=Solicitud.idServicio
	INNER JOIN SolicitudEstado	ON Solicitud.id=SolicitudEstado.idSolicitud
	INNER JOIN Estado		ON SolicitudEstado.IdEstado= Estado.id
	WHERE 
		SolicitudEstado.idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id) 
	ORDER BY Dependencia.dependencia, estado.Estado, FechaCreacion, Servicio.servicio

END
GO
/****** Object:  StoredProcedure [dbo].[ReportGlobalByDep]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ReportGlobalByDep]
(
	@IdDependencia int
)
AS
BEGIN

	SELECT Estado.id as idEstado, Estado.Estado, servicio.Servicio, solicitud.id, solicitud.descripcion, dbo.GetFechaCreacion(solicitud.id) AS FechaCreacion, Dependencia.Dependencia, Dependencia.Id As IdDependencia
	FROM Dependencia
	INNER JOIN Servicio		ON Dependencia.id=Servicio.IdDependencia
	INNER JOIN Solicitud		ON Servicio.id=Solicitud.idServicio
	INNER JOIN SolicitudEstado	ON Solicitud.id=SolicitudEstado.idSolicitud
	INNER JOIN Estado		ON SolicitudEstado.IdEstado= Estado.id

	WHERE 
		SolicitudEstado.idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id) 		
		AND Dependencia.Id=@idDependencia
	ORDER BY Estado.Estado, Solicitud.id

END
GO
/****** Object:  StoredProcedure [dbo].[ReportGlobalByDepAndEdo]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[ReportGlobalByDepAndEdo]
(
	@IdEstado int,
	@IdDependencia int
)
AS
BEGIN
	SELECT servicio.Servicio, solicitud.id, solicitud.descripcion, dbo.GetFechaCreacion(solicitud.id) AS FechaCreacion, Dependencia, Estado
	FROM Dependencia
	INNER JOIN Servicio		ON Dependencia.id=Servicio.IdDependencia
	INNER JOIN Solicitud		ON Servicio.id=Solicitud.idServicio
	INNER JOIN SolicitudEstado	ON Solicitud.id=SolicitudEstado.idSolicitud
	INNER JOIN Estado		ON SolicitudEstado.IdEstado= Estado.id

	WHERE 
		SolicitudEstado.idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id) 
		AND (Estado.id=@IdEstado)
		AND Dependencia.Id=@idDependencia

	ORDER BY FechaCreacion, Servicio.servicio

END
GO
/****** Object:  StoredProcedure [dbo].[ReportGlobalByServ]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ReportGlobalByServ]
(
	@idServicio int
)
AS
BEGIN

	SELECT idEstado, Estado.Estado, servicio.Servicio, solicitud.id, solicitud.descripcion, dbo.GetFechaCreacion(solicitud.id) AS FechaCreacion, Servicio.Id As IdServicio
	FROM Dependencia
	INNER JOIN Servicio		ON Dependencia.id=Servicio.IdDependencia
	INNER JOIN Solicitud		ON Servicio.id=Solicitud.idServicio
	INNER JOIN SolicitudEstado	ON Solicitud.id=SolicitudEstado.idSolicitud
	INNER JOIN Estado		ON SolicitudEstado.IdEstado= Estado.id

	WHERE 
		SolicitudEstado.idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id) 
		AND Servicio.Id=@idServicio

	ORDER BY Estado.Estado, Solicitud.id

END
GO
/****** Object:  StoredProcedure [dbo].[ReportGlobalByServAndEdo]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[ReportGlobalByServAndEdo]
(
	@IdEstado int,
	@IdServicio int
)
AS
BEGIN
	SELECT servicio.Servicio, solicitud.id, solicitud.descripcion, dbo.GetFechaCreacion(solicitud.id) AS FechaCreacion,  EstadoCiudadano
	FROM Dependencia
	INNER JOIN Servicio		ON Dependencia.id=Servicio.IdDependencia
	INNER JOIN Solicitud		ON Servicio.id=Solicitud.idServicio
	INNER JOIN SolicitudEstado	ON Solicitud.id=SolicitudEstado.idSolicitud
	INNER JOIN Estado		ON SolicitudEstado.IdEstado= Estado.id

	WHERE 
		SolicitudEstado.idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id) 
		AND (Estado.id=@IdEstado)
		AND Servicio.Id=@idServicio

	ORDER BY FechaCreacion, Servicio.servicio

END
GO
/****** Object:  StoredProcedure [dbo].[SelectCapturasDevueltas]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SelectCapturasDevueltas]
(
	@IdCaptura int,
	@cuantas int output
)
AS
	BEGIN
		SELECT Distinct(Solicitud.id), Servicio.Servicio, Solicitud.Descripcion
		FROM --Ciudadano
		--INNER JOIN RelSolCiud ON CIudadano.Id = RelSolCiud.IdCiudadano
		--INNER JOIN 
		Solicitud --ON RelSolCiud.IdSolicitud = Solicitud.Id
		INNER JOIN Servicio ON Solicitud.IdServicio = Servicio.Id
		INNER JOIN SolicitudEstado ON Solicitud.Id = SolicitudEstado.IdSolicitud
		--INNER JOIN Estado ON SolicitudEstado.IdEstado = Estado.Id
		WHERE SolicitudEstado.IdCaptura=@IdCaptura and dbo.GetLastEstadoByIdSolicitud(Solicitud.id)='Corrección' and solicitudestado.idsolicitudestado=dbo.GetFirstSolicitudEstadoByIdSolicitud(Solicitud.id)
		SET @cuantas = @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[SelectCapturasHoy]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SelectCapturasHoy]
(
	@IdCaptura VARCHAR(50), -- ESTABE EN TIPO INT
	@cuantas int output
)
AS
	BEGIN
		SELECT Distinct(Solicitud.id), Servicio.Servicio, Solicitud.Descripcion
		FROM --Ciudadano
		--INNER JOIN RelSolCiud ON CIudadano.Id = RelSolCiud.IdCiudadano
		--INNER JOIN 
		Solicitud --ON RelSolCiud.IdSolicitud = Solicitud.Id
		INNER JOIN Servicio ON Solicitud.IdServicio = Servicio.Id
		INNER JOIN SolicitudEstado ON Solicitud.Id = SolicitudEstado.IdSolicitud
		INNER JOIN Estado ON SolicitudEstado.IdEstado = Estado.Id
		WHERE SolicitudEstado.IdCaptura=@IdCaptura and CONVERT(char(12), SolicitudEstado.FechaHora, 103)=CONVERT(char(12), GETDATE(), 103) and Estado='Entrante'
		and solicitudestado.idsolicitudestado=dbo.GetFirstSolicitudEstadoByIdSolicitud(Solicitud.id)
		SET @cuantas = @@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[SelectCiudadanoWithIdSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SelectCiudadanoWithIdSolicitud]
	(
		@idSolicitud int		
	)
AS
	BEGIN	
		SET NOCOUNT ON 		
		SELECT Ciudadano.Id, Nombre, ApellidoP, ApellidoM, Direccion, NumeroExt/*, NumeroInt*/, Colonia, Localidad, Telefono, TelefonoAlt, CorreoE/*, CorreoEAlt, Asociacion*/, Sexo, Ciudadano.fechaNac
		FROM Localidad
		INNER JOIN Colonia ON Localidad.Id = Colonia.idLocalidad
		INNER JOIN Ciudadano ON Ciudadano.IdColonia = Colonia.Id
		INNER JOIN RelSolCiud ON Ciudadano.Id = RelSolCiud.IdCiudadano
		INNER JOIN Solicitud ON RelSolCiud.IdSolicitud=Solicitud.Id
		WHERE Solicitud.Id=@idSolicitud
	END
GO
/****** Object:  StoredProcedure [dbo].[selectColonias]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[selectColonias]
	(
		@cuantas int output
	)
AS
	BEGIN
		select Colonia.id, Colonia, Localidad.Id,Localidad.Localidad 
		from dbo.Colonia, dbo.Localidad 
		where Colonia.idLocalidad = Localidad.id order by Localidad, Colonia;
		SET @cuantas=@@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[selectColoniasByIdLoc]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[selectColoniasByIdLoc]
	(
		@cuantas int output,
		@idLocalidad smallint
	)
AS
	BEGIN
		select Colonia.id, Colonia, Localidad.Id as IdLocalidad,Localidad.Localidad  
		from dbo.Colonia INNER JOIN dbo.Localidad ON Colonia.idLocalidad=Localidad.id
		where Localidad.id = @idLocalidad order by Localidad, Colonia;
		SET @cuantas=@@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[selectDependencias]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[selectDependencias]
	(
		@cuantas int output
	)
AS
	BEGIN
		select * from dbo.Dependencia order by Dependencia.Dependencia
		SET @cuantas=@@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[selectDependenciasWithServicios]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[selectDependenciasWithServicios]
	(
		@cuantas int output
	)
AS
	BEGIN
		select DISTINCT(Dependencia.id), Dependencia.Dependencia, Dependencia.Descripcion, esOP
		from dbo.Dependencia inner join dbo.Servicio on Dependencia.Id = Servicio.IdDependencia
		order by Dependencia.Dependencia
		SET @cuantas=@@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[selectEstadoCiudadano]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[selectEstadoCiudadano] AS
BEGIN
	SELECT DISTINCT(idEdoCiudadano), EstadoCiudadano
	FROM Estado
END
GO
/****** Object:  StoredProcedure [dbo].[SelectLastComentario]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SelectLastComentario]
(
	@idSolicitud int
)
AS
	SELECT Comentario FROM dbo.Seguimiento
	WHERE idSolicitudEstado = (SELECT Max(idSolicitudEstado) FROM dbo.SolicitudEstado WHERE idSolicitud=@idSolicitud)
GO
/****** Object:  StoredProcedure [dbo].[SelectLastServicioConExito]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create PROCEDURE [dbo].[SelectLastServicioConExito]
(
	@idSolicitud int
)
AS
	SELECT FechaRealizacion, Encargado, Solucion FROM dbo.ServicioRealizado
	WHERE idSolicitudEstado = (SELECT Max(idSolicitudEstado) FROM dbo.SolicitudEstado WHERE idSolicitud=@idSolicitud and idEstado=(SELECT id from estado where estado='Confirmado'))
GO
/****** Object:  StoredProcedure [dbo].[SelectLastServicioRealizado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SelectLastServicioRealizado]
(
	@idSolicitud int
)
AS
	SELECT FechaRealizacion, Encargado, Solucion FROM dbo.ServicioRealizado
	WHERE idSolicitudEstado = (SELECT Max(idSolicitudEstado) FROM dbo.SolicitudEstado WHERE idSolicitud=@idSolicitud and idEstado=(SELECT id from estado where estado='Realizado'))
GO
/****** Object:  StoredProcedure [dbo].[selectLocalidades]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[selectLocalidades]
	(
		@cuantas int output
	)
AS
	BEGIN
		select * from dbo.Localidad order by Localidad.Localidad
		SET @cuantas=@@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[selectLocalidadesWithColonias]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[selectLocalidadesWithColonias]
	(
		@cuantas int output
	)
AS
	BEGIN
		select DISTINCT(Localidad.id), Localidad from dbo.Localidad 
		INNER JOIN dbo.Colonia ON Localidad.Id = Colonia.IDLocalidad order by Localidad.Localidad
		SET @cuantas=@@ROWCOUNT
	END
GO
/****** Object:  StoredProcedure [dbo].[selectServicioById]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[selectServicioById]
	(
		@id int
	)
AS
	BEGIN
		SET NOCOUNT ON
		select Dependencia, Servicio.Descripcion, Dependencia.Descripcion, Ubicacion, Telefono, CorreoE
		from dbo.Servicio INNER JOIN dbo.Dependencia ON Servicio.idDependencia = Dependencia.id
		where Servicio.id = @id
	END
GO
/****** Object:  StoredProcedure [dbo].[selectServicios]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[selectServicios]
	(
		@cuantas int output
	)
AS
	BEGIN
		select Servicio.id, Servicio,Dependencia.Id,Dependencia.Dependencia, Servicio.Descripcion
		from dbo.Servicio, dbo.Dependencia
		where Servicio.idDependencia = Dependencia.id order by Servicio;
		SET @cuantas=@@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[selectServiciosByIdDep]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[selectServiciosByIdDep]
	(
		@cuantas int output,
		@idDependencia int
	)
AS
	BEGIN
		select Servicio.id, Servicio,Dependencia.Id as IdDependencia,Dependencia.Dependencia, Servicio.Descripcion
		from dbo.Servicio INNER JOIN dbo.Dependencia ON Servicio.idDependencia = Dependencia.id
		where Dependencia.id = @idDependencia order by Dependencia, Servicio;
		SET @cuantas=@@ROWCOUNT
	END

GO
/****** Object:  StoredProcedure [dbo].[selectTiempoRespuesta]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[selectTiempoRespuesta]
	(
		@cuantas int output
	)
AS
	BEGIN
		select * from dbo.TiempoRespuesta order by verde
		SET @cuantas=@@ROWCOUNT
	END



GO
/****** Object:  StoredProcedure [dbo].[SolicitudesFiltradasByDependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SolicitudesFiltradasByDependencia]
(
	--@idDependencia  smallint,
	@Estado varchar(20)
)
AS
	BEGIN
		SET NOCOUNT ON
		SELECT Solicitud.id, SolicitudEstado.FechaHora, Servicio.Servicio, Colonia.Colonia, Solicitud.Descripcion
		FROM SolicitudEstado
		INNER JOIN Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN Servicio
		ON Solicitud.idServicio=Servicio.id
		INNER JOIN Colonia
		ON Colonia.id = Solicitud.idcolonia
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id)
		AND idEstado = (select id FROM dbo.Estado WHERE Estado=@Estado)
		--AND Servicio.IdDependencia=@idDependencia
		ORDER BY Solicitud.Id ASC
	END
GO
/****** Object:  StoredProcedure [dbo].[SolicitudesFiltradasByEdo]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SolicitudesFiltradasByEdo]
(	
	@Estado varchar(20)
)
AS
	BEGIN
		SET NOCOUNT ON
		SELECT Solicitud.id, SolicitudEstado.FechaHora, Dependencia
		FROM SolicitudEstado
		INNER JOIN Solicitud
		ON SolicitudEstado.idSolicitud=Solicitud.id
		INNER JOIN Servicio
		ON Solicitud.idServicio=Servicio.id
		INNER JOIN Dependencia
		ON Servicio.idDependencia = Dependencia.id
		WHERE idSolicitudEstado=dbo.GetLastSolicitudEstadoByIdSolicitud(Solicitud.id)
		AND idEstado = (select id FROM dbo.Estado WHERE Estado=@Estado)
		ORDER BY Solicitud.Id ASC
	END
GO
/****** Object:  StoredProcedure [dbo].[updateCiudadano]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[updateCiudadano]
	(
		@Nombre varchar(30)='',
		@ApellidoP varchar (30) = '',
		@ApellidoM varchar (30)='',
		@Direccion varchar(50)='',
		@idColonia smallint=0,
		@NumeroExt varchar(5)='',
		--@NumeroInt varchar(5)='',
		@Sexo bit=1,
		--@Edad smallint=1,		
		@Telefono varchar (20)='',
		@TelefonoAlt varchar (20)='',
		@CorreoE varchar(50)='',
		--@CorreoEAlt varchar(50)='',
		--@Asociacion varchar (50)='',

		@idCiud int=0,
		@fechaNac smalldatetime = null

	)
AS
BEGIN
		UPDATE dbo.Ciudadano
			SET Nombre = @Nombre, ApellidoP=@ApellidoP, ApellidoM=@ApellidoM,  Direccion=@Direccion, IdColonia=@idColonia, NumeroExt=@NumeroExt/*,NumeroInt=@NumeroInt*/,
	 		Sexo=@Sexo, CorreoE=@CorreoE, /*CorreoEAlt=@CorreoEAlt, Edad=@Edad,*/ Telefono=@Telefono, TelefonoAlt=@TelefonoAlt/*,  Asociacion=@Asociacion*/, fechaNac = @fechaNac
		WHERE Ciudadano.Id=@idCiud
END
GO
/****** Object:  StoredProcedure [dbo].[updateColonia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[updateColonia]
	(
		@id	smallint, 
		@Colonia varchar(50),
		@idLocalidad smallint,
		@update bit output
	)
AS 
	SET NOCOUNT ON 		
	--DECLARE @loc smallint
	--SET @loc=dbo.GetIdColoniaByName(@Colonia)
	--IF (@Loc=0)
	IF dbo.ExisteColonia(@Colonia, @idLocalidad)=0 
		BEGIN
			UPDATE dbo.Colonia
			SET  Colonia = @Colonia, idLocalidad=@idLocalidad
			WHERE ( id = @id)
			SET @update=1
		END
	ELSE
			SET @update=0
GO
/****** Object:  StoredProcedure [dbo].[updateDependencia]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[updateDependencia]
	(
		@id	smallint,
		@esOp bit,
		@Dependencia varchar(50),
		@Descripcion varchar(256),
		@Ubicacion varchar(50),
		@Telefono varchar(20),
		@CorreoE varchar(50),
		@idTiempo smallint,
		@update bit output
	)
AS 
	SET NOCOUNT ON 		
	--DECLARE @dep smallint
	--SET @dep=dbo.GetIdDependenciaByName(@Dependencia)
	--IF (@dep=0)
	IF dbo.ExisteDependencia(@Dependencia)=0
		BEGIN
			UPDATE dbo.Dependencia
			SET  esOP=@esOp,Dependencia = @Dependencia, Descripcion=@Descripcion, Ubicacion=@Ubicacion, Telefono=@Telefono, CorreoE=@CorreoE, idTiempo=@idTiempo
			WHERE ( id = @id)
			SET @update=1
		END
	ELSE
		set @update=0

GO
/****** Object:  StoredProcedure [dbo].[updateLocalidad]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[updateLocalidad]
	(
		@id	smallint, 
		@Localidad varchar(50),
		@update bit output
	)
AS 
	SET NOCOUNT ON 		
	--DECLARE @loc smallint
	--SET @loc=dbo.GetIdLocalidadByName(@Localidad)
	
		IF dbo.ExisteLocalidad(@Localidad)=0 --no puede ser, si solo kiere modificar otro dato
			BEGIN
				UPDATE [dbo].[Localidad] 
				SET  Localidad = @Localidad
				WHERE ( id = @id)
				set @update=1
			END
		ELSE
			set @update=0
	
	
GO
/****** Object:  StoredProcedure [dbo].[updateServicio]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[updateServicio]
	(
		@id	smallint, 
		@Servicio varchar(50),
		@idDependencia smallint,
		@Descripcion varchar(256),
		@update bit output
	)
AS 
	SET NOCOUNT ON 		

	IF (@idDependencia)!=0
		BEGIN
			UPDATE dbo.Servicio 
			SET  Servicio = @Servicio, idDependencia=@idDependencia, Descripcion=@Descripcion
			WHERE ( id = @id)
			SET @update=1
		END
	ELSE
		set @update=0
	
GO
/****** Object:  StoredProcedure [dbo].[updateServicioOfSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[updateServicioOfSolicitud]
	(
		@idServicio smallint,
		@idSolicitud int			
	)
AS

	UPDATE Solicitud  SET idServicio=@idServicio FROM dbo.Solicitud WHERE solicitud.id=@idSolicitud
GO
/****** Object:  StoredProcedure [dbo].[UpdateSolicitud]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[UpdateSolicitud]
(
	@idSolicitud int,
	@Calle varchar(50),
	@Ref1 varchar(50),
	@Ref2 varchar(50),
	@idColonia smallint,
	@idServicio smallint,
	@Descripcion varchar(1024),
	@update int output
)
AS
BEGIN
	UPDATE Solicitud
	SET IdServicio = @idServicio, Descripcion = @Descripcion, Calle=@Calle, Ref1=@Ref1, Ref2=@Ref2, idColonia=@idColonia
	WHERE Solicitud.Id = @idSolicitud
	SET @update=1
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateSolicitudAndCambioEstado]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create PROCEDURE [dbo].[UpdateSolicitudAndCambioEstado]
(
	@update int output,
	@idSolicitud int = null,
	@Calle varchar(50) = null,
	@Ref1 varchar(50) = null,
	@Ref2 varchar(50) = null,
	@idColonia smallint = null,
	@idServicio smallint =null,
	@Descripcion varchar(1024)=null,
	@idCaptura varchar(50)=''
	
)
AS
BEGIN
	DECLARE @es smallint
	SET @es=dbo.GetEstadoIdByName('Entrante')
	UPDATE Solicitud
	SET 
		IdServicio = isnull(IdServicio,@idServicio), 
		Descripcion = isnull(Descripcion, @Descripcion), 
		Calle = ISNULL(Calle,@Calle), 
		Ref1 = isnull(Ref1,@Ref1), 
		Ref2 = isnull(Ref2,@Ref2),
		idColonia = isnull(idColonia,@idColonia)
	WHERE Solicitud.Id = @idSolicitud

	INSERT INTO dbo.SolicitudEstado(IdSolicitud,IdEstado,FechaHora,IdCaptura)
		VALUES (@idSolicitud,@es,GETDATE(),@idCaptura)

	SET @update=1
END
GO
/****** Object:  StoredProcedure [dbo].[updateTiempoRespuesta]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[updateTiempoRespuesta]
	(
		@idTiempo	smallint, 
		@descripcion varchar (60),	
		@verde smallint,
		@amarillo smallint,
		@naranja smallint,
		@rojo smallint,
		@update bit output
	)
AS 
	SET NOCOUNT ON 
		IF (@idTiempo)!=0
		BEGIN		
			UPDATE [dbo].[tiempoRespuesta] 
			SET  descripcion=@descripcion,verde=@verde,amarillo=@amarillo,naranja=@naranja,rojo=@rojo
			WHERE ( idTiempo = @idTiempo)
			set @update=1
	END
	ELSE
		set @update=0		
	

GO
/****** Object:  StoredProcedure [seguridad].[ING_segPermisosByRolWebGET]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[ING_segPermisosByRolWebGET]
(
	@IDUSUARIO int	
)
AS
begin
	SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
		SELECT IDUSUARIO, IDROL, ROL, IDPAGINA, PAGINA, ACTIVOPAGINA, IDMODULO, MODULO, URL, ACTIVOMODULO, 
		 CODIGOPAGINA
		FROM seguridad.view_segPermisosByRolGET
		where IDUSUARIO=@IDUSUARIO
	end

GO
/****** Object:  StoredProcedure [seguridad].[MODULOADD]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[MODULOADD]
(
	@IDMODULO INT OUTPUT,
	@DESCRIPCION VARCHAR(100),
	@MODULO VARCHAR(50),
	@URL VARCHAR (255)	

)

AS

BEGIN
SET NOCOUNT ON 
INSERT INTO seguridad.MODULO (MODULO,DESCRIPCION,URL) VALUES (@MODULO,@DESCRIPCION,@URL);
  										  
SET @IDMODULO = @@IDENTITY;
PRINT @IDMODULO;
--------------------------------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [seguridad].[MODULODEL]    Script Date: 25/12/2018 12:41:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[MODULODEL]
(
	@IDMODULO INT = NULL
	
)

AS

BEGIN
  SET  XACT_ABORT  ON

  SET  NOCOUNT  ON

DELETE from SEGURIDAD.MODULO where IDMODULO = @IDMODULO;

return @@ROWCOUNT;

--------------------------------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [seguridad].[MODULOGET]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[MODULOGET]
(
	
	
	@IDMODULO int = NULL
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IDMODULO INT'
    
    SET @QUERY_P1 = N'SELECT IDMODULO ,   
    DESCRIPCION ,
    MODULO,    
    URL, ACTIVO  
     FROM SEGURIDAD.MODULO'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IDMODULO IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'IDMODULO=@IDMODULO'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@IDMODULO
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [seguridad].[MODULOUPDATE]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[MODULOUPDATE]
(
	@IDMODULO INT,
	@DESCRIPCION  VARCHAR (100) = NULL,
	@MODULO VARCHAR(50) = NULL,	
	@URL  VARCHAR(255) = NULL,	
	@ACTIVO BIT= NULL

	
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
UPDATE SEGURIDAD.MODULO SET 
DESCRIPCION=ISNULL(@DESCRIPCION,DESCRIPCION),
MODULO=ISNULL(@MODULO,MODULO),
URL=ISNULL(@URL,URL),
ACTIVO=ISNULL(@ACTIVO,ACTIVO) where IDMODULO = @IDMODULO;
return @@ROWCOUNT;

END

GO
/****** Object:  StoredProcedure [seguridad].[PAGINAADD]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[PAGINAADD]
(
	@IDPAGINA INT OUTPUT,
	@IDMODULO  INT,
	@TITULO NVARCHAR(50),
	@PAGINA NVARCHAR(100),
	@ACTIVO BIT	

)

AS

BEGIN
SET NOCOUNT ON 
INSERT INTO seguridad.PAGINA (IDMODULO,TITULO,PAGINA,ACTIVO) VALUES (@IDMODULO,@TITULO,@PAGINA,@ACTIVO);
  										  
SET @IDPAGINA = @@IDENTITY;
PRINT @IDPAGINA;
--------------------------------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [seguridad].[PAGINADEL]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[PAGINADEL]
(
	@IDPAGINA INT = NULL
	
)

AS

BEGIN
  SET  XACT_ABORT  ON

  SET  NOCOUNT  ON

DELETE from SEGURIDAD.PAGINA where IDPAGINA = @IDPAGINA;

return @@ROWCOUNT;

--------------------------------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [seguridad].[PAGINAGET]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[PAGINAGET]
(
	
	
	@IDPAGINA int = null,
	@IDMODULO int = null 
	--[CREATEDON] [smalldatetime] NOT NULL,
	--[CREATEDBY] [smallint] NOT NULL,
	--[MODIFIEDON] [smalldatetime] NOT NULL,
	--[MODIFIEDBY] [smallint] NOT NULL,
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IDPAGINA INT,@IDMODULO INT'
    
    SET @QUERY_P1 = N'SELECT IDPAGINA ,
    IDMODULO,
    TITULO,
    PAGINA,    
    ACTIVO  
     FROM SEGURIDAD.PAGINA'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IDPAGINA IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'IDPAGINA=@IDPAGINA'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
IF @IDMODULO IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'IDMODULO=@IDMODULO'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@IDPAGINA,@IDMODULO
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END

GO
/****** Object:  StoredProcedure [seguridad].[PAGINAUPDATE]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[PAGINAUPDATE]
(
	@IDPAGINA INT,
	@IDMODULO INT,
	@TITULO  NVARCHAR (50) = NULL,
	@PAGINA NVARCHAR(100) = NULL,		
	@ACTIVO BIT= NULL

	
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
UPDATE SEGURIDAD.PAGINA SET 
IDMODULO=ISNULL(@IDMODULO,IDMODULO),
TITULO=ISNULL(@TITULO,TITULO),
PAGINA=ISNULL(@PAGINA,PAGINA),
ACTIVO=ISNULL(@ACTIVO,ACTIVO) where IDPAGINA = @IDPAGINA;
return @@ROWCOUNT;

END
GO
/****** Object:  StoredProcedure [seguridad].[PERMISOROLADD]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[PERMISOROLADD] 
(
    @IDPERMISOROL int output,
	@IDROL INT,	
	@IDPAGINA INT
) 
AS
BEGIN
	SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
     
INSERT INTO SEGURIDAD.PERMISOROL(IDPAGINA, IDROL)
values (@IDPAGINA,@IDROL);
SET @IDPERMISOROL = @@IDENTITY;
PRINT @IDPERMISOROL;

--------------------------------------------------------------------------------------
END

GO
/****** Object:  StoredProcedure [seguridad].[PERMISOROLWEBADD]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[PERMISOROLWEBADD] 
(
	@error varchar(1024) output,
    @IDPERMISOROL int output,
	@IDROL INT,	
	@IDPAGINA INT,
	@IDMODULO INT
) 
AS
BEGIN TRY
	SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      set @error='ok'		
      
     
INSERT INTO SEGURIDAD.PERMISOROL(IDPAGINA, IDROL, IDMODULO)
values (@IDPAGINA,@IDROL, @IDMODULO);
SET @IDPERMISOROL = @@IDENTITY;
PRINT @IDPERMISOROL;

END TRY
	
	BEGIN CATCH
	/* Hay un error, deshacemos los cambios*/ 	
		set @error= ERROR_MESSAGE()
	END CATCH
--------------------------------------------------------------------------------------



GO
/****** Object:  StoredProcedure [seguridad].[PERMISOROLWEBGET]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[PERMISOROLWEBGET]
(
	@IDPERMISOROL int = NULL,
	@IDPAGINA int=NULL,
	@IDROL int =NULL,
	@IDMODULO int=NULL
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IDPERMISOROL INT, @IDPAGINA INT, @IDROL INT, @IDMODULO INT'
    
    SET @QUERY_P1 = N'SELECT IDPERMISOROL , IDPAGINA, IDROL, IDMODULO,
	TITULO,
	PAGINA,	
	ACTIVO
     FROM seguridad.view_PaginaRolModulo'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IDPERMISOROL IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'IDPERMISOROL=@IDPERMISOROL'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
IF @IDPAGINA IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'IDPAGINA=@IDPAGINA'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IDROL IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'IDROL=@IDROL'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IDMODULO IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'IDMODULO=@IDMODULO'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------

 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@IDPERMISOROL,@IDPAGINA,@IDROL,@IDMODULO
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END


GO
/****** Object:  StoredProcedure [seguridad].[PermisosRolWebDEL]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[PermisosRolWebDEL]
	(
		@IdPermisoRol Int,
		@error varchar(1024) output,	
		@insertado int  output
	)
AS	
	-- Abrimos una transacción
	
	BEGIN TRY
		SET NOCOUNT ON 		
	
		set @insertado=0		
		set @error='ok'		
		
		delete from seguridad.PERMISOROL
		 WHERE IDPERMISOROL=@IdPermisoRol		 
		set @insertado=1
		
	END TRY
	
	BEGIN CATCH
	/* Hay un error, deshacemos los cambios*/ 	
		set @error= ERROR_MESSAGE()
	END CATCH
GO
/****** Object:  StoredProcedure [seguridad].[RELUSRDEPADD]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [seguridad].[RELUSRDEPADD]
(
	@idrel int output,
	@iddep smallint,
	@iAppID bigint
	
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
INSERT INTO SEGURIDAD.RELUSERDEP( iddep, iAppID, fecha)
VALUES (@iddep,@iAppID,GETDATE())

							
SET @idrel = @@IDENTITY;
PRINT @idrel;
--------------------------------------------------------------------------------------
END







GO
/****** Object:  StoredProcedure [seguridad].[RelUsuarioDepDEL]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[RelUsuarioDepDEL]
(
	@IdRel INT = NULL,
		@error varchar(1024) output,	
		@insertado int  output
)

AS

BEGIN TRY
		SET NOCOUNT ON 		
	
		set @insertado=0		
		set @error='ok'		
      
DELETE FROM SEGURIDAD.RELUSERDEP WHERE idrel=@IdRel;
set @insertado=1
END TRY
	
	BEGIN CATCH
	/* Hay un error, deshacemos los cambios*/ 	
		set @error= ERROR_MESSAGE()
	END CATCH


GO
/****** Object:  StoredProcedure [seguridad].[ROLGET]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [seguridad].[ROLGET]
(
	--@IDAPLICACION int=null,
	@IDROL INT = NULL,
	@ROL varchar(50) = null,
	@DESCRIPCION varchar(100) = null
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IDROL INT,
										@ROL varchar(50),
										@DESCRIPCION varchar(100)'
    
    SET @QUERY_P1 = N'SELECT IDROL, ROL, DESCRIPCION FROM seguridad.ROL'
    SET @QUERY_P2 = N''
    SET @PREVIO = 0


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IDROL IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'IDROL=@IDROL'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @ROL IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'ROL LIKE ' +  char(39) + '%' +@ROL  + '%' + char(39)            
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @DESCRIPCION IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'seguridad.ROL.DESCRIPCION LIKE ' +  char(39) + '%' +@DESCRIPCION  + '%' + char(39)            
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,
										@IDROL,
										@ROL,
										@DESCRIPCION
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [seguridad].[USUARIOADD]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[USUARIOADD]
(
	@IDUSUARIO int output,
	@PASSWORD varchar(200),
	@USUARIO varchar(20),
	@NOMBRE varchar(250),
	@CORREO varchar(255),
	@IDROL int,
	@ACTIVO bit
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
INSERT INTO SEGURIDAD.esAppWebUsuario(IDROL, iAppLogin, iAppNombreC, iAppCorreo, iAppPwd, iAppAudiencia, iAppActivo)
VALUES (@IDROL,@USUARIO,@NOMBRE,@CORREO,@PASSWORD,0,@ACTIVO)

							
SET @IDUSUARIO = @@IDENTITY;
PRINT @IDUSUARIO;
--------------------------------------------------------------------------------------
END






GO
/****** Object:  StoredProcedure [seguridad].[USUARIODEL]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[USUARIODEL]
(
	@IDUSUARIO INT = NULL
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
DELETE FROM SEGURIDAD.esAppWebUsuario WHERE iAppID=@IDUSUARIO;

return @@ROWCOUNT;
--------------------------------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [seguridad].[USUARIOGET]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [seguridad].[USUARIOGET]
(
	@IDUSUARIO int = null,
	@IDROL INT = NULL,
	@USUARIO varchar(20)=null
	
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON
      
    DECLARE @QUERY_P1 NVARCHAR(1024)
    DECLARE @QUERY_P2 NVARCHAR(1024)
    DECLARE @PREVIO BIT 
    
    --Solo declaramos los parametros input
    declare @LISTPARAMS nvarchar(512) = '@IDUSUARIO INT ,@IDROL INT ,@USUARIO varchar'
    
    SET @QUERY_P1 = N' SELECT 
							u.iAppID as IDUSUARIO, 
							u.iAppLogin as USUARIO, 
							u.iAppPwd as PASSWORD, 
							u.iAppActivo as ACTIVO,
							u.iAppNombreC,
							u.iAppCorreo,
							r.IDROL,
							r.DESCRIPCION,
							r.ROL
						FROM   seguridad.esAppWebUsuario u
							inner join seguridad.ROL r on r.IDROL=u.IDROL'
  
 
    SET @QUERY_P2 = N''
    SET @PREVIO = 0

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IDUSUARIO IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'u.iAppID=@IDUSUARIO'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @IDROL IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'r.IDROL=@IDROL'           
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
IF @USUARIO IS NOT NULL 
BEGIN 
           IF (@PREVIO=1) SET @QUERY_P2 = @QUERY_P2 + N' and '
			
			SET @QUERY_P2 = @QUERY_P2 + N'u.iAppLogin like+'+char(39)+'%'+@USUARIO+'%'+char(39)+''
            SET @PREVIO = 1        
END
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
 IF @QUERY_P2  <> N'' 
	SET @QUERY_P1 = @QUERY_P1 + N' WHERE ' + @QUERY_P2 + N';'
	
	SET @QUERY_P1 = @QUERY_P1 	              
	EXEC sp_executesql @QUERY_P1, @LISTPARAMS,@IDUSUARIO,@IDROL,@USUARIO
PRINT @QUERY_P1;
--------------------------------------------------------------------------------------
END







GO
/****** Object:  StoredProcedure [seguridad].[USUARIOUPDATE]    Script Date: 25/12/2018 12:41:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE PROCEDURE [seguridad].[USUARIOUPDATE]
(
   @IDUSUARIO int,
	@PASSWORD varchar(200),
	@USUARIO varchar(20),
	@NOMBRE varchar(250),
	@CORREO varchar(255),
	@IDROL int,
	@ACTIVO bit
	
)

AS

BEGIN
  SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

UPDATE  SEGURIDAD.esAppWebUsuario
SET
iAppPwd=ISNULL(@PASSWORD,iAppPwd),
iAppLogin=ISNULL(@USUARIO,iAppLogin),
IDROL=ISNULL(@IDROL,IDROL),	
iAppNombreC=ISNULL(@NOMBRE,iAppNombreC),									
iAppCorreo=ISNULL(@CORREO,iAppCorreo),	
iAppActivo=ISNULL(@ACTIVO,iAppActivo)

WHERE iAppID=@IDUSUARIO;
return @@ROWCOUNT;
--------------------------------------------------------------------------------------
END






GO
EXEC sys.sp_addextendedproperty @name=N'Build', @value=760 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'traza'
GO
EXEC sys.sp_addextendedproperty @name=N'MajorVer', @value=8 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'traza'
GO
EXEC sys.sp_addextendedproperty @name=N'MinorVer', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'traza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[23] 4[44] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Dependencia"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 319
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RELUSERDEP (seguridad)"
            Begin Extent = 
               Top = 9
               Left = 615
               Bottom = 222
               Right = 837
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TiempoRespuesta"
            Begin Extent = 
               Top = 9
               Left = 894
               Bottom = 280
               Right = 1116
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 3030
         Width = 1000
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2160
         Table = 1600
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_depenciaByUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_depenciaByUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Dependencia"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 209
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TiempoRespuesta"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 180
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1800
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_getDependenciaWithTiempos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_getDependenciaWithTiempos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Servicio"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 173
               Right = 199
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dependencia"
            Begin Extent = 
               Top = 6
               Left = 435
               Bottom = 200
               Right = 595
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TiempoRespuesta"
            Begin Extent = 
               Top = 3
               Left = 680
               Bottom = 192
               Right = 840
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2175
         Alias = 2655
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_getServicio_dependencia_tiempoDepencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_getServicio_dependencia_tiempoDepencia'
GO
USE [master]
GO
ALTER DATABASE [SIMACV2] SET  READ_WRITE 
GO

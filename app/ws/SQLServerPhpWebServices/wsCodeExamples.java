factura.proc_add_updDirectorioFiscal
campos.Add(new System.Data.SqlClient.SqlParameter("@razonSocial",addContribuyente.Text.ToString().Trim()));
campos.Add(new System.Data.SqlClient.SqlParameter("@rfc", lblRfc.Text.ToString().Trim().ToUpper()));
campos.Add(new System.Data.SqlClient.SqlParameter("@referencia",addDireccion.Text.ToString().Trim().ToUpper()));
campos.Add(new System.Data.SqlClient.SqlParameter("@correo", addCorreo.Text.ToString().Trim().ToUpper()));

factura.proc_addCfdi_Factura
campos.Add(new System.Data.SqlClient.SqlParameter("@idCfdi", System.Data.SqlDbType.Int));
campos[0].Direction = System.Data.ParameterDirection.Output;
campos.Add(new System.Data.SqlClient.SqlParameter("@serie", ConfigurationManager.AppSettings["serieFac"].ToString()));
campos.Add(new System.Data.SqlClient.SqlParameter("@fcaptura", null));
campos.Add(new System.Data.SqlClient.SqlParameter("@femision", null));
campos.Add(new System.Data.SqlClient.SqlParameter("@versionCfdi", "3.3"));
campos.Add(new System.Data.SqlClient.SqlParameter("@tipoComprobante", "INGRESO"));
campos.Add(new System.Data.SqlClient.SqlParameter("@subTotal", convertir.toNDecimal(addtotal.Text)));
campos.Add(new System.Data.SqlClient.SqlParameter("@descuento", convertir.toNDecimal(0.0)));
campos.Add(new System.Data.SqlClient.SqlParameter("@total", convertir.toNDecimal(addtotal.Text)));
campos.Add(new System.Data.SqlClient.SqlParameter("@rfcEmisor", rfcEmisor.ToString()));
campos.Add(new System.Data.SqlClient.SqlParameter("@rfcReceptor", Session["getRfcCF"].ToString().ToUpper().Trim()));
campos.Add(new System.Data.SqlClient.SqlParameter("@ivaRet", convertir.toNDecimal(0.0)));
campos.Add(new System.Data.SqlClient.SqlParameter("@referencia", lblFolio.Text.ToString().Trim().ToUpper()));
campos.Add(new System.Data.SqlClient.SqlParameter("@pathXml", path.ToString()));
campos.Add(new System.Data.SqlClient.SqlParameter("@pathPdf", path.ToString()));
campos.Add(new System.Data.SqlClient.SqlParameter("@lugarExpide", ConfigurationManager.AppSettings["exLugar"].ToString()));
//campos.Add(new System.Data.SqlClient.SqlParameter("@motivoDesc", path.ToString()));
campos.Add(new System.Data.SqlClient.SqlParameter("@estatus",1));

factura.proc_editCfdi_Factura
campos.Add(new System.Data.SqlClient.SqlParameter("@idCfdi", convertir.toNInt64(idCFDI)));
campos.Add(new System.Data.SqlClient.SqlParameter("@uddi", _uddi.ToString()));
campos.Add(new System.Data.SqlClient.SqlParameter("@fechaTimbre", _fTimbre.ToString()));
campos.Add(new System.Data.SqlClient.SqlParameter("@selloCfd", _selloCfd.ToString()));
campos.Add(new System.Data.SqlClient.SqlParameter("@selloSat", _selloSat.ToString()));
campos.Add(new System.Data.SqlClient.SqlParameter("@noCertSat", _noCertSat.ToString()));

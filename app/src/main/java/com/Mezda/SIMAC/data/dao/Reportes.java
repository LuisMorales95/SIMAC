package com.Mezda.SIMAC.data.dao;

public class Reportes {
    
    private String
            reportevalidez,
            reporteimagen,
            reporteproblema,
            folio,
            referencia1,
            referencia2,
            fechasolicitud,
            estado;
    
    public Reportes() {
    }
    
    public Reportes(String reportevalidez, String reporteimagen, String reporteproblema, String folio, String referencia1, String referencia2, String fechasolicitud, String estado) {
        this.reportevalidez = reportevalidez;
        this.reporteimagen = reporteimagen;
        this.reporteproblema = reporteproblema;
        this.folio = folio;
        this.referencia1 = referencia1;
        this.referencia2 = referencia2;
        this.fechasolicitud = fechasolicitud;
        this.estado = estado;
    }
    
    public String getReportevalidez() {
        return reportevalidez;
    }
    
    public void setReportevalidez(String reportevalidez) {
        this.reportevalidez = reportevalidez;
    }
    
    public String getReporteimagen() {
        return reporteimagen;
    }
    
    public void setReporteimagen(String reporteimagen) {
        this.reporteimagen = reporteimagen;
    }
    
    public String getReporteproblema() {
        return reporteproblema;
    }
    
    public void setReporteproblema(String reporteproblema) {
        this.reporteproblema = reporteproblema;
    }
    
    public String getFolio() {
        return folio;
    }
    
    public void setFolio(String folio) {
        this.folio = folio;
    }
    
    public String getReferencia1() {
        return referencia1;
    }
    
    public void setReferencia1(String referencia1) {
        this.referencia1 = referencia1;
    }
    
    public String getReferencia2() {
        return referencia2;
    }
    
    public void setReferencia2(String referencia2) {
        this.referencia2 = referencia2;
    }
    
    public String getFechasolicitud() {
        return fechasolicitud;
    }
    
    public void setFechasolicitud(String fechasolicitud) {
        this.fechasolicitud = fechasolicitud;
    }
    
    public String getEstado() {
        return estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
}

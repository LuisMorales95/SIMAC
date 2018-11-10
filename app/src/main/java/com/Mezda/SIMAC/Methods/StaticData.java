package com.Mezda.SIMAC.Methods;

import com.Mezda.SIMAC.Objects.MetodoDePago;
import com.Mezda.SIMAC.Objects.UsoCFDI;

import java.util.ArrayList;

public class StaticData {
    public static ArrayList<MetodoDePago> MetodoDePagos(){
        ArrayList<MetodoDePago> metodoDePagoArrayList = new ArrayList<MetodoDePago>();
        metodoDePagoArrayList.add(new MetodoDePago("01","1","01 Efectivo"));
        metodoDePagoArrayList.add(new MetodoDePago("02","1","02 Cheque Nominativo"));
        metodoDePagoArrayList.add(new MetodoDePago("03","1","03 Transferencia Electrónica de fondos"));
        metodoDePagoArrayList.add(new MetodoDePago("04","1","04 Tarjeta de crédito"));
        metodoDePagoArrayList.add(new MetodoDePago("05","1","05 Monedero Electrónico"));
        metodoDePagoArrayList.add(new MetodoDePago("06","1","06 Dinero Electrónico"));
        metodoDePagoArrayList.add(new MetodoDePago("08","1","08 Vales de despensa"));
        metodoDePagoArrayList.add(new MetodoDePago("12","1","08 Vales de despensa"));
        metodoDePagoArrayList.add(new MetodoDePago("12","1","12 Dación en pago"));
        metodoDePagoArrayList.add(new MetodoDePago("28","1","28 Tarjeta de débito"));
        metodoDePagoArrayList.add(new MetodoDePago("29","1","29 Tarjeta de servicio"));
        metodoDePagoArrayList.add(new MetodoDePago("99","1","99 Otros"));
        return metodoDePagoArrayList;
    }

    public static ArrayList<UsoCFDI> UsoCFDIs(){
        ArrayList<UsoCFDI> usoCFDIArrayList = new ArrayList<UsoCFDI>();
        usoCFDIArrayList.add(new UsoCFDI("P01","1","P01 Por definir"));
        usoCFDIArrayList.add(new UsoCFDI("G01","1","G01 Adquisición de mercancias"));
        usoCFDIArrayList.add(new UsoCFDI("G02","1","G02 Devoluciones, descuentos o bonificaciones"));
        usoCFDIArrayList.add(new UsoCFDI("G03","1","G03 Gastos en general"));
        usoCFDIArrayList.add(new UsoCFDI("I01","1","I01 Construcciones"));
        usoCFDIArrayList.add(new UsoCFDI("I02","1","I02 Mobilario y equipo de oficina por inversiones"));
        usoCFDIArrayList.add(new UsoCFDI("I03","1","I03 Equipo de transporte"));
        usoCFDIArrayList.add(new UsoCFDI("I04","1","I04 Equipo de computo y accesorios"));
        usoCFDIArrayList.add(new UsoCFDI("I05","1","I05 Dados, troqueles, moldes, matrices y herramental"));
        usoCFDIArrayList.add(new UsoCFDI("I06","1","I06 Comunicaciónes telefónicas"));
        usoCFDIArrayList.add(new UsoCFDI("I07","1","I07 Comunicaciones satelitales"));
        usoCFDIArrayList.add(new UsoCFDI("I08","1","I08 Otra maquinaria y equipo"));
        usoCFDIArrayList.add(new UsoCFDI("D01","1","D01 Honorarios médicos, dentales y gastos hospitalarios"));
        usoCFDIArrayList.add(new UsoCFDI("D02","1","D02 Gastos médicos por incapacidad o discapacidad"));
        usoCFDIArrayList.add(new UsoCFDI("D03","1","D03 Gastos funerales"));
        usoCFDIArrayList.add(new UsoCFDI("D04","1","D04 Donativos"));
        usoCFDIArrayList.add(new UsoCFDI("D05","1","D05 Intereses reales efectivamente pagados por créditos hipotecarios (casa habitación)"));
        usoCFDIArrayList.add(new UsoCFDI("D06","1","D06 Aportaciones voluntarias al SAR"));
        usoCFDIArrayList.add(new UsoCFDI("D07","1","D07 Primas por seguros de gastos médicos"));
        usoCFDIArrayList.add(new UsoCFDI("D08","1","D08 Gastos de transportación escolar obligatoria"));
        usoCFDIArrayList.add(new UsoCFDI("D09","1","D09 Depósitos en cuentas para el ahorro, primas que tengan como base planes de pensiones"));
        usoCFDIArrayList.add(new UsoCFDI("D10","1","D10 Pagos por servicios educativos (colegiaturas)"));
        return usoCFDIArrayList;
    }
    
}

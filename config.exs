field_match_regex: {
  :TipoDeComprobante,:path,'//cfdi:Comprobante/@TipoDeComprobante',
  :regex,~r/^I|E|T$/u,"I|E|T",
  :sat_error_code,"CCE101",
  :sat_error_message, ~s(El atributo cfdi:Comprobante:TipoDeComprobante no cumple con alguno de los valores permitidos para este complemento.)
},

field_presence_by_multiple_atributes: {
  :Propietario, ['//cce11:ComercioExterior/cce11:Propietario'],
  :atributes, ['//cce11:ComercioExterior[@MotivoTraslado="05"]', '//cfdi:Comprobante[@TipoDeComprobante="T"]'],
  :sat_error_code,"CCE102",
  :sat_error_message,~s(El nodo Propietario se debe registrar cuando el atributo cfdi:Comprobante:TipoDeComprobante tiene el valor "T" y MotivoTraslado tiene la clave "05".)
},

field_absence_by_multiple_atributes: {
  :Propietario, ['//cce11:ComercioExterior/cce11:Propietario'],
  :atributes, ['//cce11:ComercioExterior[@MotivoTraslado!="05"]', '//cfdi:Comprobante[@TipoDeComprobante!="T"]'],
  :sat_error_code,"CCE103",
  :sat_error_message,~s(El nodo Propietario no se debe registrar cuando el atributo cfdi:Comprobante:TipoDeComprobante tiene un valor distinto de "T" y MotivoTraslado tiene una clave distinta de "05".)
},

field_presence_by_multiple_atributes: {
  :Exportacion, ['//cfdi:Complemento/cce11:ComercioExterior'],
  :atributes, ['//cfdi:Comprobante[@Exportacion="02"]'],
  :sat_error_code,"CCE104",
  :sat_error_message,~s(La clave registrada en el atributo Exportacion contiene un valor "02" y no se cuenta con el complemento de Comercio Exterior.)
},

absence_of_node: {
  :InformacionGlobal,:path,'//cfdi:Comprobante/cfdi:InformacionGlobal',
  :sat_error_code,"CCE105",
  :sat_error_message,~s(Se registro información en el nodo InformacionGlobal y no debe existir registro.)
},

absence_of_node: {
  :FacAtrAdquirente,:path,'//cfdi:Comprobante/cfdi:Emisor/@FacAtrAdquirente',
  :sat_error_code,"CCE106",
  :sat_error_message,~s(Se registro información en el nodo FacAtrAdquirente y no debe existir registro.)
},

#* probar la funcion rfc_list en un ambiente con L_RFC existente
rfc_list: {
  "Present in L_RFC",:field,:"cfdi:Comprobante/Receptor/Rfc",
  :path,'//cfdi:Comprobante[@TipoDeComprobante="I"]/cfdi:Receptor/@Rfc',
  :sat_error_code,"CCE107",
  :sat_error_message,~s(El atributo cfdi:Comprobante:Receptor:Rfc no tiene un RFC registrado en la lista de RFC inscritos no cancelados del SAT \(l_RFC\), ni el valor  "XEXX010101000" o se encuentra vacío.)
},

#TODO CCE108 se modifica en la version del 19/JUL/2022
rfc_list: {
  "Present in L_RFC",:field,:"cfdi:Comprobante/Receptor/Rfc",
  :path,'//cfdi:Comprobante[@TipoDeComprobante="T" and //cce11:ComercioExterior/@MotivoTraslado="02"]/cfdi:Receptor/@Rfc',
  :sat_error_code,"CCE108",
  :sat_error_message,~s(El atributo cfdi:Comprobante:Receptor:Rfc no tiene un RFC válido de lista de RFC inscritos no cancelados del SAT \(l_RFC\), contiene el valor "XEXX010101000" o se encuentra vacío.)
},

#* CCE109 - ESTA REGLA SE ELIMINA EN LA VERSION DEL 19/JUL/2022
value_match_by_condition: {
  :"Receptor:Rfc",
  :"values", ['//cfdi:Comprobante/cfdi:Receptor/@Rfc', '//cfdi:Comprobante/cfdi:Emisor/@Rfc'],
  :conds, ['//cfdi:Comprobante[@TipoDeComprobante="T"]', '//cfdi:Complemento/cartaporte20:CartaPorte'],
  :sat_error_code,"CCE109",
  :sat_error_message,~s(Se registró el complemento Carta Porte y el RFC registrado para el Receptor es distinto al del Emisor.)
},

field_presence_by_multiple_atributes: {
  :ObjetoImp, ['//cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto/cfdi:Impuestos'],
  :atributes, ['//cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto[@ObjetoImp="02"]'],
  :sat_error_code,"CCE110",
  :sat_error_message,~s(Se registró la clave "02" en el atributo "ObjetoImp" y no se tiene información registrada en el nodo cfdi:Concepto:Impuestos)
},

field_presence_by_multiple_atributes: {
  :ObjetoImp, ['//cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto[@ObjetoImp="01"]'],
  :atributes, ['//cfdi:Comprobante[@TipoDeComprobante="T"]'],
  :sat_error_code,"CCE111",
  :sat_error_message,~s(El campo TipoDeComprobante tiene el valor "T" y la clave registrada en el campo "ObjetoImp" es diferente de 01.)
},

absence_of_field: {
  :ACuentaTerceros,:path,'//cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto/cfdi:ACuentaTerceros',
  :sat_error_code,"CCE112",
  :sat_error_message,~s(Se registró información en el nodo "ACuentaTerceros" y no debe existir.)
},

absence_of_field: {
  :CuentaPredial,:path,'//cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto/cfdi:CuentaPredial',
  :sat_error_code,"CCE113",
  :sat_error_message,~s(Se registró información en el nodo "CuentaPredial" y no debe existir.)
},

unique_node_presence: {
  :ComercioExterior, '//cfdi:Complemento/cce11:ComercioExterior',
  :sat_error_code,"CCE114",
  :sat_error_message,~s(El nodo cce11:ComercioExterior no puede registrarse más de una vez.)
},

presence_required_field: {
  :ComercioExterior,:path,'//cfdi:Comprobante/cfdi:Complemento/cce11:ComercioExterior',
  :sat_error_code,"CCE115",
  :sat_error_message,~s(El nodo cce11:ComercioExterior debe registrarse como un nodo hijo del nodo Complemento en el CFDI.)
},

#* Falla por esquema se podra validar solo con complementos agregados!!!
absence_of_node: {
  :Complemento,:path,'//cfdi:Comprobante/cfdi:Complemento/*[not(local-name() = "ComercioExterior") and not(local-name() = "TimbreFiscalDigital") and not(local-name() = "implocal") and not(local-name() = "LeyendasFiscales") and not(local-name() = "Pagos") and not(local-name() = "CFDIRegistroFiscal") and not(local-name() = "CartaPorte")]',
  :sat_error_code,"CCE155",
  :sat_error_message,"El nodo cce11:ComercioExterior solo puede coexistir con los complementos Timbre Fiscal Digital, otros derechos e impuestos, leyendas fiscales, CFDI registro fiscal y Carta Porte."
},

#TODO CCE117

field_presence_by_multiple_atributes: {
  :UUID, ['//cfdi:Comprobante/cfdi:CfdiRelacionados/cfdi:CfdiRelacionado/@UUID'],
  :atributes, ['//cce11:ComercioExterior[@MotivoTraslado="01"]'],
  :sat_error_code,"CCE118",
  :sat_error_message,~s(Se registró la clave "01" en el atributo cce11:ComercioExterior:MotivoTraslado y no existe el atributo cfdi:Relacionados:TipoRelacion o el UUID de la factura de la enajenación no se registró o no cumple con la estructura.)
},

field_presence_by_multiple_atributes: {
  :Propietario, ['//cce11:ComercioExterior/cce11:Propietario'],
  :atributes, ['//cce11:ComercioExterior[@MotivoTraslado="05"]'],
  :sat_error_code,"CCE119",
  :sat_error_message,~s(Se registró la clave "05" en el atributo cce11:ComercioExterior:MotivoTraslado y no existe al menos un nodo "Propietario".)
},

field_absence_by_multiple_atributes: {
  :Propietario, ['//cce11:ComercioExterior/cce11:Propietario'],
  :atributes, ['//cce11:ComercioExterior[@MotivoTraslado!="05"]'],
  :sat_error_code,"CCE119",
  :sat_error_message,~s(Se registró la clave "05" en el atributo cce11:ComercioExterior:MotivoTraslado y no existe al menos un nodo "Propietario".)
},

field_presence_by_multiple_atributes: {
  :TipoOperacion, ['//cce11:ComercioExterior/@ClaveDePedimento','//cce11:ComercioExterior/@CertificadoOrigen','//cce11:ComercioExterior/@Incoterm','//cce11:ComercioExterior/@Subdivision','//cce11:ComercioExterior/@TipoCambioUSD','//cce11:ComercioExterior/@TotalUSD','//cce11:ComercioExterior/cce11:Mercancias'],
  :atributes, ['//cce11:ComercioExterior[@TipoOperacion="2"]'],
  :sat_error_code,"CCE120",
  :sat_error_message,~s(La clave registrada en el atributo cce11:ComercioExterior:TipoOperacion es "2" y no se registró información en alguno de los atributos ClaveDePedimento, CertificadoOrigen, Incoterm, Subdivision, TipoCambioUSD, TotalUSD y Mercancias.)
},

field_absence_by_multiple_atributes: {
  :NumCertificadoOrigen, ['//cce11:ComercioExterior/@NumCertificadoOrigen'],
  :atributes, ['//cce11:ComercioExterior[@CertificadoOrigen="0"]'],
  :sat_error_code,"CCE121",
  :sat_error_message,~s(El valor de cce11:ComercioExterior:CertificadoOrigen es "0" y se registró el atributo cce11:ComercioExterior:NumCertificadoOrigen.)
},

#TODO CCE122
#TODO CCE123

compare_total_with_sum: {
  :TotalUSD, '//cce11:ComercioExterior/@TotalUSD',
  :node, '//cce11:ComercioExterior/cce11:Mercancias/cce11:Mercancia',
  :values, '//@ValorDolares',
  :sat_error_code,"CCE124",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:TotalUSD no coincide con la suma de ValorDolares de las mercancías.)
},

round_attribute: {
  :TotalUSD, '//cce11:ComercioExterior/@TotalUSD',
  :decimals,2,
  :sat_error_code,"CCE125",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:TotalUSD contiene un número de decimales distinto a dos.)
},

field_absence_by_multiple_atributes: {
  :"ComercioExterior:Emisor:Curp", ['//cce11:ComercioExterior/cce11:Emisor/@Curp'],
  :atributes, ['//cfdi:Comprobante/cfdi:Emisor[string-length(@Rfc)=12]'],
  :sat_error_code,"CCE126",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Emisor:Curp no debe registrarse si el atributo Rfc del nodo cfdi:Comprobante:Emisor es de longitud 12.)
},

field_presence_by_multiple_atributes: {
  :"ComercioExterior:Emisor:Curp", ['//cce11:ComercioExterior/cce11:Emisor/@Curp'],
  :atributes, ['//cfdi:Comprobante/cfdi:Emisor[string-length(@Rfc)=13]'],
  :sat_error_code,"CCE127",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Emisor:Curp debe registrarse si el atributo Rfc del nodo cfdi:Comprobante:Emisor es de longitud 13)
},

presence_of_node: {
  :"Emisor:Domicilio",:path,'//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio',
  :sat_error_code,"CCE128",
  :sat_error_message,~s(La versión del CFDI es 4.0 y no se registró el nodo cce11:ComercioExterior:Emisor:Domicilio.)
},

field_match_regex: {
  :Pais,:path,'//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Pais',
  :regex,~r/^MEX$/u,"MEX",
  :sat_error_code,"CCE129",
  :sat_error_message, ~s(El atributo cce11:ComercioExterior:Emisor:Domicilio:Pais contiene una clave distinta de "MEX".)
},

rule_CCE130: {
  :Estado, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Estado',
  :sat_error_code,"CCE130",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Emisor:Domicilio:Estado contiene una clave distinta del catálogo catCFDI:c_Estado donde la columna c_Pais tiene el valor "MEX".)
},

search_double_key_catalog: {
  :Municipio, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Municipio',
  :Estado, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Estado',
  :catalog, "town_catalog",
  :sat_error_code,"CCE131",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Emisor:Domicilio:Municipio contiene una clave distinta del catálogo catCFDI:c_Municipio donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo Estado.)
},

search_double_key_catalog: {
  :Localidad, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Localidad',
  :Estado, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Estado',
  :catalog, "town_hall_catalog",
  :sat_error_code,"CCE132",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Emisor:Domicilio:Localidad contiene una clave distinta del catálogo catCFDI:c_Localidad donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo Estado.)
},

search_double_key_catalog: {
  :Colonia, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Colonia',
  :CodigoPostal, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@CodigoPostal',
  :catalog, "suburb_catalog",
  :sat_error_code,"CCE133",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Emisor:Domicilio:Colonia contiene una clave distinta del catálogo catCFDI:c_Colonia donde la columna c_CodigoPostal debe ser igual a la clave registrada en el atributo CodigoPostal.)
},

validate_zip_code_data: {
  :CodigoPostal, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@CodigoPostal',
  :Estado, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Estado',
  :Municipio, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Municipio',
  :Localidad, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Localidad',
  :Pais, '//cce11:ComercioExterior/cce11:Emisor/cce11:Domicilio/@Pais',
  :sat_error_code,"CCE134",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Emisor:Domicilio:CodigoPostal contiene una clave distinta del catálogo catCFDI:c_CodigoPostal donde la columna clave de c_Estado debe ser igual a la clave registrada en el atributo Estado, la columna clave de c_Municipio debe ser igual a la clave registrada en el atributo Municipio y si existe el atributo de Localidad, la columna clave de c_Localidad debe ser igual a la clave registrada en el atributo Localidad.)
},

#TODO CCE135

NumRegIdTrib_match_pattern: {
  :NumRegIdTrib, '//cce11:ComercioExterior/cce11:Propietario/@NumRegIdTrib',
  :ResidenciaFiscal, '//cce11:ComercioExterior/cce11:Propietario/@ResidenciaFiscal',
  :sat_error_code,"CCE136",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Propietario:NumRegIdTrib no cumple con el patrón publicado en la columna "Formato de registro de identidad tributaria" del país indicado en el atributo cce1:Propietario:ResidenciaFiscal.)
},

field_presence_by_multiple_atributes: {
  :NumRegIdTrib, ['//cfdi:Comprobante/cfdi:Receptor/@NumRegIdTrib'],
  :atributes, ['//cfdi:Comprobante/cfdi:Receptor[@Rfc="XEXX010101000"]'],
  :sat_error_code,"CCE137",
  :sat_error_message,~s(No se registró información en el atributo "NumRegIdTrib" del nodo "Receptor ".)
},

#TODO CCE138

#///TODO CCE139
NumRegIdTrib_match_pattern: {
  :NumRegIdTrib, '//cce11:ComercioExterior/cce11:Receptor/@NumRegIdTrib',
  :ResidenciaFiscal, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Pais',
  :sat_error_code,"CCE139",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Receptor:NumRegIdTrib tiene un valor que no existe en el registro del país, no cumple con el patrón publicado en la columna "Formato de registro de identidad tributaria" indicado en el atributo cfdi:Comprobante:Receptor:Domicilio:Pais, o no contiene un valor.)
},

NumRegIdTrib_match_pattern: {
  :NumRegIdTrib, '//cce11:ComercioExterior/cce11:Receptor/@NumRegIdTrib',
  :ResidenciaFiscal, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Pais',
  :sat_error_code,"CCE139",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Receptor:NumRegIdTrib tiene un valor que no existe en el registro del país, no cumple con el patrón publicado en la columna "Formato de registro de identidad tributaria" indicado en el atributo cfdi:Comprobante:Receptor:Domicilio:Pais, o no contiene un valor.)
},

search_double_key_catalog_when_country_MEX: {
  :Colonia, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Colonia',
  :CodigoPostal, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@CodigoPostal',
  :Pais, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Pais',
  :catalog, "suburb_catalog",
  :sat_error_code,"CCE140",
  :sat_error_message,~s(La clave del atributo Pais es "MEX" y el atributo cce11:ComercioExterior:Receptor:Domicilio:Colonia no tiene una clave del catálogo de colonia o la clave registrada en la columna código postal es diferente de la registrada en el atributo "CodigoPostal"; o la clave numérica es diferente de cuatro posiciones.)
},

search_double_key_catalog_when_country_MEX: {
  :Localidad, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Localidad',
  :Estado, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Estado',
  :Pais, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Pais',
  :catalog, "town_hall_catalog",
  :sat_error_code,"CCE141",
  :sat_error_message,~s(La clave del atributo Pais es "MEX", el atributo cce11:ComercioExterior:Receptor:Domicilio:Localidad tiene un valor no registrado en el catálogo de localidades catCFDI:c_Localidad; o la clave de la columna c_Estado es distinta a la registrada en el atributo "Estado".)
},

search_double_key_catalog_when_country_MEX: {
  :Municipio, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Municipio',
  :Estado, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Estado',
  :Pais, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Pais',
  :catalog, "town_catalog",
  :sat_error_code,"CCE142",
  :sat_error_message,~s(La clave del atributo Pais es "MEX" y el atributo cce11:ComercioExterior:Receptor:Domicilio:Municipio tiene un valor no registrado en el catálogo de Municipios catCFDI:c_Municipio; o la columna c_Estado es diferente a la clave registrada en el atributo Estado.)
},

validate_country_state_relation: {
  :Estado, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Estado',
  :Pais, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Pais',
  :sat_error_code,"CCE143",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Receptor:Domicilio:Estado tiene una clave diferente del catálogo de estados catCFDI:c_Estado, o el valor de la columna c_Pais es diferente a la clave del país registrada en el atributo Pais.)
},

#///TODO CCE144
zip_code_match_by_cond: {
  :CodigoPostal, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@CodigoPostal',
  :Pais, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Pais',
  :sat_error_code,"CCE144",
  :sat_error_message,~s(La clave registrada en el atributo Pais es distinta de “MEX” y el valor del atributo cce11:ComercioExterior:Receptor:Domicilio:CodigoPostal no cumple con el patrón especificado en el catálogo de países publicado en el portal del SAT para dicha clave, o se encuentra vacío.)
},

validate_zip_code_data: {
  :CodigoPostal, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@CodigoPostal',
  :Estado, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Estado',
  :Municipio, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Municipio',
  :Localidad, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Localidad',
  :Pais, '//cce11:ComercioExterior/cce11:Receptor/cce11:Domicilio/@Pais',
  :sat_error_code,"CCE145",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Receptor:Domicilio:CodigoPostal no contiene una clave del catálogo de códigos postales catCFDI:c_CodigoPostal; o el valor de la columna c_Estado es diferente de la clave registrada en el atributo Estado; o la columna c_Municipio es diferente de la clave registrada en el atributo Municipio; o la columna c_Localidad es distinta a la clave registrada en el atributo Localidad.)
},

unique_node_presence_by_conditions: {
  :ComercioExterior, '//cfdi:Complemento/cce11:ComercioExterior/cce11:Receptor/cce11:Destinatario',
  :conds,['//cfdi:Comprobante[@TipoDeComprobante="T"]'],
  :sat_error_code,"CCE146",
  :sat_error_message,~s(Se registró más de un Destinatario, para el tipo de comprobante "T".)
},

#TODO CCE147

NumRegIdTrib_match_pattern: {
  :NumRegIdTrib, '//cce11:ComercioExterior/cce11:Destinatario/@NumRegIdTrib',
  :ResidenciaFiscal, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Pais',
  :sat_error_code,"CCE148",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Destinatario:NumRegIdTrib  tiene un valor que no existe en el registro del país, no cumple con el patrón publicado en la columna "Formato de registro de identidad tributaria" indicado en el atributo cce11:ComercioExterior:Destinatario:Domicilio:Pais, o no contiene un valor.)
},

search_double_key_catalog_when_country_MEX: {
  :Colonia, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Colonia',
  :CodigoPostal, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@CodigoPostal',
  :Pais, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Pais',
  :catalog, "suburb_catalog",
  :sat_error_code,"CCE149",
  :sat_error_message,~s(La clave del atributo Pais es "MEX" y el atributo cce11:ComercioExterior:Destinatario:Domicilio:Colonia no tiene una clave del catálogo de colonia o la clave registrada en la columna código postal es diferente de la registrada en el atributo "CodigoPostal"; o la clave numérica es diferente de cuatro posiciones.)
},

search_double_key_catalog_when_country_MEX: {
  :Localidad, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Localidad',
  :Estado, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Estado',
  :Pais, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Pais',
  :catalog, "town_hall_catalog",
  :sat_error_code,"CCE150",
  :sat_error_message,~s(La clave del atributo Pais es "MEX" y el atributo cce11:ComercioExterior:Destinatario:Domicilio:Localidad tiene un valor no registrado en el catálogo de localidades catCFDI:c_Localidad; o la clave de la columna c_Estado es distinta a la registrada en el atributo "Estado".)
},

search_double_key_catalog_when_country_MEX: {
  :Municipio, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Municipio',
  :Estado, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Estado',
  :Pais, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Pais',
  :catalog, "town_catalog",
  :sat_error_code,"CCE151",
  :sat_error_message,~s(La clave del atributo Pais es "MEX" y el atributo cce11:ComercioExterior:Destinatario:Domicilio:Municipio tiene un valor no registrado en el catálogo de Municipios catCFDI:c_Municipio; o la columna c_Estado es diferente a la clave registrada en el atributo Estado.)
},

validate_country_state_relation: {
  :Estado, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Estado',
  :Pais, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Pais',
  :sat_error_code,"CCE152",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Destinatario:Domicilio:Estado tiene una clave diferente del catálogo de estados catCFDI:c_Estado, o el valor de la columna c_Pais es diferente a la clave del país registrada en el atributo Pais.)
},


#///TODO CCE153
zip_code_match_by_cond: {
  :CodigoPostal, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@CodigoPostal',
  :Pais, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Pais',
  :sat_error_code,"CCE153",
  :sat_error_message,~s(La clave registrada en el atributo Pais es distinta de “MEX” y valor del atributo cce11:ComercioExterior:Destinatario:Domicilio:CodigoPostal no cumple con el patrón especificado en el catálogo de países publicado en el portal del SAT para dicha clave, o se encuentra vacío.)
},

#///TODO CCE154
validate_zip_code_data: {
  :CodigoPostal, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@CodigoPostal',
  :Estado, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Estado',
  :Municipio, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Municipio',
  :Localidad, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Localidad',
  :Pais, '//cce11:ComercioExterior/cce11:Destinatario/cce11:Domicilio/@Pais',
  :sat_error_code,"CCE145",
  :sat_error_message,~s(El atributo cce11:ComercioExterior:Destinatario:Domicilio:CodigoPostal no contiene una clave del catálogo de códigos postales catCFDI:c_CodigoPostal; o el valor de la columna c_Estado es diferente de la clave registrada en el atributo Estado; o la columna c_Municipio es diferente de la clave registrada en el atributo Municipio; o la columna c_Localidad es distinta a la clave registrada en el atributo Localidad.)
},

presence_of_all_attributes_in_node: {
  :NoIdentificacion,'//cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto',
  :attribute, '//@NoIdentificacion',
  :sat_error_code,"CCE155",
  :sat_error_message,~s(Alguno de los conceptos registrados en el nodo cfdi:Comprobante:Conceptos no contiene el atributo cfdi:Comprobante:Conceptos:Concepto:NoIdentificacion.)
},

rule_CCE156: {
  :NoIdentificacion, '//cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto',
  :Mercancias, '//cce11:ComercioExterior/cce11:Mercancias/cce11:Mercancia',
  :attribute, '//@NoIdentificacion',
  :sat_error_code,"CCE156",
  :sat_error_message,~s(El valor registrado en el atributo cce11:ComercioExterior:Mercancias:Mercancia:NoIdentificacion no corresponde con alguno de los atributos cfdi:Comprobante:Conceptos:Concepto:NoIdentificacion.)
},

reject_identical_combination: {
  :Mercancias, '//cce11:ComercioExterior/cce11:Mercancias/cce11:Mercancia',
  :attributes, ['//@NoIdentificacion','//@FraccionArancelaria'],
  :sat_error_code,"CCE157",
  :sat_error_message,~s(Los valores registrados en los atributos "NoIdentificacion" y "FraccionArancelaria" se repiten en un elemento "Mercancia".)
},

#TODO CCE158
#TODO CCE159
#TODO CCE160
#TODO CCE161
#TODO CCE162
#TODO CCE163
#TODO CCE164
#TODO CCE165
#TODO CCE166
#TODO CCE167

rule_CCE168: {
  :FraccionArancelaria,
  '//cce11:ComercioExterior/cce11:Mercancias/cce11:Mercancia[@FraccionArancelaria="9801000100"]',
  '//cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto', '//@Descuento','//@NoIdentificacion',
  :sat_error_code,"CCE168",
  :sat_error_message,~s(El valor registrado en el atributo FraccionArancelaria es "9801000100" y los valores del atributo cfdi:Comprobante:Conceptos:Concepto:Descuento que se suman, no contienen el mismo valor en el atributo NoIdentificacion; o dicha suma no coincide con la conversión a la moneda que se expresa en el comprobante.)
},
#TODO CCE169
#TODO CCE170

rule_CCE171: {
  :Mercancia, '//cce11:ComercioExterior/cce11:Mercancias/cce11:Mercancia',
  '//@CantidadAduana',
  '//@UnidadAduana',
  '//@ValorUnitarioAduana',
  :sat_error_code,"CCE173",
  :sat_error_message,~s(No se registraron todos o alguno de los atributos CantidadAduana, UnidadAduana o ValorUnitarioAduana.)
},

#TODO CCE172

rule_CCE173: {
  :ValorUnitarioAduana, '//cce11:ComercioExterior/cce11:Mercancias/cce11:Mercancia',
  '//cce11:Mercancia[@ValorUnitarioAduana > "0"]', '//cce11:Mercancia[@UnidadAduana != "99"]',
  :sat_error_code,"CCE173",
  :sat_error_message,~s(El valor del atributo cce11:ComercioExterior:Mercancias:Mercancia:UnidadAduana es igual a "99"o el atributo cce11:ComercioExterior:Mercancias:Mercancia:ValorUnitarioAduana es igual a cero.)
},

#TODO CCE174
#TODO CCE175
#TODO CCE176
#TODO CCE177

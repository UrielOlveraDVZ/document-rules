def check({:field_presence_by_multiple_atributes, rule}, xml_document) do
  {field,required_fields,_,atributes,_,sat_code,_,sat_message} = rule

  exist =
    atributes
    |> Enum.all?(fn atribute ->
      validate_node_presence(atribute, xml_document)
    end)

  case exist do
    true ->
      required_fields
      |> Enum.all?(fn field ->
        validate_node_presence(field, xml_document)
      end)
      |> if do
        {:ok, field}
      else
        {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
      end
    false ->
      {:ok, field}
  end
end
def check({:field_absence_by_multiple_atributes, rule}, xml_document) do
  {field,required_fields,_,atributes,_,sat_code,_,sat_message} = rule

  exist =
    atributes
    |> Enum.all?(fn atribute ->
      IO.inspect validate_node_presence(atribute, xml_document)
    end)

  case exist do
    true ->
      required_fields
      |> Enum.all?(fn field ->
        IO.inspect validate_node_presence(field, xml_document)
      end)
      |> if do
        {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
      else
        {:ok, field}
      end
    false ->
      {:ok, field}
  end
end
def check({:value_match_by_condition, rule}, xml_document) do
  {field,_,values,_,conditions,_,sat_code,_,sat_message} = rule
  conds? =
    conditions
    |> Enum.all?(fn condition ->
      validate_node_presence(condition, xml_document)
    end)

  case conds? do
    true ->
      [head | tail] = values
      first_value = Xml.query(head, xml_document)
      tail
      |> Enum.all?(fn path_value ->
        value = Xml.query(path_value, xml_document)
        first_value == value
      end)
      |> if do
        {:ok, field}
      else
        {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
      end
    false ->
      {:ok, field}
  end
end
def check({:unique_node_presence, rule}, xml_document) do
  {field,path,_,sat_code,_,sat_message} = rule

  number_of_nodes =
    path
    |> Xml.query_multiple(xml_document)
    |> length

  cond do
    number_of_nodes > 1 ->
      {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
    true ->
      {:ok, field}
  end
end
def check({:NumRegIdTrib_match_pattern, rule}, xml_document) do
  {field, numRegIdTrib, _, residenciaFiscal, _, sat_code, _, sat_message} = rule

  residenciaFiscal =
    residenciaFiscal
    |> Xml.query(xml_document)
    |> to_string

  if residenciaFiscal != "" do
    case ConCache.get(:country_catalog, residenciaFiscal) do
      {_,regex, _, _} ->

        numRegIdTrib =
          numRegIdTrib
          |> Xml.query(xml_document)
          |> to_string

        if String.match?(numRegIdTrib, regex) do
          {:ok, field}
        else
          {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
        end
      nil ->
        error_msg = "The value \"#{residenciaFiscal}\" does not exist in the catalog"
        {:error, build_response_struct(field, error_msg, sat_code, sat_message)}
    end
  else
    {:ok, field}
  end
end
def check({:search_double_key_catalog, rule}, xml_document) do
  {field, key1, _, key2, _, catalog, _, sat_code, _, sat_message} = rule
  key1 =
    key1
    |> Xml.query(xml_document)
    |> to_string

  key2 =
    key2
    |> Xml.query(xml_document)
    |> to_string

  if key1 != "" and key2 !="" do
    case ConCache.get(String.to_atom(catalog), {key1, key2}) do
      nil ->
        error_msg = "The value \"{#{key1},#{key2}}\" does not exist in the catalog"
        {:error, build_response_struct(field, error_msg, sat_code, sat_message)}

      _ ->
        {:ok, field}
    end
  else
    {:ok, field}
  end
end
def check({:search_double_key_catalog_when_country_MEX, rule}, xml_document) do
  {field, key1, _, key2, _, pais, _, catalog, _, sat_code, _, sat_message} = rule

  pais =
    pais
    |> Xml.query(xml_document)
    |> to_string

  if pais == "MEX" do
    key1 =
      key1
      |> Xml.query(xml_document)
      |> to_string

    key2 =
      key2
      |> Xml.query(xml_document)
      |> to_string

    case ConCache.get(String.to_atom(catalog), {key1, key2}) do
      nil ->
        error_msg = "The value \"{#{key1}, #{key2}}\" does not exist in the catalog"
        {:error, build_response_struct(field, error_msg, sat_code, sat_message)}

      _ ->
        {:ok, field}
    end
  else
    {:ok, field}
  end
end
def check({:validate_country_state_relation, rule}, xml_document) do
  {field, estado, _, pais, _, sat_code, _, sat_message} = rule

  estado =
    estado
    |> Xml.query(xml_document)
    |> to_string
  pais =
    pais
    |> Xml.query(xml_document)
    |> to_string
  if pais != "ZZZ" do
    case ConCache.get(:state_catalog, estado) do
      {p} ->
        if pais == p do
          {:ok, field}
        else
          {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
        end
      nil ->
        error_msg = "The value \"#{estado}\" does not exist in the catalog"
        {:error, build_response_struct(field, error_msg, sat_code, sat_message)}
    end
  else
    {:ok, field}
  end
end
def check({:validate_zip_code_data, rule}, xml_document) do
  {field, codigoPostal, _, estado, _, municipio, _, localidad, _, pais, _, sat_code, _, sat_message} = rule

  codigoPostal =
    codigoPostal
    |> Xml.query(xml_document)
    |> to_string
  pais =
    pais
    |> Xml.query(xml_document)
    |> to_string

  case ConCache.get(:zip_code_catalog, codigoPostal) do
    {e, m, l, _, _, _, _, _, _, _, _, _, _, _, _} when pais == "MEX" ->

      estado =
        estado
        |> Xml.query(xml_document)
        |> to_string

      municipio =
        municipio
        |> Xml.query(xml_document)
        |> to_string

      localidad =
        localidad
        |> Xml.query(xml_document)
        |> to_string

      if estado == e and municipio == m and (localidad == l or localidad == "") do
        {:ok, field}
      else
        {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
      end

    nil when pais == "MEX" ->
      error_msg = "The value \"#{codigoPostal}\" does not exist in the catalog"
      {:error, build_response_struct(field, error_msg, sat_code, sat_message)}

    _ ->
      {:ok, field}
  end
end
def check({:compare_total_with_sum, rule}, xml_document) do
  {field, path_total, _, path_collection, _, path_values, _, sat_code, _, sat_message} = rule
  values_sum =
    path_collection
    |> Xml.query_multiple(xml_document)
    |> Enum.reduce(Decimal.new("0.0"), fn e, acc ->
      value =
        path_values
        |> Xml.query(e)
        |> to_string
        |> Decimal.new
        |> Decimal.add(acc)
    end)

  total =
    path_total
    |> Xml.query(xml_document)
    |> to_string
    |> Decimal.new

  if Decimal.equal?(values_sum, total) do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end
def check({:round_attribute, rule}, xml_document) do
  {field, value, _, decimals, _, sat_code, _, sat_message} = rule

  value =
    value
    |> Xml.query(xml_document)
    |> to_string

  if String.contains?(value, ".") do
    [_, fraction] =
      value
      |> String.split(".")
    if fraction |> String.length() == decimals do
      {:ok, field}
    else
      {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
    end
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end
def check({:rule_CCE130, rule}, xml_document) do
  {field, path, _, sat_code, _, sat_message} = rule
  estado =
    path
    |> Xml.query(xml_document)
    |> to_string

  pais = ConCache.get(:state_catalog, estado)
  case pais do
    {"MEX"} -> {:ok, field}
    nil ->
      error_msg = "The value \"#{estado}\" does not exist in the catalog"
      {:error, build_response_struct(field, error_msg, sat_code, sat_message)}
    _ -> {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end
def check({:unique_node_presence_by_conditions, rule}, xml_document) do
  {field,path,_,conditions,_,sat_code,_,sat_message} = rule

  conds? =
    conditions
    |> Enum.all?(fn condition ->
      validate_node_presence(condition, xml_document)
    end)
    |> if do
      number_of_nodes =
        path
        |> Xml.query_multiple(xml_document)
        |> length

      cond do
        number_of_nodes > 1 ->
          {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
        true ->
          {:ok, field}
        end
    else
      {:ok, field}
    end
end
def check({:presence_of_all_attributes_in_node, rule}, xml_document) do
  {field, path, _, attribute, _, sat_code, _, sat_message} = rule
  path
  |> Xml.query_multiple(xml_document)
  |> Enum.all?(fn node ->
    validate_node_presence(attribute, node)
  end)
  |> if do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end
def check({:rule_CCE156, rule}, xml_document) do
  {field, concepto_list, _, mercancia_list, _, noIdentificacion, _, sat_code, _, sat_message} = rule
  concepto_list =
    concepto_list
    |> Xml.query_multiple(xml_document)
    |> Enum.map(fn concepto ->
      value_concepto = Xml.query(noIdentificacion, concepto)
    end)
    |> Enum.uniq

  mercancia_list =
    mercancia_list
    |> Xml.query_multiple(xml_document)
    |> Enum.map(fn mercancia ->
      value_mercancia = Xml.query(noIdentificacion, mercancia)
    end)
    |> Enum.uniq

  if mercancia_list -- concepto_list == [] and concepto_list -- mercancia_list  == []do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end
def check({:reject_identical_combination, rule}, xml_document) do
  {field, node_path, _, attributes, _, sat_code, _, sat_message} = rule
  node_collection = Xml.query_multiple(node_path, xml_document)

  combinations =
    node_collection
    |> Enum.map(fn node ->
      attributes
      |> Enum.map(fn attribute ->
        Xml.query(attribute, node)
      end)
    end)

  if combinations |> length == combinations |> Enum.uniq |> length do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end
def check({:rule_CCE168, rule}, xml_document) do
  {field, fraccionArancelaria_list, concepto_list, descuento_path, noIdentificacion_path, _, sat_code, _, sat_message} = rule
  fraccionArancelaria_list =
    fraccionArancelaria_list
    |> Xml.query_multiple(xml_document)
    |> Enum.map(fn fraccionArancelaria ->
      noIdentificacion = Xml.query(noIdentificacion_path, fraccionArancelaria)
      Xml.query_multiple(concepto_list, xml_document)
      |> Enum.reduce(Decimal.new("0.0"), fn concepto, acc ->
        if Xml.query(noIdentificacion_path, concepto) == noIdentificacion do
          descuento =
            descuento_path
            |> Xml.query(concepto)
            |> to_string
            |> Decimal.new
            |> Decimal.add(acc)
          # IO.puts "concepto"
        else
          Decimal.new("0.0")
          |> Decimal.add(acc)
        end
      end)
      |> IO.inspect
    end)
end
def check({:rule_CCE171, rule}, xml_document) do
  {field, mercancias_path, cantidadAduana, unidadAduana, valorUnitarioAduana, _, sat_code, _, sat_message} = rule

  mercancias_path
  |> Xml.query_multiple(xml_document)
  |> Enum.all?(fn mercancia ->
    validate_node_presence(cantidadAduana, mercancia)
    and validate_node_presence(unidadAduana, mercancia)
    and validate_node_presence(valorUnitarioAduana, mercancia)
    # and validate_node_presence(noIdentificacion, mercancia)
  end)
  |> if do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end
def check({:rule_CCE173, rule}, xml_document) do
  {field, mercancias_path, valorUnitarioAduana, unidadAduana, _, sat_code, _, sat_message} = rule

  mercancias_path
  |> Xml.query_multiple(xml_document)
  |> Enum.all?(fn mercancia ->
    validate_node_presence(unidadAduana, mercancia) and
    validate_node_presence(valorUnitarioAduana, mercancia) or
    !validate_node_presence(unidadAduana, mercancia)
  end)
  |> if do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end

# -----------------------------------------------------------------------------------------------------------

def check({:rule_CCE122, rule}, xml_document) do
  {field, paises, numExportadorConfiable, _, sat_code, _, sat_message} = rule
  paises
  |>Enum.all?(fn pais ->
    pais =
      pais
      |>Xml.query(xml_document)
      |> to_string

    pais =
      case ConCache.get(:country_catalog, pais) do
        {_, _, _, agrupacion} when agrupacion == "Union Europea" ->
          if validate_presence(numExportadorConfiable, xml_document) do
            false
          else
            true
          end
        nil ->
          false
        _ ->
          true
      end
      |> IO.inspect
  end)
  |> if do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end
def check({:zip_code_match_by_cond, rule}, xml_document) do
  {field, codigoPostal, _, pais, _, sat_code, _, sat_message} = rule

  pais =
    pais
    |>Xml.query(xml_document)
    |> to_string

  if pais != "MEX" do
    case ConCache.get(:country_catalog, pais) do
      {regex, _, _, _} ->

        codigoPostal =
          codigoPostal
          |>Xml.query(xml_document)
          |> to_string
        if String.match?(codigoPostal, regex) do
          {:ok, field}
        else
          {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
        end
      nil ->
        error_msg = "The value \"#{pais}\" does not exist in the catalog"
        {:error, build_response_struct(field, error_msg, sat_code, sat_message)}
    end
  else
    {:ok, field}
  end
end

def check({:rule_CCE162, rule}, xml_document) do
  {field, tipoDeComprobante, mercancia, concepto, tipoCambio, _, sat_code, _, sat_message} = rule

  tipoCambio =
    if validate_node_presence(tipoDeComprobante, xml_document) do
      tipoCambio
      |>Xml.query(xml_document)
      |> to_string
      |> Decimal.new
    else
      tipoCambio = Decimal.new("1")
    end
  mercancias =
    mercancia
    |>Xml.query_multiple(xml_document)
    |> Enum.all?(fn m ->

      cantidadAduana =
       Xml.query('//@CantidadAduana', m)
        |> to_string
      valorUnitarioAduana =
       Xml.query('//@ValorUnitarioAduana', m)
        |> to_string

      limite_sup = calculate_higher_limit(cantidadAduana, valorUnitarioAduana, 2, :CCE)
      limite_inf = calculate_lower_limit(cantidadAduana, valorUnitarioAduana, 2, :CCE)

      valorDolares =
       Xml.query('//@ValorDolares', m)
        |> to_string
        |> Decimal.new
      nim =Xml.query('//@NoIdentificacion', m)
      nic_path = ~c(#{concepto}[@NoIdentificacion="#{nim}"])

      conceptos_sum =
        nic_path
        |>Xml.query_multiple(xml_document)
        |> Enum.reduce(Decimal.new("0.0"), fn c, acc ->
          importe =
           Xml.query('//@Importe', c)
            |> to_string
            |> Decimal.new
            |> Decimal.add(acc)
        end)
        |> Decimal.div(tipoCambio)
        |> Decimal.round(2)

      Decimal.cmp(conceptos_sum, valorDolares) == :eq and Decimal.cmp(conceptos_sum, limite_sup) == :lt and Decimal.cmp(conceptos_sum, limite_inf) == :gt
    end)
    |> if do
      {:ok, field}
    else
      {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
    end
end
def check({:rule_CCE164, rule}, xml_document) do
  {field, mercancias, concepto, _, sat_code, _, sat_message} = rule

  mercancias =
    mercancias
    |>Xml.query_multiple(xml_document)
    |> Enum.all?(fn m ->
      nim =Xml.query('//@NoIdentificacion', m)
      nic_path = ~c(#{concepto}[@NoIdentificacion="#{nim}"])
      ifXml.query('//@UnidadAduana', m) |> to_string != "99" do
        conceptos =
          nic_path
          |>Xml.query_multiple(xml_document)
          |> Enum.all?(fn c ->
           Xml.query('//@Unidad', c) |> to_string != "E48"
          end)
      else
        false
      end

    end)
    |> if do
      {:ok, field}
    else
      {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
    end
end
def check({:rule_CCE165, rule}, xml_document) do
  {field, mercancias, concepto, _, sat_code, _, sat_message} = rule

  mercancias =
    mercancias
    |>Xml.query_multiple(xml_document)
    |> Enum.all?(fn m ->
      nim =Xml.query('//@NoIdentificacion', m)
      nic_path = ~c(#{concepto}[@NoIdentificacion="#{nim}"])
      ifXml.query('//@UnidadAduana', m) |> to_string == "99" do
        conceptos =
          nic_path
          |>Xml.query_multiple(xml_document)
          |> Enum.all?(fn c ->
           Xml.query('//@Unidad', c) |> to_string == "E48"
          end)
      else
        false
      end

    end)
    |> if do
      {:ok, field}
    else
      {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
    end
end
def check({:rule_CCE166, rule}, xml_document) do
  {field, mercancia, fecha, _, sat_code, _, sat_message} = rule
  mercancia
  |>Xml.query_multiple(xml_document)
  |> Enum.all?(fn m ->
    fraccionArancelaria =Xml.query('//@FraccionArancelaria', m) |> to_string
    case ConCache.get(:fraccion_arancelaria_catalog, fraccionArancelaria) do
      {date_init, date_end, umt} ->
        [date, _time] =
          fecha
          |>Xml.query(xml_document)
          |> to_string
          |> String.split("T")

        date = date |> Date.from_iso8601!

        date_init = if date_init != "", do: date_init |> Date.from_iso8601!, else: ~D[1900-01-01]
        date_end = if date_end != "", do: date_end |> Date.from_iso8601!, else: ~D[2999-12-31]

        if Date.compare(date, date_init) == :lt or Date.compare(date, date_end) == :gt do
          false
        else
          unidadAduana =
           Xml.query('//@UnidadAduana', m)
            |> to_string
          unidadAduana == umt or unidadAduana == ""
        end

      nil ->
        false
    end
  end)
  |> if do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end
def check({:rule_CCE170, rule}, xml_document) do
  {field, concepto, mercancia, attributes, _, sat_code, _, sat_message} = rule
  mercancia
  |>Xml.query_multiple(xml_document)
  |> Enum.all?(fn m ->

    nim =Xml.query('//@NoIdentificacion', m)
    nic_path = ~c(#{concepto}[@NoIdentificacion="#{nim}"])

    cond1 =
      attributes
      |> Enum.filter(fn attribute ->
       Xml.query(attribute, m) != []
      end)
      |> length()
    cond2 =
      nic_path
      |>Xml.query_multiple(xml_document)
      |> length()

    if cond1 == length(attributes) do
      true
    else
      if cond1 == 0 and cond2 < 2 do
        true
      else
        false
      end
    end
  end)
  |> if do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end

def check({:rule_CCE174, rule}, xml_document) do
  {field, mercancias, _, sat_code, _, sat_message} = rule
  mercancias
  |>Xml.query_multiple(xml_document)
  |> Enum.all?(fn m ->

    cantidadAduana =
     Xml.query('//@CantidadAduana', m)
      |> to_string
    valorUnitarioAduana =
     Xml.query('//@ValorUnitarioAduana', m)
      |> to_string

    limite_sup = calculate_higher_limit(cantidadAduana, valorUnitarioAduana, 2, :CCE)
    limite_inf = calculate_lower_limit(cantidadAduana, valorUnitarioAduana, 2, :CCE)

    valorDolares =
     Xml.query('//@ValorDolares', m)
      |> to_string
      |> Decimal.new

    Decimal.cmp(valorDolares, limite_sup) == :lt and Decimal.cmp(valorDolares, limite_inf) == :gt
  end)
  |> if do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end

def check({:rule_CCE176, rule}, xml_document) do
  {field, nodes_list, condition, _, sat_code, _, sat_message} = rule
  nodes_list
  |>Xml.query_multiple(xml_document)
  |> Enum.all?(fn node ->
    caseXml.query(condition, node) do
      [] ->
        cantidadAduana =
         Xml.query('//@CantidadAduana', node)
          |> to_string
        valorUnitarioAduana =
         Xml.query('//@ValorUnitarioAduana', node)
          |> to_string

        limite_sup = calculate_higher_limit(cantidadAduana, valorUnitarioAduana, 2, :CCE)
        limite_inf = calculate_lower_limit(cantidadAduana, valorUnitarioAduana, 2, :CCE)

        valorDolares =
         Xml.query('//@ValorDolares', node)
          |> to_string
          |> Decimal.new

        Decimal.cmp(valorDolares, limite_sup) == :lt and Decimal.cmp(valorDolares, limite_inf) == :gt
      _ ->
        true
    end
  end)
  |> if do
    {:ok, field}
  else
    {:error, build_response_struct(field, sat_message, sat_code, sat_message)}
  end
end

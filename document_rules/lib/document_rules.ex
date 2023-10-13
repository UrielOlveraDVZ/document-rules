defmodule DocumentRules do
  # alias JasonVendored.Encoder.Decimal
  alias XmlUtilities, as: Xml

  defmodule SatField do
    defstruct [:code, :field, :message, :sat_error_code, :sat_error_message]
  end

  def binary_to_string(binary) do
    codepoints = String.codepoints(binary)
    Enum.reduce(codepoints, fn(w, result) ->
      cond do
        String.valid?(w) ->
          result <> w
        true ->
          << parsed :: 8>> = w
          result <>   << parsed :: utf8 >>
      end
    end)
  end

  def read_document(path_file) do
    xml = case File.read(path_file) do
      {:ok, xml} -> xml
      {:error, x} -> ({:error, x})
    end

    xml_document = binary_to_string(xml)
    # {:ok, xml_document} = read(xml_document)


  end
  # /home/dozenth/Codes/DVZ/documentRules/insumosXML/xml.xml
  # /home/dozenth/Documentos/DVZ/validate_schema/SGM950714DC2_80c71948-8dc9-45b2-872c-85ebc48f5792_original.xml
  def ask() do
    path_file = ~s(/home/dozenth/Documentos/DVZ/validate_schema/SGM950714DC2_80c71948-8dc9-45b2-872c-85ebc48f5792_original.xml)
    xml_document = read_document(path_file)
    xml_document = Base.encode64 xml_document

    url = "http://localhost:4001/api/v2/documents/issue"
    headers = ["Content-Type": "application/json"]
    body =
      %{
        "credentials": %{
          "id": "124362",
          "token": "$2b$12$LELRpMesaOFU31qTO9mJ3.zI0q84aqCM0Tf7MUe0Npm6oQpAuOqoS"
          },
        "issuer": %{
          "rfc": "FUNK671228PH6"
        },
        "receiver": %{
          "rfc": "",
          "emails": [
            %{
              "email": "uriel.olvera@diverza.com",
              "format": "xml",
              "template": "letter"
            }
          ]
        },
        "document": %{
          "certificate-number": "30001000000400002495",
          "section": "all",
          "format": "xml",
          "template": "letter",
          "type": "application/vnd.diverza.cfdi_4.0+xml",
          "content": xml_document
        }
      }
    HTTPoison.post(url, Jason.encode!(body), headers, [recv_timeout: 50_000])
  end

  def handle() do

    # read file
    path_file = ~s(/home/dozenth/Codes/DVZ/documentRules/insumosXML/PROD-2565_02.xml)

    xml = case File.read(path_file) do
      {:ok, xml} -> xml
      {:error, x} -> IO.inspect({:error, x})
    end

    xml_document = :erlang.bitstring_to_list(xml)
    {:ok, xml_document} = read(xml_document)
    # IO.inspect xml

    # load cache
    ConCache.start_link([], name: :currency_catalog)
    ConCache.start_link([], name: :country_catalog)                 #Pais
    ConCache.start_link([], name: :state_catalog)                   #Estado
    ConCache.start_link([], name: :suburb_catalog)                  #Colonia
    ConCache.start_link([], name: :town_catalog)                    #Municipio
    ConCache.start_link([], name: :town_hall_catalog)               #Localidad
    ConCache.start_link([], name: :zip_code_catalog)                #Localidad
    ConCache.start_link([], name: :fraccion_arancelaria_catalog)    #FraccionArancelaria

    ConCache.put(:currency_catalog, "MXN", {~r/^\d+(\.\d{1,2})?$/,2,Decimal.new(500),Decimal.new(1)})
    ConCache.put(:currency_catalog, "USD", {~r/^\d+(\.\d{1,2})?$/,2,Decimal.new(500),Decimal.new(1)})
    ConCache.put(:currency_catalog, "AED", {~r/^\d+(\.\d{1,2})?$/,2,Decimal.new(500),Decimal.new(10)})
    ConCache.put(:currency_catalog, "AFN", {~r/^\d+(\.\d{1,2})?$/,2,Decimal.new(500),Decimal.new(10)})

    ConCache.put(:country_catalog, "DEU", {~r/^.*$/,~r/^.*$/,"","Union Europea"})
    ConCache.put(:country_catalog, "ESP", {~r/^.*$/,~r/^.*$/,"","Union Europea"})
    ConCache.put(:country_catalog, "ITA", {~r/^.*$/,~r/^.*$/,"","Union Europea"})
    ConCache.put(:country_catalog, "CAN", {~r/^[A-Z][0-9][A-Z] [0-9][A-Z][0-9]$/,~r/^[0-9]{9}$/,"","TLCAN"})
    ConCache.put(:country_catalog, "USA", {~r/^[0-9]{5}(-[0-9]{4})?$/,~r/^[0-9]{9}$/,"","TLCAN"})
    ConCache.put(:country_catalog, "MEX", {~r/^[0-9]{5}$/,~r/^[A-Z&Ñ]{3,4}[0-9]{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[A-Z0-9]{2}[0-9A]$/,"","TLCAN"})
    ConCache.put(:country_catalog, "ZZZ", {~r/^.*$/,~r/^.*$/,"",""})

    ConCache.put(:state_catalog, "NLE", {"MEX"})
    ConCache.put(:state_catalog, "OAX", {"MEX"})
    ConCache.put(:state_catalog, "JAL", {"MEX"})
    ConCache.put(:state_catalog, "TX", {"USA"})
    ConCache.put(:state_catalog, "NT", {"CAN"})
    # IO.inspect ConCache.get(:state_catalog, "NLE")

    ConCache.put(:town_catalog, {"001","AGU"}, {"Aguascalientes"})
    ConCache.put(:town_catalog, {"120","JAL"}, {"Zapopan"})
    ConCache.put(:town_hall_catalog, {"01","AGU"}, {"Aguascalientes"})
    ConCache.put(:town_hall_catalog, {"10","JAL"}, {"Zapopan"})
    ConCache.put(:suburb_catalog, {"0001","01000"}, {"San Ángel"})
    ConCache.put(:suburb_catalog, {"0866","45199"}, {"Benito Juárez"})
    ConCache.put(:zip_code_catalog, "00000", {"AGU","000","00","1","Tiempo del Centro","1/7/19","1/7/19","Abril","Primer domingo","02:00","-5","Octubre","Último domingo","02:00","-6"})
    ConCache.put(:zip_code_catalog, "45199", {"JAL","120","10","0","Tiempo del Centro","1/7/19","1/7/19","Abril","Primer domingo","02:00","-5","Octubre","Último domingo","02:00","-6"})

    ConCache.put(:fraccion_arancelaria_catalog, "01011001", {"2012-07-02","","07"})
    ConCache.put(:fraccion_arancelaria_catalog, "68101101", {"2020-12-28","","01"})
    ConCache.put(:fraccion_arancelaria_catalog, "9801000100", {"2020-12-28","","01"})



    rules = [

      testHello: {
        :test, 'hello world',
        :name, '//cfdi:Conceptos/cfdi:Concepto/@NoIdentificacion',
        :code, 'TEST01'
      }
      # validate_transfer_rfc_receiver_againts_issuer_rfc: {
      #   :TipoDeComprobante,'//cfdi:Comprobante[@TipoDeComprobante = "T"]',
      #   :issuer_rfc,'//cfdi:Comprobante/cfdi:Emisor/@Rfc',
      #   :receiver_rfc,'//cfdi:Comprobante/cfdi:Receptor/@Rfc',
      #   :system_message,~s(El valor del atributo "Comprobante:TipoDeComprobante" es diferente de "T" y el valor registrado en el atributo "Comprobante:Receptor:Rfc" es diferente al  registrado en "Comprobante:Emisor:Rfc".),
      #   :sat_error_code,"CP106",
      #   :sat_error_message,~s(El valor del atributo "Comprobante:TipoDeComprobante" es diferente de "T" y el valor registrado en el atributo "Comprobante:Receptor:Rfc" es diferente al  registrado en "Comprobante:Emisor:Rfc".)},


      # validate_car_net_weight_value: {
      #   :"TransporteFerroviario:Carro:ToneladasNetasCarro",
      #   '//cartaporte20:CartaPorte/cartaporte20:Mercancias/cartaporte20:TransporteFerroviario/cartaporte20:Carro',
      #   '//cartaporte20:Contenedor',
      #   '//cartaporte20:Contenedor/@PesoNetoMercancia',
      #   '@ToneladasNetasCarro',
      #   :unidadPeso, '//cfdi:Comprobante/cfdi:Complemento/cartaporte20:CartaPorte/cartaporte20:Mercancias/@UnidadPeso',
      #   :system_message,~s(No existe el atributo "Carro:ToneladasNetasCarro", está vacío, o la suma no corresponde con los valores registrados en el atributo "Contenedor:PesoNetoMercancia".),
      #   :sat_error_code,"CP169",
      #   :sat_error_message,~s(No existe el atributo "Carro:ToneladasNetasCarro", está vacío, o la suma no corresponde con los valores registrados en el atributo "Contenedor:PesoNetoMercancia".)},

    ] |> Enum.map(fn {k, v} -> {
      check({k, v}, xml_document)
    } end)

  end

  # functions
  def check({:validate_transfer_rfc_receiver_againts_issuer_rfc, rule}, xml_document) do
    {field,path_main_validation,_,path_rfc,_,path_second_rfc,
      _,system_message,_,sat_code,_,sat_message} = rule
    with value when value != [] <- Xml.query_multiple(path_main_validation, xml_document),
                        :false  <- (second_rfc = Xml.query(path_second_rfc, xml_document)
                                    Xml.query(path_rfc, xml_document) == second_rfc) do
        {:error, build_response_struct(field, system_message, sat_code, sat_message)}
    else _ ->
      {:ok, ""}
    end
  end
  def check({:validate_car_net_weight_value, rule}, xml_document) do
    {
      field,
      path_carro,
      path_contenedor,
      path_peso_neto_mercancia,
      path_toneladas_netas_carro,
      unidadPeso_field,
      path_unidadPeso,
      _,
      system_message,
      _,
      sat_code,
      _,
      sat_message
    } = rule

    unidadPeso = Xml.query(path_unidadPeso, xml_document)
    Xml.query_multiple(path_carro, xml_document)
    |> Enum.map(fn carro ->
      if Xml.query(path_peso_neto_mercancia, carro) != [] do
        toneladas_netas_carro =
          Xml.query(path_toneladas_netas_carro, carro)
          |> List.to_string
          |> Decimal.new
          |> IO.inspect
        suma_peso_neto_mercancias =
          Xml.query_multiple(path_contenedor, carro)
          |> Enum.map(fn contenedor ->
            Xml.query('@PesoNetoMercancia', contenedor)
            |> List.to_string
            |> empty_string_to_zero_string
            |> Decimal.new
          end)
          |> Enum.reduce(Decimal.new(0), &Decimal.add/2)
          |> Decimal.new
          |> IO.inspect

        x = conversionFactor('TNE', unidadPeso)

        toneladas_netas_carro =
          toneladas_netas_carro
          |> Decimal.mult(x)
          |> Decimal.new
          |> IO.inspect

        Decimal.equal?(suma_peso_neto_mercancias, toneladas_netas_carro)

      else
        Xml.query(path_toneladas_netas_carro, carro) != []
      end
    end)
    |> Enum.all?
    |> if do
      {:ok, ""}
    else
      {:error, build_response_struct(field, system_message, sat_code, sat_message)}
    end
  end

  def empty_string_to_zero_string(string) do
    case string do
     ""-> "0"
     _ -> string
    end
  end

  def conversionFactor(fromUnity, toUnity) do
    cond do
      fromUnity == 'TNE' and toUnity == 'TNE' -> "1"
      fromUnity == 'TNE' and toUnity == 'KGM' -> "1000"
      fromUnity == 'TNE' and toUnity == 'GRM' -> "1000000"
      fromUnity == 'TNE' and toUnity == 'MGM' -> "1000000000"
      fromUnity == 'KGM' and toUnity == 'TNE' -> "0.001"
      fromUnity == 'KGM' and toUnity == 'KGM' -> "1"
      fromUnity == 'KGM' and toUnity == 'GRM' -> "1000"
      fromUnity == 'KGM' and toUnity == 'MGM' -> "1000000"
      fromUnity == 'GRM' and toUnity == 'TNE' -> "0.000001"
      fromUnity == 'GRM' and toUnity == 'KGM' -> "0.001"
      fromUnity == 'GRM' and toUnity == 'GRM' -> "1"
      fromUnity == 'GRM' and toUnity == 'MGM' -> "1000"
      fromUnity == 'MGM' and toUnity == 'TNE' -> "0.000000001"
      fromUnity == 'MGM' and toUnity == 'KGM' -> "0.000001"
      fromUnity == 'MGM' and toUnity == 'GRM' -> "0.001"
      fromUnity == 'MGM' and toUnity == 'MGM' -> "1"
    end
  end

  def string_to_decimal(number) do
    try do
      number
      |> Decimal.new
    rescue
      e in Decimal.Error -> :error
    end
  end

  @spec check(tuple(), list()) :: atom()
  def check({:testHello, rule}, xml_document) do
    {
      field, msg,
      _, path_name,
      _, code
    } = rule
    IO.puts "===== [#{code}: #{msg}]"

    path_name
    |> query(xml_document)
    |> IO.puts
    :ok
  end

  # ------------------------------------------------------------------------------------------------
  def truncate(value, position) do
    case String.split(value,".") do
      [_] ->
        value
      [p,s] ->
        {new_scale,_} = String.split_at s, position
        p <> "." <> new_scale
    end
  end

  # def get_decimals(amount = %Decimal{}) do
  #   amount
  #   |> Decimal.to_string
  #   |> String.reverse
  #   |> :binary.match(".")
  #   |> case do
  #       :nomatch -> 0
  #       {value, _} -> value
  #     end
  # end

  def get_decimals(amount) do
    amount
    |> to_string
    |> String.reverse
    |> :binary.match(".")
    |> case do
        :nomatch -> 0
        {value, _} -> value
      end
  end

  def verify_on_error_response(result, field, system_message, sat_code, sat_message) do
    case Enum.member?(result, :error) do
      true -> {:error, build_response_struct(field, system_message, sat_code, sat_message)}
      false -> {:ok, ""}
    end
  end

  def validate_node_absence(path, xml_document) do
    case query_multiple(path, xml_document) do
      [] -> true
      _ -> false
    end
  end

  def validate_node_presence(path, xml_document) do
    case query_multiple(path, xml_document) do
      [] -> false
      _ -> true
    end
  end

  def validate_absence(path,xml_document) do
    case query(path,xml_document) do
      [] -> true
      _ -> false
    end
  end

  def validate_presence(path, xml_document) do
    case query(path, xml_document) do
      [] -> false
      _ -> true
    end
  end

  defp prepare_response(result, xml_document, field \\ "") do
    case result do
      {:ok, _} -> {:ok, field}
      [] -> {:ok, field}
      _ ->
        flag =
          '//cfdi:Emisor/@Rfc'
          |> query(xml_document)
          |> to_string
          |> (&ConCache.get(:client_new_response_flags, &1)).()

        with "true" <- Application.get_env(:orpheus, :config)[:global_new_response_flag],
          {_, true} <- (if is_nil(flag) do {"", false} else flag end) do
               # true <- length(result) == 1 do
          result =
            case result do
              {:error, error_map} -> [clean_messages(error_map)]
              _ -> clean_messages(result)
            end
          if length(result) == 1 do
            [result] = result
            {:error, result}
          else
            {:list_add, result}
          end
        else _ ->
          case result do
            {:error, _} -> result
            _ -> {:list, result}
          end
        end
    end
  end

  defp clean_messages(result) do
    if is_map(result) do
      %{result | message: String.trim_trailing(result.message, "}")}
    else
      Enum.map(result, fn result -> %{result | message: String.trim_trailing(result.message, "}")} end)
    end
  end

  def result_iterator([{:ok, sum_field}|validation_results]) do
    case validation_results do
      [head | tail] ->
        result_iterator([head | tail])
      [] ->
        {:ok, sum_field}
    end

  end

  def result_iterator([{:error, error}|_]) do
    {:error, error}
  end

  def result_iterator([]), do: []

 #------------------------------------------------------------------------------------------------

  def build_response_struct(field, system_message, sat_code, sat_message) do
    %SatField{
      code: 1450,
      field: field,
      message: system_message,
      sat_error_code: sat_code,
      sat_error_message: convert_to_utf8(sat_message)
    }
  end

  def read (xml) do
    try do
      {xml_document, _} = :xmerl_scan.string(xml, [{:namespace_conformant, true}])
      {:ok, xml_document}
    catch
      :exit, _ -> {:error, "invalid xml file, xml can't be parsed"}
    end
  end

  def query(xpath, xml) do
    case :xmerl_xpath.string('#{xpath}', xml) do
      [result] ->
        res = elem(result, 8)
        case is_list(res) do
          true ->
            res
          false ->
            res
            |> to_string
            |> String.strip
        end
      [head | _] ->
        res = elem(head, 8)
        case is_list(res) do
          true ->
            res
          false ->
            res
            |> to_string
            |> String.strip
        end
      [] -> []
    end
  end

  def query_multiple(xpath, xml) do
    case :xmerl_xpath.string('#{xpath}', xml) do
      [head | tail] -> [head | tail]
      [] -> []
    end
  end

  def convert_to_utf8(data) do
    cond do
      is_nil(data) ->
        :nil
      true ->
        case String.valid?(data) do
          false ->
            Enum.join(for <<c <- data>>, do: <<c :: utf8>>)
          true ->
            data
        end
    end
  end

  def find_rfc(value) do
    value
  end

  def get_country(country) do
  #  ConCache.put(:country_catalog, "DEU", {~r/^.*$/,~r/^.*$/,"","Union Europea"})
  #  ConCache.put(:country_catalog, "CAN", {~r/^[A-Z][0-9][A-Z] [0-9][A-Z][0-9]$/,~r/^[0-9]{9}$/,"","TLCAN"})
  #  ConCache.put(:country_catalog, "USA", {~r/^[0-9]{5}(-[0-9]{4})?$/,~r/^[0-9]{9}$/,"","TLCAN"})
  #  ConCache.put(:country_catalog, "MEX", {~r/^[0-9]{5}$/,~r/^[A-Z&Ñ]{3,4}[0-9]{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[A-Z0-9]{2}[0-9A]$/,"","TLCAN"})

  #  {
  #    Formato de código postal,
  #    Formato de Registro de Identidad Tributaria,
  #    Validación del Registro de Identidad Tributaria,
  #    Agrupaciones
  #  }

  #  {
  #    ~r/^[0-9]{5}$/,
  #    ~r/^[A-Z&Ñ]{3,4}[0-9]{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[A-Z0-9]{2}[0-9A]$/,
  #    "",
  #    "TLCAN"
  #  }

    {
      ~r/^[A-Z][0-9][A-Z] [0-9][A-Z][0-9]$/,
      ~r/^[0-9]{9}$/,
      "",
      "TLCAN"
    }
  end

  def get_unity(_unity) do
    {"", "", "", "yd/psi", "Volumen"}
    # nil
  end

  def get_clave(_clave) do
    #{"0", "", ""}
  :ok
  end

  defp get_material_peligroso(item) do
    {"1.1D"}
  end

  defp get_zip_code(zip_code) do
    {"NLE",
      "039",
      "07",
      "0",
      "43472",
      "43752",
      "Tiempo del Centro",
      "Abril",
      "Primer domingo",
      "02:00",
      "-5",
      "Octubre	",
      "Último domingo",
      "02:00",
      "-6"
    }
  end

  def get_station(station) do
    :nil
    :ok
  end

  def get_state(state) do
    if "WWW" == state || "XXX" == state do
      :nil
    else
      state
    end
  end

  def get_city(city) do
    #    :nil
    {"001","AGU"}
  end
end

defmodule XmlUtilities do

  def handle() do
    path_file = ~s(/home/dozenth/Codes/DVZ/documentRules/insumosXML/document.xml)

    xml = case File.read(path_file) do
      {:ok, xml} -> xml
      {:error, x} -> IO.inspect({:error, x})
    end

    xml_document = :erlang.bitstring_to_list(xml)
    {:ok, xml_document} = read(xml_document)


    #--------------------------------------------------------------------------------------------------------

    query('//cfdi:Comprobante/cfdi:Emisor/@Rfc', xml_document)
  end

  def remove_cfdi_relacionados_node(xml) do
    xml
    |> elem(8)
    # |> IO.inspect
    |> Enum.flat_map(fn node ->
      case elem(node, 1) do
        :"cfdi:CfdiRelacionados" -> []
        _ -> [node]
      end
    end)
    |> (&put_elem(xml, 8, &1)).()
  end

  #{uuids|>Enum.each(fn uuid -> uuid end)}


  def add_cfdi_relacionados_node(xml, uuids) do
    new_node =
      """
      <cfdi:Comprobante>
        <cfdi:CfdiRelacionados TipoRelacion="04">
          #{uuids|>Enum.map(fn uuid -> ~s(<cfdi:CfdiRelacionado UUID="#{uuid}"/>\n) end)}
        </cfdi:CfdiRelacionados>
      </cfdi:Comprobante>
      """
      |> :erlang.bitstring_to_list
      |> :xmerl_scan.string
      |> elem(0)
      |> elem(8)
      |> Enum.at(1)
      |> IO.inspect

    xml
    |> elem(8)
    |> List.insert_at(1, new_node)
    |> (&put_elem(xml, 8, &1)).()

  end

  def create_list_elems(elements, node_name) do
    elements
    |> Enum.map(fn element ->
      {String.to_atom(node_name), [{:UUID, element}], []}
    end)
  end

  defp update_exist_node(xml_document,uuid) do
    # IO.inspect query('//cfdi:CfdiRelacionados',xml_document)
    comp = query('//cfdi:CfdiRelacionados',xml_document)
    stamp = {:"cfdi:CfdiRelacionado",[{:UUID, uuid}],[]}
    {:"cfdi:CfdiRelacionados",[comp,stamp]}
  end

  defp replace_node([head|tail],node_to_rep) do
    case query('//cfdi:CfdiRelacionados',head) do
      [] ->
        [head|replace_node(tail,node_to_rep)]
      _node ->
        [node_to_rep|replace_node(tail,node_to_rep)]
    end
  end

  defp replace_node([],_), do: []

  #-------------------------------------------------------------------------------------------------------------------
  def string_to_xml_document(path_document) do
    xml = case File.read(path_document) do
      {:ok, xml} -> xml
      {:error, x} -> IO.inspect({:error, x})
    end
    xml
    |> :erlang.bitstring_to_list
    |> read
    |> elem(1)
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
end

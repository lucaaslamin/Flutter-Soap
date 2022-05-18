import 'package:app_crm/Controller/connection_controller.dart';
import 'package:app_crm/Pages/Conexao/DTO/clientesDTO.dart';
import 'package:app_crm/Tratamento/confirmacao_page.dart';
import 'package:app_crm/Tratamento/error_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

Future<List<ClientsDTO>> representanDT(BuildContext context) async {
  String field = fieldController.text;
  String urlPage = urlController.text;
  String url = (urlPage.toString() +
      '(insert url)' +
      '(insert table field)=' +
      field.toString());
  var client = Dio();
  var options = Options(headers: {'Content-Type': 'text/xml;charset=utf-8'});
  var response = await client.get(url, options: options);
  final document = XmlDocument.parse(response.toString());
  final element = document.findAllElements('item');
  var list = <ClientsDTO>[];
  print(document);
  element.forEach((element) {
    String replace = element.text.replaceAll("|", " - ");
    String id = replace.split('-')[0].trim();
    var clientDTO =
        ClientsDTO(dsNome: '${replace.substring(0)}', campoDesejado: id);
    list.add(clientDTO);
  });
  return list;
}

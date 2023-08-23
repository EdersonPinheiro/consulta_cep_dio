import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CreateCep extends StatefulWidget {
  const CreateCep({super.key});

  @override
  State<CreateCep> createState() => _CreateCepState();
}

class _CreateCepState extends State<CreateCep> {
  TextEditingController txtcep = TextEditingController();
  String resultado = '';
  final Dio dio = Dio();

  void consultaCep() async {
    String cep = txtcep.text;
    String url = 'https://viacep.com.br/ws/$cep/json/';

    Dio dio = Dio();

    try {
      Response response = await dio.get(url);

      print("Raw Response: ${response.data}");

      Map<String, dynamic> retorno = response.data;
      String logradouro = retorno['logradouro'];
      String cidade = retorno['localidade'];
      String bairro = retorno['bairro'];

      getCepEspecific(cep);

      setState(() {
        resultado = "$logradouro, $bairro, $cidade";
      });
    } catch (e) {
      print("Error: $e");
      // Handle the error gracefully, e.g., show an error message to the user.
    }
  }

  Future<void> getCepEspecific(String cep) async {
    dio.options.headers = {
      'X-Parse-Application-Id': 'gI2AjpmKfwBzSWi9oM1NA6IS1yEMtSOo02T1jmho',
      'X-Parse-REST-API-Key': 'dPLailxs59y8EaZl9I64Fw05TorTiKevZ0Tgxjfy',
    };

    try {
      final response = await dio.post(
          'https://parseapi.back4app.com/parse/functions/get-cep-especific',
          options: Options(
            headers: {
              'X-Parse-Application-Id':
                  'gI2AjpmKfwBzSWi9oM1NA6IS1yEMtSOo02T1jmho',
              'X-Parse-REST-API-Key':
                  'dPLailxs59y8EaZl9I64Fw05TorTiKevZ0Tgxjfy',
            },
          ),
          data: {"cep": cep});

      if (response.data != null) {
        print("esse cep já existe no back4app");
      } else {
        print("Cadastrar Cep Novo");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              controller: txtcep,
              decoration: InputDecoration(
                labelText: 'CEP',
              ),
            ),
            Text(
              'Resultado : ${resultado}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(surfaceTintColor: Colors.amber),
                onPressed: () {
                  consultaCep();
                },
                child: const Text(
                  'Consultar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}

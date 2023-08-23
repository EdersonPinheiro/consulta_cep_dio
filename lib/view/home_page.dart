import 'package:consulta_cep_dio/model/cep.dart';
import 'package:consulta_cep_dio/view/create_cep.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio dio = Dio();
  List<CEP> cepList = <CEP>[].obs;

  @override
  void initState() {
    super.initState();
    getCeps();
  }

  Future<void> getCeps() async {
    dio.options.headers = {
      'X-Parse-Application-Id': 'gI2AjpmKfwBzSWi9oM1NA6IS1yEMtSOo02T1jmho',
      'X-Parse-REST-API-Key': 'dPLailxs59y8EaZl9I64Fw05TorTiKevZ0Tgxjfy',
    };

    try {
      final response = await dio
          .post('https://parseapi.back4app.com/parse/functions/get-cep-info');

      if (response.data["result"] != null) {
        cepList = (response.data["result"] as List)
            .map((data) => CEP.fromJson(data))
            .toList();
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Consulta Cep'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: cepList.length,
          itemBuilder: (BuildContext context, int index) {
            CEP cep = cepList[index];
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Make the name and IMC labels 100% width
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "CEP: ${cep.cep}",
                      ),
                    ),
                    Row(children: [
                      Text("Rua: ${cep.logradouro}"),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Cidade: ${cep.localidade}",
                          textAlign: TextAlign.center),
                      Text(
                        " - UF: ${cep.uf}",
                        textAlign: TextAlign.end,
                      ),
                    ]),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search_outlined),
        onPressed: () {
          Get.to(CreateCep());
        },
      ),
    );
  }
}

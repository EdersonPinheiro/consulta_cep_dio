import 'package:consulta_cep_dio/controller/cep_controller.dart';
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
  CepController cepController = CepController();
  final Dio dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cepController.getCeps();
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
          itemCount: cepController.cepList.length,
          itemBuilder: (BuildContext context, int index) {
            CEP cep = cepController.cepList[index];
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
        child: Icon(Icons.add_outlined),
        onPressed: () {
          Get.to(CreateCep());
        },
      ),
    );
  }
}

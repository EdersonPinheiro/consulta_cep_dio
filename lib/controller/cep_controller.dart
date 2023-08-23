import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../model/cep.dart';

class CepController {
  List<CEP> cepList = <CEP>[].obs;
  final Dio dio = Dio();

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
    } catch (e) {
      print(e);
    }
  }

  

}

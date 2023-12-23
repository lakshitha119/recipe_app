import 'dart:convert';

import 'package:http/http.dart' as http;
class APIManager{

  Future<dynamic>  postRequest(url,data) async {

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );
    if(response.statusCode == 200){
      final body = response.body;
      print("response"+url);//Check Response is success
      print(jsonDecode(body));//Check Response is success

      return jsonDecode(body);
    }else{
      print("error");
      print(response.body);
      return null;
    }
  }
  Future<dynamic>  getRequest(url) async {

    final response = await http.get(
      Uri.parse(url),
    );
    if(response.statusCode == 200){
      final body = response.body;
      print("response"+url);//Check Response is success
      print(jsonDecode(body));//Check Response is success

      return jsonDecode(body);
    }else{
      print("error");
      print(response.body);
      return null;
    }
  }

}
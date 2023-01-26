import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClass{

  static Future<String> apiCall(String prompt)async {
    String url = "https://api.openai.com/v1/images/generations";
    String key = "get your key from https://beta.openai.com/ and paste it here";
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $key'
    };

    var body = {
      "prompt": prompt,
      "n": 1,
      "size": "1024x1024"
    };

    var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    var json = jsonDecode(response.body);

    if(response.statusCode == 200){
      return json['data'][0]['url'];
    }else{
      return "https://cdn.dribbble.com/users/1078347/screenshots/2799566/media/da1689a913fb87f888988230e869c896.png";
    }
  }
}

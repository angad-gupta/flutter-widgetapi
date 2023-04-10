import 'package:http/http.dart' as http;
import 'dart:convert';

// this class incloude all http request methods
class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  // this method is for http get request
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

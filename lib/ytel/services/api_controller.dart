import 'package:http/http.dart' as http;

import '../helper/constants/strings.dart';
import '../utils/storage_utils.dart';

String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

class BaseUser {
  var client = http.Client();

  Future<dynamic> get(String url) async {
    var header = {
      'authority' : 'api.ytel.com',
      'accept' : 'application/json, text/plain, */*',
      'accept-language' : 'en-US,en;q=0.9',
      'authorization' : 'Bearer $accessToken',
    };
    var response = await client.get(Uri.parse(url),headers: header);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}

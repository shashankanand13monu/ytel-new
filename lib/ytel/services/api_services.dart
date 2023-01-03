import 'package:dio/dio.dart';
import 'package:ytel/ytel/services/dio_client.dart';

class ApiServices {
  var dio = DioClient();

  // Login
  Future loginUserData(Map<String, dynamic> body) async {
    Response response = await dio.postMethod("auth/v2/token", body);
    return response;
  }

  // Privileges
  Future getAllPrivileges() async {
    Response response = await dio.getMethod("ams/v2/privileges/all");
    return response;
  }

  // Account Config
  Future getAccountConfigData(String accountId) async {
    Response response =
        await dio.getMethod("ams/v2/accounts/config/$accountId");
    return response;
  }

  // Get Contacts
  Future getContactData() async {
    Response response = await dio.getMethod("api/v4/contact");
    return response;
  }

  Future searchContactData(Map<String, dynamic> body) async {
    Response response = await dio.postMethod("api/v4/contact/search", body);
    return response;
  }

//get Asset
  Future getSettingAssetData() async {
    Response response = await dio.getMethod('api/v4/asset/');
    print(response.data);
    return response;
  }

  //

  Future editSettingAsset(Map<String, dynamic> body) async {
    Response response = await dio.postMethod("", body);
    return response;
  }

  Future logSearch() async {
    //https://api.ytel.com/api/v4/logs/sms/?limit=10000&startDate=2022-12-20&endDate=2023-01-02
    Response response = await dio.getMethod(
        'api/v4/logs/sms/?limit=10000&startDate=2022-12-20&endDate=2023-01-02');
    print(response.data);
    return response;
  }
}

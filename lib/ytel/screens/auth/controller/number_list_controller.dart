import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';

class number_list_controller extends GetxController {
  static numberData() async {
    String url = '${StringHelper.BASE_URL}api/v4/number/?offset=0';
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

    try {
      print("Inside Try");
      var result = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            'authority': 'api.ytel.com',
            'accept': 'application/json, text/plain, */*',
            'accept-language': 'en-US,en;q=0.9',
            'authorization': 'Bearer $accessToken',
          });

      if (result.statusCode == 200) {
        print("OK");
        var data = json.decode(result.body);
        print(data);
        return data;
      } else {
        print("Something went Wrong");
      }
    } catch (e) {
      print(e);
    }
  }

  static numberSetData() async {
    String url = '${StringHelper.BASE_URL}api/v4/numberset/';
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

    try {
      print("Inside Try");
      var result = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            'authority': 'api.ytel.com',
            'accept': 'application/json, text/plain, */*',
            'accept-language': 'en-US,en;q=0.9',
            'authorization': 'Bearer $accessToken',
          });

      if (result.statusCode == 200) {
        print("OK");
        var data = json.decode(result.body);
        print(data);
        return data;
      } else {
        print("Something went Wrong");
      }
    } catch (e) {
      print(e);
    }
  }

  static numberPurchase(String type, String areaCode, String size) async {
    String area_code = '';
    String type_code = '';
    if (type == 'Local') {
      area_code =
          '201,202,203,204,205,206,207,208,209,210,212,213,214,215,216,217,218,219,220,223,224,225,226,227,228,229,231,234,236,239,240,248,249,250,251,252,253,254,256,260,262,267,269,270,272,274,276,279,281,283,289,301,302,303,304,305,306,307,308,309,310,312,313,314,315,316,317,318,319,320,321,323,325,326,327,330,331,332,334,336,337,339,341,343,346,347,351,352,360,361,364,365,367,380,385,386,401,402,403,404,405,406,407,408,409,410,412,413,414,415,416,417,418,419,423,424,425,428,430,431,432,434,435,437,438,440,442,443,445,447,450,458,463,464,469,470,475,478,479,480,484,501,502,503,504,505,506,507,508,509,510,512,513,514,515,516,517,518,519,520,530,531,534,539,540,541,548,551,557,559,561,562,563,564,567,570,571,573,574,575,579,580,581,585,586,587,601,602,603,604,605,606,607,608,609,610,612,613,614,615,616,617,618,619,620,623,626,628,629,630,631,636,639,640,641,646,647,650,651,657,659,660,661,662,667,669,670,672,678,679,680,681,682,689,701,702,703,704,705,706,707,708,709,712,713,714,715,716,717,718,719,720,724,725,726,727,730,731,732,734,737,740,743,747,754,757,760,762,763,765,769,770,772,773,774,775,778,779,780,781,782,785,786,801,802,803,804,805,806,807,808,810,812,813,814,815,816,817,818,819,820,825,828,830,831,832,838,843,845,847,848,850,854,856,857,858,859,860,862,863,864,865,867,870,872,873,878,879,901,902,903,904,905,906,907,908,909,910,912,913,914,915,916,917,918,919,920,925,928,929,930,931,934,936,937,938,940,941,947,949,951,952,954,956,959,970,971,972,973,975,978,979,980,984,985,986,989';
    } else {
      area_code = '800,833,844,855,866,877,888';
    }
    if (areaCode == 'Voice only') {
      type_code = 'voice';
    }
    else
    {
      type_code = 'sms';
    }
    String url =
        '${StringHelper.BASE_URL}api/v4/number/available/?type=$type_code&areaCode=$area_code&size=$size';
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

    try {
      print("Inside Try");
      var result = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            'authority': 'api.ytel.com',
            'accept': 'application/json, text/plain, */*',
            'accept-language': 'en-US,en;q=0.9',
            'authorization': 'Bearer $accessToken',
          });

      if (result.statusCode == 200) {
        print("OK");
        var data = json.decode(result.body);
        print(data);
        return data;
      } else {
        print("Something went Wrong");
      }
    } catch (e) {
      print(e);
    }
  }
}

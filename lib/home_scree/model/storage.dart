import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taptap/home_scree/model/point_model.dart';

class PointStorage {
  Future<void> setPointModel(List<PointModel> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = jsonEncode(data.map((e) => e.toJson()).toList());
    prefs.setString('setPointModel', json);
  }

  Future<List<PointModel>> getPointModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _data = prefs.getString('setPointModel') ?? '';
    // print('getOrders setOrders=' + _data);
    if (_data != '') {
      return List<PointModel>.from(jsonDecode(_data).map((model) => PointModel.fromJson(model)));
    } else {
      return [];
    }
  }
}
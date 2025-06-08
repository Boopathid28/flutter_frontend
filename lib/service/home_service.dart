import 'package:ausales_application/core/api_endpoints/home_endpoints.dart';
import 'package:ausales_application/model/home_model.dart';
import 'package:ausales_application/service/api_calls.dart';

class HomeService {

  static Future getUserMenuPermission() async {
    var response = await ApiCalls.getWithToken(url: userMenuPermissionEndPoint);
    if (response != null) {
      final UserMenuPermissionResponse userMenuPermissionResponse = UserMenuPermissionResponse.fromJson(response['data']);

      return userMenuPermissionResponse.list;
    } 

    return <UserMenuDataList>[];
  }
}
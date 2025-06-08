import 'package:ausales_application/core/api_endpoints/itemtag_endpoints.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/itemtag/itemtag_model.dart';
import 'package:ausales_application/service/api_calls.dart';

class ItemtagService {

  static Future fetchItemTagList({
    FetchItemTagListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: itemTagListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<ItemTagListData> tempList = <ItemTagListData>[];
        for (var item in response['data']['list']) {
          tempList.add(ItemTagListData.fromJson(item));
        }
        return {
          "data": tempList,
          "total_pages": response['data']['total_pages']
        };
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }

  
}
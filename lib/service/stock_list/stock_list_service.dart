import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/stock_list_endpoints.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/stock_list/stock_list_models.dart';
import 'package:ausales_application/service/api_calls.dart';

class StockListService {

  static Future fetchStockListList({
    FetchStockListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: stockListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<StockListData> tempList = <StockListData>[];
        for (var item in response['data']['list']) {
          tempList.add(StockListData.fromJson(item));
        }
        return {
          "list": tempList,
          "data": response['data']
        };
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }
}

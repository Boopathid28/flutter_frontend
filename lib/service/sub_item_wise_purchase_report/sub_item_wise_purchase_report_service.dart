import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/sub_item_wise_purchase_report_endpoints.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/subitem_wise_purchase_report/subitem_wise_purchase_report_models.dart';
import 'package:ausales_application/service/api_calls.dart';

class SubItemWisePurchaseReportService {
  static Future fetchSubItemWisePurchaseReportList({
    FetchSubItemWisePurchaseReportListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: subitemwisepurchasereportListEndpoints, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<SubItemWisePurchaseReportListData> tempList =
            <SubItemWisePurchaseReportListData>[];
        for (var item in response['data']['list']) {
          tempList.add(SubItemWisePurchaseReportListData.fromJson(item));
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

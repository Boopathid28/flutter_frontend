import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/suspense_redeem_report_endpoints.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/suspense_redeem_report/suspense_redeem_report_models.dart';
import 'package:ausales_application/service/api_calls.dart';

class SuspenseRedeemReportService {
  static Future fetchSuspenseRedeemReportList({
    FetchSuspenseRedeemReportListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: suspenseredeemreportListEndPoint, body: payload!.toJson());
        
    if (response != null) {
      if (response['status'] == 200) {
        List<SuspenseRedeemReportListData> tempList =
            <SuspenseRedeemReportListData>[];
        for (var item in response['data']['list']) {
          tempList.add(SuspenseRedeemReportListData.fromJson(item));
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

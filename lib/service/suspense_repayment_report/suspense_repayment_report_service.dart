import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/suspense_repayment_report_endpoints.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/suspense_repayment_report/suspense_repayment_report_models.dart';
import 'package:ausales_application/service/api_calls.dart';

class SuspenseRepaymentReportService {
  static Future fetchSuspenseRepaymentReportList({
    FetchSuspenseRepaymentReportListPaylaod? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: suspenserepaymentreportListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<SuspenseRepaymentReportListData> tempList =
            <SuspenseRepaymentReportListData>[];
        for (var item in response['data']['list']) {
          tempList.add(SuspenseRepaymentReportListData.fromJson(item));
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

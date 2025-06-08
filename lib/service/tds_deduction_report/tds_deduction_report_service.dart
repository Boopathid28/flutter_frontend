import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/tds_deduction_report_endpoints.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/tds_deduction_report/tds_deduction_report_models.dart';
import 'package:ausales_application/service/api_calls.dart';

class TdsDeductionReportService {
  static Future fetchTdsDeductionReportList({
    FetchTdsDeductionReportListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: tdsdeductionreportListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<TdsDeductionReportListData> tempList =
            <TdsDeductionReportListData>[];
        for (var item in response['data']['list']) {
          tempList.add(TdsDeductionReportListData.fromJson(item));
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

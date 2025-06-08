import 'package:ausales_application/core/api_endpoints/reports/purity_wise_purchase_report_endpoints.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/reports/purity_wise_purchase_report_models.dart';
import 'package:ausales_application/service/api_calls.dart';

class PurityWisePurchaseReportService {
  static Future fetchPurityWisePurchaseReportList({
    FetchPurityWisePurchaseReportListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: puritywisepurchasereportListEndpoints, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<PurityWisePurchaseReportListData> tempList =
            <PurityWisePurchaseReportListData>[];
        for (var item in response['data']['list']) {
          tempList.add(PurityWisePurchaseReportListData.fromJson(item));
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

import 'package:ausales_application/core/api_endpoints/vendor_ledger_endpoints.dart';
import 'package:ausales_application/model/vendor_ledger/vendor_ledger_models.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';

class VendorLedgerService {

  static Future fetchVendorLedgerList({
    FetchVendorLedgerListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: vendorledgerListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<VendorLedgerListData> tempList = <VendorLedgerListData>[];
        for (var item in response['data']['list']) {
          tempList.add(VendorLedgerListData.fromJson(item));
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

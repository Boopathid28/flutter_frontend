import 'package:ausales_application/core/api_endpoints/stock_ledger_endpoints.dart';
import 'package:ausales_application/model/stock_ledger/stock_ledger_models.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';

class StockLedgerService {

  static Future fetchStockLedgerList({
    FetchStockLedgerListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: stockledgerListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<StockLedgerListData> tempList = <StockLedgerListData>[];
        for (var item in response['data']['list']) {
          tempList.add(StockLedgerListData.fromJson(item));
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

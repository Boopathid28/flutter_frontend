import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/customer_ledger_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/stock_ledger_endpoints.dart';
import 'package:ausales_application/model/customer_ledger/customer_ledger_models.dart';
import 'package:ausales_application/model/stock_ledger/stock_ledger_models.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';

class CustomerLedgerService {

  static Future fetchCustomerLedgerList({
    FetchCustomerLedgerListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: customerLedgerListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<CustomerLedgerListData> tempList = <CustomerLedgerListData>[];
        for (var item in response['data']['list']) {
          tempList.add(CustomerLedgerListData.fromJson(item));
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

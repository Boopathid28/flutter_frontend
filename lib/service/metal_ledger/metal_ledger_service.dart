import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/metal_ledger_endpoints.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/metal_ledger/metal_ledger_models.dart';
import 'package:ausales_application/service/api_calls.dart';

class MetalLedgerService {
  static Future fetchMetalLedgerList({
    FetchMetalLedgerListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: metalLedgerListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<MetalLedgerListResponse> tempList =
            <MetalLedgerListResponse>[];
        for (var item in response['data']['list']) {
          tempList.add(MetalLedgerListResponse.fromJson(item));
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

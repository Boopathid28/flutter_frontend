import 'dart:developer';

import 'package:ausales_application/model/itemtag/itemtag_model.dart';
import 'package:ausales_application/service/itemtag/itemtag_form_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemtagFormParticularsController extends GetxController {

  RxList<TagItemDetailsResponse> itemTagList = <TagItemDetailsResponse>[].obs;

  RxString remainingPieces = "".obs;
  RxString remainingGrossWeight = "".obs;
  RxString remainingTagCount = "".obs;

  RxString totalPieces = "".obs;
  RxString totalGrossWeight = "".obs;
  RxString totalTagCount = "".obs;

  Future getItemTagList(BuildContext context) async {
    final args = Get.arguments;
    var data = await ItemtagFormService.getTagEntryDetailsById(context: context, tagEntryId: args['tagEntryId'].toString());
    if (data != null) {
      itemTagList([]);

      data['tag_details'].forEach(
            (item) {
              var dictValue = item;
              itemTagList.add(TagItemDetailsResponse.fromJson(dictValue));
            });
      
      remainingPieces(data['remaining_pieces'].toString());
      remainingGrossWeight(data['remaining_gross_weight'].toString());
      remainingTagCount(data['remaining_tag_count'].toString());

      totalPieces(data['total_pieces'].toString());
      totalGrossWeight(data['total_gross_weight'].toString());
      totalTagCount(data['total_tag_count'].toString());
    }
  }
}
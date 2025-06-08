import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/lot/lot_model.dart';
import 'package:get/get.dart';

class LotItemTableController extends GetxController {

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<LotFormItemDataModel> tableData = <LotFormItemDataModel>[].obs;
}
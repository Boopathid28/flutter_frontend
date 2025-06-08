import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/dropdown_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/tag_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/api_calls.dart';

class DropdownService {
  static Future userRoleDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: userRoleListDropDownEndPoint);

    if (response != null) {
      final List<UserRoleDropdownModel> tempList = <UserRoleDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(UserRoleDropdownModel.fromJson(item));
      });

      return tempList;
    }
    return <UserRoleDropdownModel>[];
  }

  static Future metalDropDown() async {
    var response = await ApiCalls.getWithToken(url: metalListDropDownEndPoint);

    if (response != null) {
      final List<MetalDropdownModel> tempList = <MetalDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(MetalDropdownModel.fromJson(item));
      });

      return tempList;
    }
    return <MetalDropdownModel>[];
  }

  static Future purityDropDown(String? metal) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response;
    if (metal != null) {
      response = await ApiCalls.getWithToken(
          url: "$purityListDropDownEndPoint?menu_id=$menuId&metal=$metal");
    } else {
      response = await ApiCalls.getWithToken(
          url: "$purityListDropDownEndPoint?menu_id=$menuId");
    }

    if (response != null) {
      final List<PurityDropdownModel> tempList = <PurityDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(PurityDropdownModel.fromJson(item));
      });

      return tempList;
    }
    return <PurityDropdownModel>[];
  }

  static Future counterDropDown({String? branch, String? floor}) async {
    var response;

    if (branch != null) {
      response = await ApiCalls.getWithToken(
          url: "$counterDropDownEndPoint?branch=$branch");
    } else if (floor != null) {
      response = await ApiCalls.getWithToken(
          url: "$counterDropDownEndPoint?floor=$floor");
    } else {
      response = await ApiCalls.getWithToken(url: counterDropDownEndPoint);
    }

    if (response != null) {
      final List<CounterDropdownModel> tempList = <CounterDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(CounterDropdownModel.fromJson(item));
      });

      return tempList;
    }
    return <CounterDropdownModel>[];
  }

  static Future tagTypeDropDown({String? metal}) async {
    var response;

    if (metal != null) {
      response = await ApiCalls.getWithToken(
          url: "$tagMasterListEndPoint?metal=$metal");
    } else {
      response = await ApiCalls.getWithToken(url: tagMasterListEndPoint);
    }

    if (response != null) {
      final List<TagTypeDropdownModel> tempList = <TagTypeDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(TagTypeDropdownModel.fromJson(item));
      });

      return tempList;
    }
    return <TagTypeDropdownModel>[];
  }

  static Future customergroupDropDown({int? isfilter}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(
        url:
            "$customerGroupListDropDownEndPoint?menu_id=$menuId&id=2&is_filter=$isfilter");

    if (response != null) {
      final List<CustomergroupDropdownModel> tempList =
          <CustomergroupDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(CustomergroupDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <CustomergroupDropdownModel>[];
  }

  static Future customerDropDown({String? branch, int isFilter = 0}) async {
    var response;

    if (branch != null) {
      response = await ApiCalls.getWithToken(
          url:
              "$customerListDropDownEndPoint?branch=$branch&is_filter=$isFilter");
    } else {
      response = await ApiCalls.getWithToken(
          url: "$customerListDropDownEndPoint?is_filter=$isFilter");
    }

    if (response != null) {
      final List<CustomerDropDownModel> tempList = <CustomerDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(CustomerDropDownModel.fromJson(item));
      });

      return tempList;
    }
    return <CustomerDropDownModel>[];
  }

  static Future itemDropDown({String? purity, String? metal}) async {
    var response;
    if (metal != null && purity != null) {
      response = await ApiCalls.getWithToken(
          url: "$itempListDropDownEndPoint?metal=$metal&purity=$purity");
    } else if (metal != null) {
      response = await ApiCalls.getWithToken(
          url: "$itempListDropDownEndPoint?metal=$metal");
    } else if (purity != null) {
      response = await ApiCalls.getWithToken(
          url: "$itempListDropDownEndPoint?purity=$purity");
    } else {
      response = await ApiCalls.getWithToken(url: itempListDropDownEndPoint);
    }

    if (response != null) {
      final List<ItemDropdownModel> tempList = <ItemDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(ItemDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <ItemDropdownModel>[];
  }

  static Future subItemDropDown(
      {String? item, String? metal, String? purity}) async {
    var response;
    if (item != null && metal != null && purity != null) {
      response = await ApiCalls.getWithToken(
          url:
              "$subItemListDropDownEndPoint?item=$item&metal=$metal&purity=$purity");
    } else if (item != null && metal != null) {
      response = await ApiCalls.getWithToken(
          url: "$subItemListDropDownEndPoint?item=$item&metal=$metal");
    } else if (item != null && purity != null) {
      response = await ApiCalls.getWithToken(
          url: "$subItemListDropDownEndPoint?item=$item&purity=$purity");
    } else if (metal != null && purity != null) {
      response = await ApiCalls.getWithToken(
          url: "$subItemListDropDownEndPoint?metal=$metal&purity=$purity");
    } else if (item != null) {
      response = await ApiCalls.getWithToken(
          url: "$subItemListDropDownEndPoint?item=$item");
    } else if (metal != null) {
      response = await ApiCalls.getWithToken(
          url: "$subItemListDropDownEndPoint?metal=$metal");
    } else if (purity != null) {
      response = await ApiCalls.getWithToken(
          url: "$subItemListDropDownEndPoint?purity=$purity");
    } else {
      response = await ApiCalls.getWithToken(url: subItemListDropDownEndPoint);
    }

    if (response != null) {
      final List<SubItemDropdownModel> tempList = <SubItemDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(SubItemDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <SubItemDropdownModel>[];
  }

  static Future stockTypeDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: stockTypeListDropDownEndPoint);

    if (response != null) {
      final List<StockTypeDropdownModel> tempList = <StockTypeDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(StockTypeDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <StockTypeDropdownModel>[];
  }

  static Future measurementTypeDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: measurementTypeListDropDownEndPoint);

    if (response != null) {
      final List<MeasurementTypeDropdownModel> tempList =
          <MeasurementTypeDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(MeasurementTypeDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <MeasurementTypeDropdownModel>[];
  }

  static Future calculationTypeDropDown({String? stockType}) async {
    if (stockType != null) {
      var response = await ApiCalls.getWithToken(
          url: "$calculationTypeListDropDownEndPoint?stock_type=$stockType");
      if (response != null) {
        final List<CalculationTypeDropdownModel> tempList =
            <CalculationTypeDropdownModel>[];

        response['data']['list'].forEach((item) {
          tempList.add(CalculationTypeDropdownModel.fromJson(item));
        });
        return tempList;
      }
    } else {
      var response =
          await ApiCalls.getWithToken(url: calculationTypeListDropDownEndPoint);
      if (response != null) {
        final List<CalculationTypeDropdownModel> tempList =
            <CalculationTypeDropdownModel>[];

        response['data']['list'].forEach((item) {
          tempList.add(CalculationTypeDropdownModel.fromJson(item));
        });
        return tempList;
      }
    }

    return <CalculationTypeDropdownModel>[];
  }

  static Future weightTypeDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: weightTypeListDropDownEndPoint);

    if (response != null) {
      final List<WeightTypeDropdownModel> tempList =
          <WeightTypeDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(WeightTypeDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <WeightTypeDropdownModel>[];
  }

  static Future catalogDropDown({String? counter, String? catalogType}) async {
    var response;

    if (counter != null && catalogType != null) {
      response = await ApiCalls.getWithToken(
          url:
              "$catalogDropDownListEndPoint?is_filter=$isFilter&counter=$counter&catalog_type=$catalogType");
    } else if (catalogType != null) {
      response = await ApiCalls.getWithToken(
          url:
              "$catalogDropDownListEndPoint?is_filter=$isFilter&catalog_type=$catalogType");
    } else if (counter != null) {
      response = await ApiCalls.getWithToken(
          url:
              "$catalogDropDownListEndPoint?is_filter=$isFilter&counter=$counter");
    } else {
      response = await ApiCalls.getWithToken(
          url: "$catalogDropDownListEndPoint?is_filter=$isFilter");
    }

    if (response != null) {
      final List<CatalogDropdownModel> tempList = <CatalogDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(CatalogDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <CatalogDropdownModel>[];
  }

  static Future flatWastageTypeDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: flatWastageTypeListDropDownEndPoint);

    if (response != null) {
      final List<FlatWastageTypeDropdownModel> tempList =
          <FlatWastageTypeDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(FlatWastageTypeDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <FlatWastageTypeDropdownModel>[];
  }

  static Future branchDropDown({required String isFilter}) async {
    var response = await ApiCalls.getWithToken(
        url: "$branchListDropDownEndPoint?is_filter=$isFilter");

    if (response != null) {
      final List<BranchDropDownModel> tempList = <BranchDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(BranchDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <BranchDropDownModel>[];
  }

  static Future designerDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: designerListDropDownEndPoint);

    if (response != null) {
      final List<DesignerDropdownModel> tempList = <DesignerDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(DesignerDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <DesignerDropdownModel>[];
  }

  static Future marriageDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: marriageListDropDownEndPoint);

    if (response != null) {
      final List<MarriageDropdownModel> tempList = <MarriageDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(MarriageDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <MarriageDropdownModel>[];
  }

  static Future entryTypeDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: entryTypeListDropDownEndPoint);

    if (response != null) {
      final List<EntryTypeDropdownModel> tempList = <EntryTypeDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(EntryTypeDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <EntryTypeDropdownModel>[];
  }

  static Future gstTypeDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: gstTypeListDropDownEndPoint);

    if (response != null) {
      final List<GstTypeDropdownModel> tempList = <GstTypeDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(GstTypeDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <GstTypeDropdownModel>[];
  }

  static Future stoneDropDown() async {
    var response = await ApiCalls.getWithToken(url: stoneListDropDownEndPoint);

    if (response != null) {
      final List<StoneDropdownModel> tempList = <StoneDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(StoneDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <EntryTypeDropdownModel>[];
  }

  static Future diamondDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: diamondListDropDownEndPoint);

    if (response != null) {
      final List<DiamondDropdownModel> tempList = <DiamondDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(DiamondDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <EntryTypeDropdownModel>[];
  }

  static Future lotStatusDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: lotStatusListDropDownEndPoint);

    if (response != null) {
      final List<LotStatusDropdownModel> tempList = <LotStatusDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(LotStatusDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <LotStatusDropdownModel>[];
  }

  static Future lotListDropDown(String? branch) async {
    var response;
    if (branch != null) {
      response = await ApiCalls.getWithToken(
          url: "$lotListDropDownEndPoint?branch=$branch");
    } else {
      response = await ApiCalls.getWithToken(url: lotListDropDownEndPoint);
    }

    if (response != null) {
      final List<LotListDropdownModel> tempList = <LotListDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(LotListDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <LotListDropdownModel>[];
  }

  static Future lotItemListDropDownByLot(String? lotNo) async {
    var response = await ApiCalls.getWithToken(
        url: "$lotItemListDropDownEndPoint?lot_number=$lotNo");
    if (response != null) {
      final List<LotItemListDropDownModel> tempList =
          <LotItemListDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(LotItemListDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <LotItemListDropDownModel>[];
  }

  static Future floorDropdown({String? branch}) async {
    var response;
    if (branch != null) {
      response = await ApiCalls.getWithToken(
          url: "$floorListDropDownEndPoint?branch=$branch&is_filter=$isFilter");
    } else {
      response = await ApiCalls.getWithToken(
          url: "$floorListDropDownEndPoint?is_filter=$isFilter");
    }

    if (response != null) {
      final List<FloorDropdownModel> tempList = <FloorDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(FloorDropdownModel.fromJson(item));
      });
      return tempList;
    }
    return <FloorDropdownModel>[];
  }

  static Future oldMetalDropDown() async {
    var response = await ApiCalls.getWithToken(url: oldMetalDropDownEndPoint);

    if (response != null) {
      final List<OldMetalDropdownModel> tempList = <OldMetalDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(OldMetalDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <OldMetalDropdownModel>[];
  }

  static Future transactionTypeDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: transactiontypeDropDownListEndPoint);

    if (response != null) {
      final List<TransactionTypeDropdownModel> tempList =
          <TransactionTypeDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(TransactionTypeDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <TransactionTypeDropdownModel>[];
  }

  static Future TagNumberDropDown(String? branch) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response;

    if (branch != null) {
      response = await ApiCalls.getWithToken(
          url: "$tagDropDownListEndPoint?menu_id=$menuId&branch=$branch");
    } else {
      response = await ApiCalls.getWithToken(
          url: "$tagDropDownListEndPoint?menu_id=$menuId");
    }

    if (response != null) {
      final List<TagNumberDropdownModel> tempList = <TagNumberDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(TagNumberDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <TagNumberDropdownModel>[];
  }

  static Future stockTypeLedgerDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: stocktypeledgerDropDownListEndPoint);

    if (response != null) {
      final List<StockTypeLedgerDropdownModel> tempList =
          <StockTypeLedgerDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(StockTypeLedgerDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <StockTypeLedgerDropdownModel>[];
  }

  static Future paymentMethodDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: paymentMethodDropDownListEndPoint);

    if (response != null) {
      final List<PaymentMethodDropDown> tempList = <PaymentMethodDropDown>[];

      response['data']['list'].forEach((item) {
        tempList.add(PaymentMethodDropDown.fromJson(item));
      });
      return tempList;
    }

    return <PaymentMethodDropDown>[];
  }

  static Future paymentProviderDropDown({required String paymentMethod}) async {
    var response = await ApiCalls.getWithToken(
        url:
            "$paymentProviderDropDownListEndPoint?payment_method=$paymentMethod");

    if (response != null) {
      final List<PaymentProviderDropDown> tempList =
          <PaymentProviderDropDown>[];

      response['data']['list'].forEach((item) {
        tempList.add(PaymentProviderDropDown.fromJson(item));
      });
      return tempList;
    }

    return <PaymentProviderDropDown>[];
  }

  static Future bagDropDown({String? branchId}) async {
    var response;
    if (branchId != null) {
      response = await ApiCalls.getWithToken(
          url: "$bagDropDownListEndPoint?branch=$branchId");
    } else {
      response = await ApiCalls.getWithToken(url: bagDropDownListEndPoint);
    }

    if (response != null) {
      final List<BagDropDownModel> tempList = <BagDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(BagDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <BagDropDownModel>[];
  }

  static Future expenseDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: expenseDropDownListEndPoint);

    if (response != null) {
      final List<ExpenseDropDown> tempList = <ExpenseDropDown>[];

      response['data']['list'].forEach((item) {
        tempList.add(ExpenseDropDown.fromJson(item));
      });
      return tempList;
    }

    return <ExpenseDropDown>[];
  }

  static Future advancePurposeDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: advancePurposeDropDownListEndPoint);

    if (response != null) {
      final List<AdvancePurposeDropdownmodel> tempList =
          <AdvancePurposeDropdownmodel>[];

      response['data']['list'].forEach((item) {
        tempList.add(AdvancePurposeDropdownmodel.fromJson(item));
      });
      return tempList;
    }

    return <AdvancePurposeDropdownmodel>[];
  }

  static Future expenseclassificationDropDown() async {
    var response = await ApiCalls.getWithToken(
        url: expenseclassificationDropDownListEndPoint);

    if (response != null) {
      final List<ExpenseclassificationDropDownModel> tempList =
          <ExpenseclassificationDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(ExpenseclassificationDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <ExpenseclassificationDropDownModel>[];
  }

  static Future subExpenseDropDown() async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(
        url: "$subexpenseDropDownListEndPoint?menu_id=$menuId");

    if (response != null) {
      final List<SubExpenseDropDownModel> tempList =
          <SubExpenseDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(SubExpenseDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <SubExpenseDropDownModel>[];
  }

  static Future expensetypeDropDownModel() async {
    var response =
        await ApiCalls.getWithToken(url: expensetypeDropDownListEndPoint);

    if (response != null) {
      final List<ExpensetypeDropDownModel> tempList =
          <ExpensetypeDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(ExpensetypeDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <ExpensetypeDropDownModel>[];
  }

  static Future salesexpensetypeDropDownModel() async {
    var response =
        await ApiCalls.getWithToken(url: salesentrytypeDropDownListEndPoint);

    if (response != null) {
      final List<SalesExpensetypeDropDownModel> tempList =
          <SalesExpensetypeDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(SalesExpensetypeDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <SalesExpensetypeDropDownModel>[];
  }

  static Future catalogTypeDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: catalogTypeDropDownEndPoint);

    if (response != null) {
      final List<CatalogTypeDropdownModel> tempList =
          <CatalogTypeDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(CatalogTypeDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <CatalogTypeDropdownModel>[];
  }

  static Future priorityDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: priorityDropDownListEndPoint);

    if (response != null) {
      final List<PriorityDropDown> tempList = <PriorityDropDown>[];

      response['data']['list'].forEach((item) {
        tempList.add(PriorityDropDown.fromJson(item));
      });
      return tempList;
    }

    return <PriorityDropDown>[];
  }

  static Future genderDropDown() async {
    var response = await ApiCalls.getWithToken(url: genderDropDownListEndPoint);

    if (response != null) {
      final List<GenderDropDownModel> tempList = <GenderDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(GenderDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <GenderDropDownModel>[];
  }

  static Future oldMetalTouchDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: oldMetalTouchDropDownListEndPoint);

    if (response != null) {
      final List<OldMetalTouchDropDownModel> tempList =
          <OldMetalTouchDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(OldMetalTouchDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <OldMetalTouchDropDownModel>[];
  }

  static Future touchDropDown() async {
    var response = await ApiCalls.getWithToken(url: touchDropDownListEndPoint);

    if (response != null) {
      final List<TouchDropdownModel> tempList = <TouchDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(TouchDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <TouchDropdownModel>[];
  }

  static Future oldLedgerEntryTypeDropDown() async {
    var response = await ApiCalls.getWithToken(
        url: oldledgerentrytypeDropDownListEndPoint);

    if (response != null) {
      final List<oldledgerentrytypeDropDownModel> tempList =
          <oldledgerentrytypeDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(oldledgerentrytypeDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <oldledgerentrytypeDropDownModel>[];
  }

  static Future repairTypeDropDown(String menuId) async {
    var response = await ApiCalls.getWithToken(
        url: '$repairTypeDropDownListEndpoint?menu_id=$menuId');

    if (response != null) {
      final List<RepairTypeDropDown> tempList = <RepairTypeDropDown>[];

      response['data']['list'].forEach((item) {
        tempList.add(RepairTypeDropDown.fromJson(item));
      });
      return tempList;
    }

    return <RepairTypeDropDown>[];
  }

  static Future meltingDropDown(String? branch, String? metal) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response;

    if (metal != null && branch != null) {
      response = await ApiCalls.getWithToken(
        url: '$meltingDropDownListEndpoint?menu_id=$menuId&metal=$metal&branch=$branch');
    } else if (metal != null) {
      response = await ApiCalls.getWithToken(
        url: '$meltingDropDownListEndpoint?menu_id=$menuId&metal=$metal');
    } else if (branch != null) {
      response = await ApiCalls.getWithToken(
        url: '$meltingDropDownListEndpoint?menu_id=$menuId&branch=$branch');
    } else {
      response = await ApiCalls.getWithToken(
        url: '$meltingDropDownListEndpoint?menu_id=$menuId');
    }

    if (response != null) {
      final List<MeltingDropDownModel> tempList = <MeltingDropDownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(MeltingDropDownModel.fromJson(item));
      });
      return tempList;
    }

    return <MeltingDropDownModel>[];
  }

  static Future catalogverificationTypeDropDown() async {
    var response =
        await ApiCalls.getWithToken(url: catalogverficationTypeDropDownListEndpoint);
 
    if (response != null) {
      final List<CatalogVerificationTypeDropdown> tempList = <CatalogVerificationTypeDropdown>[];
 
      response['data']['list'].forEach((item) {
        tempList.add(CatalogVerificationTypeDropdown.fromJson(item));
      });
      return tempList;
    }
 
    return <CatalogVerificationTypeDropdown>[];
  }



  static Future billmetalDropDown() async {
    var response = await ApiCalls.getWithToken(url: billmetalListDropDownEndPoint);

    if (response != null) {
      final List<BillMetalDropdownModel> tempList = <BillMetalDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(BillMetalDropdownModel.fromJson(item));
      });

      return tempList;
    }
    return <BillMetalDropdownModel>[];
  }


  
  static Future NewTagNumberDropDown(String? branch) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response;

    if (branch != null) {
      response = await ApiCalls.getWithToken(
          url: "$newtagDropDownListEndPoint?menu_id=$menuId&branch=$branch");
    } else {
      response = await ApiCalls.getWithToken(
          url: "$newtagDropDownListEndPoint?menu_id=$menuId");
    }

    if (response != null) {
      final List<TagNumberDropdownModel> tempList = <TagNumberDropdownModel>[];

      response['data']['list'].forEach((item) {
        tempList.add(TagNumberDropdownModel.fromJson(item));
      });
      return tempList;
    }

    return <TagNumberDropdownModel>[];
  }
}

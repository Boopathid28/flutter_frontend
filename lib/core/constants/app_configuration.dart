import 'package:flutter_screenutil/flutter_screenutil.dart';

const baseUrl = "http://192.168.1.82:8004";
const baseMediaUrl = "http://192.168.1.82:8004/media";

final desktopAppbarHeight = 84.w; 
final defaultAppbarHeight = 45.w;
final defaultBottombarHeight = 40.w;

const availableRowsPerPage = [10, 25, 50];
final int initialRowsPerPage = availableRowsPerPage[0];
const tableBodyHeightPercent = 0.75;

final isFilter = 1;
final noFilter = 0;

const notificationDuration = Duration(seconds: 4);

const String fixedRateCalcType = 'fixed_rate';
const String weightCalcType = 'weight_calculation';
const String perGramRateCalcType = 'per_gram_rate';
const String perPieceRateCalcType = 'per_piece_rate';

const String tagStockType = 'tag';
const String weightStockType = 'weight_stock';
const String pieceStockType = 'piece_stock';

const String pendingLotStatus = 'pending';

const String interGstType = 'inter';
const String intraGstType = 'intra';

const String grossWeightType = "gross_weight";
const String netWeightType = "net_weight";

const String flatWastageRupeeType = "rupees";
const String flatWastageGramType = "gram";

const List<String> amountSchemes = ["0", "1", "4"];
const List<String> weightSchemes = ["2", "3", "5", "6"];
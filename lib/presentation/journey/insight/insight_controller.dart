import 'package:get/get.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/util/app_util.dart';

class InsightController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> insightList = <Map<String, dynamic>>[].obs;

  void _loadData() async {
    final insights = await parseJsonFromAsset(AppConstant.insightAsset) as List<dynamic>;
    insightList.value = insights.map((e) => e as Map<String, dynamic>).toList();
  }

  @override
  void onInit() {
    _loadData();
    isLoading.value = false;
    super.onInit();
  }
}
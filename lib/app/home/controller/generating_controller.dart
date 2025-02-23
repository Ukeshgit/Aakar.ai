import 'package:get/get.dart';

class GeneratingController extends GetxController {
  Rx isLoading = false.obs;
  void generate() {
    isLoading.value = true;
  }
}

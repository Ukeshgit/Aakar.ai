import 'package:get/get.dart';

class LoadingIndicator extends GetxController {
  var isLoading = false.obs;
  void showLoading() {
    isLoading.value = true;
  }
}

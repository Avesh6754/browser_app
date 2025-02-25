import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

var getController = Get.put(WebGetController());

class WebGetController extends GetxController {
  var txtSearch = TextEditingController();
  InAppWebViewController? webViewController;
  RxString selectedSearchEngine = "https://www.google.com/search?q=".obs;

  List imageList = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
    'https://w7.pngwing.com/pngs/423/261/png-transparent-bing-hd-logo-thumbnail.png',
    'https://w7.pngwing.com/pngs/674/470/png-transparent-yandex-logo-y-search-engines-thumbnail.png',
  ];

  RxList linkList = [
    "https://www.google.com/search?q=",
    "https://www.bing.com/search?q=",
    "https://yandex.com/search/?text=",
  ].obs;

  void getWebsiteLink(int index) {
    selectedSearchEngine.value = linkList[index];
    update(); // Ensures UI is updated
  }
}
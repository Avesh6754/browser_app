import 'package:flutter/material.dart';
import 'package:flutter_adv_ch4/modal/modalClass.dart';
import 'package:flutter_adv_ch4/sevice/dbhelper.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';


class WebGetController extends GetxController {
  RxString selectedSearchEngine = "https://www.google.com/search?q=".obs;
  RxString selectedSearchEngineName = "Google".obs;

  RxList<ModalClass> historyList=<ModalClass>[].obs;

  List<String> linkList = [
    "https://www.google.com/search?q=",
    "https://www.bing.com/search?q=",
    "https://search.yahoo.com/search?p=",
  ];

  List<String> searchEngineNames = ["Google", "Bing", "Yahoo"];

  List<String> imageList = [
    "Google",
    "Bing",
    "yahoo",
  ];

  TextEditingController txtSearch = TextEditingController();
  InAppWebViewController? webViewController;

  RxInt history = 0.obs;
  RxList<String> bookmarks = <String>[].obs;

  void getWebsiteLink(int index) {
    selectedSearchEngine.value = linkList[index];
    selectedSearchEngineName.value = searchEngineNames[index];
    update();
    loadWebPage();
  }

  void loadWebPage() {
    if (webViewController != null) {
      String url = "${selectedSearchEngine.value}${txtSearch.text}";
      webViewController!.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
    }
  }

  Future<void> insertIntoDatabase(String name,String url)
  async {
    ModalClass items=ModalClass(name: name, url: url);
    await Dbhelper.dbhelper.insertBookMark(items);
  }

  Future<List<ModalClass>> fetchHistory()
  async {
    final data=await Dbhelper.dbhelper.fetchDataHistory();
    historyList.value=data.map((e) => ModalClass.fromMap(e),).toList();
    return historyList;

  }

  void changeHistory(var value)
  {
    history.value=value;
  }
}

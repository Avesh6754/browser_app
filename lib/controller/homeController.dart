import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebGetController extends GetxController {
  RxString selectedSearchEngine = "https://www.google.com/search?q=".obs;
  RxString selectedSearchEngineName = "Google".obs;

  List<String> linkList = [
    "https://www.google.com/search?q=",
    "https://www.bing.com/search?q=",
    "https://search.yahoo.com/search?p=",
  ];

  List<String> searchEngineNames = ["Google", "Bing", "Yahoo"];

  List<String> imageList = [
    "https://upload.wikimedia.org/wikipedia/commons/4/4a/Google_2015_logo.svg",
    "https://upload.wikimedia.org/wikipedia/commons/9/9c/Bing_logo_%282016%29.svg",
    "https://upload.wikimedia.org/wikipedia/commons/2/24/Yahoo%21_logo.svg",
  ];

  TextEditingController txtSearch = TextEditingController();
  InAppWebViewController? webViewController;

  RxList<String> history = <String>[].obs;
  RxList<String> bookmarks = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
    loadBookmarks();
  }

  // Load browsing history
  Future<void> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    history.value = prefs.getStringList("history") ?? [];
  }

  // Save browsing history
  Future<void> saveHistory(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!history.contains(url)) {
      history.add(url);
      await prefs.setStringList("history", history);
    }
  }

  // Clear history
  Future<void> clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    history.clear();
    await prefs.remove("history");
  }

  // Load bookmarks
  Future<void> loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bookmarks.value = prefs.getStringList("bookmarks") ?? [];
  }

  // Add bookmark
  Future<void> addBookmark(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!bookmarks.contains(url)) {
      bookmarks.add(url);
      await prefs.setStringList("bookmarks", bookmarks);
    }
  }

  // Remove bookmark
  Future<void> removeBookmark(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bookmarks.remove(url);
    await prefs.setStringList("bookmarks", bookmarks);
  }

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
      saveHistory(url);
    }
  }
}

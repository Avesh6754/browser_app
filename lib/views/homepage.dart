import 'package:flutter/material.dart';
import 'package:flutter_adv_ch4/views/history_page.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../controller/homeController.dart';
final WebGetController getController = Get.put(WebGetController());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(getController.selectedSearchEngineName.value)),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Card(
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(

                    controller: getController.txtSearch,
                    decoration: InputDecoration(

                      prefixIcon:  IconButton(onPressed: () {
                        getController.loadWebPage();
                      }, icon: Icon(Icons.search)),
                      hintText: "Search or enter URL",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          getController.webViewController!.reload();
                        },
                        icon: const Icon(Icons.refresh),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          PopupMenuButton<int>(
            onSelected: (index) {
              getController.getWebsiteLink(index);
            },
            itemBuilder: (context) => List.generate(
              getController.linkList.length,
                  (index) => PopupMenuItem(
                value: index,
                child: Row(
                  children: [
                    Image.network(getController.imageList[index], width: 24, height: 24),
                    const SizedBox(width: 10),
                    Text(getController.searchEngineNames[index]),
                  ],
                ),
              ),
            ),
            icon: const Icon(Icons.more_vert),
          ),

          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage(),));
          }, icon: Icon(Icons.history)),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => showBookmarks(context),
          ),
        ],
      ),
      body: Obx(
            () => InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri("${getController.selectedSearchEngine.value}${getController.txtSearch.text}"),
          ),
          onWebViewCreated: (controller) {
            getController.webViewController = controller;
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Back',
            icon: IconButton(
              onPressed: () => getController.webViewController!.goBack(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Forward',
            icon: IconButton(
              onPressed: () => getController.webViewController!.goForward(),
              icon: const Icon(Icons.arrow_forward_outlined),
            ),
          ),

          BottomNavigationBarItem(
            label: 'Home',
            icon: IconButton(
              onPressed: () => getController.loadWebPage(),
              icon: const Icon(Icons.home),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         await getController.addBookmark(getController.txtSearch.text);
        },
        child: const Icon(Icons.bookmark_add),
      ),

    );
  }
}

void showBookmarks(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Obx(
            () => ListView.builder(
          itemCount: getController.bookmarks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(getController.bookmarks[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => getController.removeBookmark(getController.bookmarks[index]),
              ),
              onTap: () {
                getController.txtSearch.text = getController.bookmarks[index];
                getController.loadWebPage();
                Navigator.pop(context);
              },
            );
          },
        ),
      );
    },
  );
}

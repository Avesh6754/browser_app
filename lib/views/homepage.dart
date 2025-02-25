import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../controller/homeController.dart';



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
          actions: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Card(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        getController.webViewController!.loadUrl(
                          urlRequest: URLRequest(
                            url: WebUri(
                            "${getController.selectedSearchEngine}${getController.txtSearch.text}",
                          ),
                        ));
                      },
                      controller: getController.txtSearch,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search or enter URL",
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            getController.webViewController!.reload();
                          },
                          icon: Icon(Icons.history_outlined),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: GetBuilder<WebGetController>(builder: (controller) {
          return
          InAppWebView(

            initialUrlRequest: URLRequest(
              url: WebUri(
                "${controller.selectedSearchEngine}${controller.txtSearch.text}",
              ),
            ),
            onWebViewCreated: (controller) {
              getController.webViewController = controller;
            },
          );
        },),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              label: 'Back',
              icon: IconButton(
                  onPressed: () {
                    getController.webViewController!.goBack();
                  },
                  icon: const Icon(Icons.arrow_back))),
          BottomNavigationBarItem(
              label: 'Forward',
              icon: IconButton(
                  onPressed: () {
                    getController.webViewController!.goForward();
                  },
                  icon: const Icon(Icons.arrow_forward_outlined))),
          BottomNavigationBarItem(
              label: 'Menu',
              icon: IconButton(
                  onPressed: () {
                    showModalBottomSheet(

                      context: context,
                      builder: (context) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           ...List.generate(getController.imageList.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  getController.getWebsiteLink(index);
                                  getController.webViewController!.loadUrl(
                                      urlRequest: URLRequest(
                                        url: WebUri(
                                          "${getController.selectedSearchEngine}",
                                        ),
                                      ));
                                 Navigator.pop(context);
                                },
                                child: webMethod(image: getController.imageList[index]),
                              );
                            }),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.menu)))
        ]));
  }

  Container webMethod({required String image,var index}) {
    return Container(
      height: 50,
      width: 50,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(image),
        ),
      ),
      child: const SizedBox(
        height: 60,
        width: 60,
      ),
    );
  }
}

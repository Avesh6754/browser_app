import 'package:flutter/material.dart';
import 'package:flutter_adv_ch4/views/homepage.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'historypage.dart';

class History extends StatelessWidget {
  const History({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(
              "${getController.historyList[getController.history.value].url}",
            ),
          ),
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage(),));
              },
              icon: const Icon(Icons.home),
            ),
          ),
        ],
      ),
    );
  }
}

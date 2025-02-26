import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homepage.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: getController.history.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(getController.history[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => getController.clearHistory(),
              ),
              onTap: () {
                getController.txtSearch.text = getController.history[index];
                getController.loadWebPage();
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}

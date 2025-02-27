import 'package:flutter/material.dart';
import 'package:flutter_adv_ch4/modal/modalClass.dart';
import 'package:flutter_adv_ch4/views/history.dart';
import 'package:flutter_adv_ch4/views/homepage.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: getController.fetchHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List<ModalClass> historyData = snapshot.data!;
          return ListView.builder(
            itemCount: historyData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    getController.changeHistory(index);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => History(),
                        ));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(historyData[index].name),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}

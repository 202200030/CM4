import 'package:flutter/material.dart';
import '../history_item.dart'; // Import HistoryItem class

class HistoryScreen extends StatefulWidget {
  final List<HistoryItem>? initialHistoryItems;

  HistoryScreen({Key? key, this.initialHistoryItems}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryItem> historyItems = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialHistoryItems != null) {
      historyItems.addAll(widget.initialHistoryItems!);
    }
  }

  void addHistoryItem(HistoryItem historyItem) {
    setState(() {
      historyItems.add(historyItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: historyItems.isEmpty
          ? Center(
              child: Text('No history items'),
            )
          : ListView.builder(
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(historyItems[index].title),
                  subtitle: Text('${historyItems[index].distance.toStringAsFixed(2)} meters'),
                  trailing: Text('${historyItems[index].elapsedTime.inSeconds} seconds'),
                );
              },
            ),
    );
  }
}

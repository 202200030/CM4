import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryItem> historyItems = [
    HistoryItem(
      type: 'walk',
      title: 'Walk',
      subtitle: 'Details of Walking',
      date: DateTime(2024, 6, 20, 10, 30),
    ),
    HistoryItem(
      type: 'run',
      title: 'Run',
      subtitle: 'Details of Running',
      date: DateTime(2024, 6, 20, 14, 15),
    ),
    HistoryItem(
      type: 'cycling',
      title: 'Cycling',
      subtitle: 'Details of Cycling',
      date: DateTime(2024, 6, 21, 9, 0),
    ),
    HistoryItem(
      type: 'gym',
      title: 'Gym',
      subtitle: 'Details of Gym Workout',
      date: DateTime(2024, 6, 21, 16, 45),
    ),
    HistoryItem(
      type: 'football',
      title: 'Football',
      subtitle: 'Details of Football Match',
      date: DateTime(2024, 6, 22, 11, 30),
    ),
    HistoryItem(
      type: 'basketball',
      title: 'Basketball',
      subtitle: 'Details of Basketball Game',
      date: DateTime(2024, 6, 22, 14, 0),
    ),
    HistoryItem(
      type: 'free_training',
      title: 'Free Training',
      subtitle: 'Details of Free Training',
      date: DateTime(2024, 6, 22, 18, 0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    historyItems.sort((a, b) => b.date.compareTo(a.date)); 

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleRow(),
            SizedBox(height: 20),
            _buildCenteredText('Your History:'),
            SizedBox(height: 20),
            _buildHistoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/paths.png', width: 50),
        SizedBox(width: 10),
        Text(
          'History',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildCenteredText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

 Widget _buildHistoryList() {
  historyItems.sort((a, b) => b.date.compareTo(a.date));

  DateTime? currentDate;

  if (historyItems.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your history is empty!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red[500],
            ),
          ),
        ],
      ),
    );
  }

  return Expanded(
    child: ListView.builder(
      itemCount: historyItems.length,
      itemBuilder: (context, index) {
        HistoryItem item = historyItems[index];
        AssetImage iconAsset = _getIconForType(item.type);
        bool showDateSeparator = currentDate == null || !_isSameDay(currentDate!, item.date);
        currentDate = item.date;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showDateSeparator) _buildDateSeparator(item.date),
            _buildHistoryListItem(item, iconAsset, index),
          ],
        );
      },
    ),
  );
}



  Widget _buildDateSeparator(DateTime date) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: Colors.grey[300],
      child: Text(
        _formatDate(date),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildHistoryListItem(HistoryItem item, AssetImage iconAsset, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: iconAsset,
        backgroundColor: Colors.teal,
      ),
      title: Text(item.title),
      subtitle: Text(item.subtitle),
      trailing: _buildPopupMenu(item, index),
    );
  }

  Widget _buildPopupMenu(HistoryItem item, int index) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'delete',
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete'),
            ),
          ),
        ];
      },
      onSelected: (String value) {
        if (value == 'delete') {
          _removeHistoryItem(index);
        }
      },
    );
  }

  void _removeHistoryItem(int index) {
    setState(() {
      historyItems.removeAt(index);
    });
  }

  AssetImage _getIconForType(String type) {
    switch (type) {
      case 'walk':
        return AssetImage('assets/Workouts_Assests/caminhada.png');
      case 'run':
        return AssetImage('assets/Workouts_Assests/corrida.png');
      case 'cycling':
        return AssetImage('assets/Workouts_Assests/cycling.png');
      case 'gym':
        return AssetImage('assets/Workouts_Assests/gym.png');
      case 'football':
        return AssetImage('assets/Workouts_Assests/desportos.png');
      case 'basketball':
        return AssetImage('assets/Workouts_Assests/Basketball.png');
      case 'free_training':
        return AssetImage('assets/Workouts_Assests/free_training.png');
      default:
        return AssetImage('assets/Workouts_Assests/free_training.png');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}

class HistoryItem {
  final String type;
  final String title;
  final String subtitle;
  final DateTime date;

  HistoryItem({required this.type, required this.title, required this.subtitle, required this.date});
}

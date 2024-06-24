  // history_item.dart

  class HistoryItem {
    final String type;
    final String title;
    final String subtitle;
    final DateTime date;
    final Duration elapsedTime; // New field for elapsed time
     double distance;

    HistoryItem({
      required this.type,
      required this.title,
      required this.subtitle,
      required this.date,
      required this.elapsedTime, // Added required parameter
      required this.distance,
    });
  }

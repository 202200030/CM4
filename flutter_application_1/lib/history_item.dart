  // history_item.dart

  class HistoryItem {
    final String type;
    final String title;
    final String subtitle;
    final DateTime date;
    final Duration elapsedTime; 
     double distance;

    HistoryItem({
      required this.type,
      required this.title,
      required this.subtitle,
      required this.date,
      required this.elapsedTime, 
      required this.distance,
    });
  }

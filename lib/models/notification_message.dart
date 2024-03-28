class NotificationMessage {
  String? imagePath;
  String pseudo;
  String message;
  String date;
  int nbNotifs;

  NotificationMessage({
    this.imagePath,
    required this.pseudo,
    required this.message,
    required this.date,
    required this.nbNotifs,
  });
}
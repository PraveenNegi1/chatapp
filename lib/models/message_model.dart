class Message {
  final String text;
  final String sender;
  final DateTime time;

  Message({
    required this.text,
    required this.sender,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        "text": text,
        "sender": sender,
        "time": time,
      };
}
class ChatMessage {
  final String text;
  final String time;
  final bool isMe;
  final bool isFile;
  final String? filename;
  final String? filesize;

  ChatMessage({
    this.text = '',
    required this.time,
    required this.isMe,
    this.isFile = false,
    this.filename,
    this.filesize,
  });
}

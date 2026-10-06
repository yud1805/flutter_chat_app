class ChatMessage {
  final String id;
  final String text;
  final String sender; // 'user' hoặc 'ai'

  ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
  });

  // Chuyển đổi từ JSON sang Object an toàn
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      sender: json['sender']?.toString() ?? 'user',
    );
  }

  // Chuyển đổi từ Object sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'sender': sender,
    };
  }
}

class MessageModel {
  String? id;
  String? chatId;
  String? senderId;
  String? message;
  DateTime? timestamp;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MessageModel({
    this.id,
    this.chatId,
    this.senderId,
    this.message,
    this.timestamp,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['_id'] as String?,
        chatId: json['chatId'] as String?,
        senderId: json['senderId'] as String?,
        message: json['message'] as String?,
        timestamp: json['timestamp'] == null
            ? null
            : DateTime.parse(json['timestamp'] as String),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'chatId': chatId,
        'senderId': senderId,
        'message': message,
        'timestamp': timestamp?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}

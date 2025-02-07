class ChatModel {
  String? id;
  List? users;
  String? lastMessage;
  DateTime? lastUpdated;
  int? v;

  ChatModel({this.id, this.users, this.lastMessage, this.lastUpdated, this.v});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json['_id'] as String?,
        users: json['users'] ,
        lastMessage: json['lastMessage'] as String?,
        lastUpdated: json['lastUpdated'] == null
            ? null
            : DateTime.parse(json['lastUpdated'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'users': users,
        'lastMessage': lastMessage,
        'lastUpdated': lastUpdated?.toIso8601String(),
        '__v': v,
      };
}

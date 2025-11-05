class Message {
  final String id;
  final String name;
  final String content;
  final bool isTeamBride;
  final DateTime createdAt;

  const Message({
    required this.id,
    this.name = 'unknown',
    required this.content,
    this.isTeamBride = true,
    required this.createdAt,
  });

  /// Tạo Message mới từ Map (ví dụ lấy từ Supabase)
  factory Message.fromMap(Map<String, dynamic> data, String id) {
    return Message(
      id: id,
      name: data['name'] ?? '',
      content: data['content'] ?? '',
      isTeamBride: data['isTeamBride'] == true || data['isTeamBride'] == 1,
      createdAt: DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// Chuyển sang Map (để lưu lên Supabase hoặc local DB)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'content': content,
      'isTeamBride': isTeamBride,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Sao chép và thay đổi một vài thuộc tính
  Message copyWith({
    String? id,
    String? name,
    String? content,
    bool? isTeamBride,
    DateTime? createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      isTeamBride: isTeamBride ?? this.isTeamBride,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() =>
      'Message(id: $id, name: $name, content: $content, isTeamBride: $isTeamBride)';
}

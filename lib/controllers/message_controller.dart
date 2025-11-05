import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wedding_web/models/message.dart';

class MessageController extends ChangeNotifier {
  // --- 1. Text controllers để giữ input ---
  final TextEditingController nameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // --- 2. Dữ liệu lựa chọn team ---
  bool isTeamBride = true; // mặc định team cô dâu

  void toggleTeam(bool value) {
    isTeamBride = value;
    notifyListeners();
  }

  // --- 3. Danh sách lời chúc ---
  final List<Message> _messages = [];
  List<Message> get messages => List.unmodifiable(_messages);

  // --- 4. Trạng thái gửi ---
  bool _isSending = false;
  bool get isSending => _isSending;

  // --- 5. Gửi message lên Supabase ---
  Future<void> sendMessage() async {

    final content = messageController.text.trim();

    if (content.isEmpty) return;

    _isSending = true;
    notifyListeners();

    try {
      final message = Message(
        id: '',
        name: 'unknown',
        content: content,
        isTeamBride: isTeamBride,
        createdAt: DateTime.now(),
      );

      // Insert vào bảng messages trên Supabase
      final response = await Supabase.instance.client
          .from('messages')
          .insert(message.toMap())
          .select()
          .single();

      final saved = Message.fromMap(response, response['id'].toString());
      _messages.insert(0, saved); // thêm vào đầu danh sách

      // ✅ Không xóa name để giữ lại người nhập, chỉ clear lời chúc
      messageController.clear();

    } catch (e) {
      debugPrint('❌ Lỗi gửi message lên Supabase: $e');
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }

  // --- 6. Lấy danh sách lời chúc từ Supabase ---
  Future<void> fetchMessages() async {
  try {
    final response = await Supabase.instance.client
        .from('messages')
        .select()
        .order('createdAt', ascending: false);

    // Xoá danh sách cũ và thêm dữ liệu mới
    _messages
      ..clear()
      ..addAll(response.map<Message>((data) {
        return Message.fromMap(data, data['id'].toString());
      }));

    // In ra console từng message
    ///print('--- Danh sách lời chúc ---');
    
    //print('--- Tổng cộng: ${_messages.length} lời chúc ---');

    notifyListeners();
  } catch (e) {
    debugPrint('❌ Lỗi load messages: $e');
  }
}


  // --- 7. Giữ input khi hot reload / đổi layout ---
  // (chỉ cần không dispose controller là giữ được)
  @override
  void dispose() {
    // ⚠️ Nếu muốn giữ dữ liệu khi đổi layout, KHÔNG dispose controller ở đây.
    // nameController.dispose();
    // messageController.dispose();
    super.dispose();
  }
}

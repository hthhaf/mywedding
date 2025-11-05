// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../models/frame.dart';
// import 'message_controller.dart';

// class FrameController {
//   final SupabaseClient supabase = Supabase.instance.client;

//   /// Controller message
//   final MessageController messageController = MessageController();

//   Future<List<FrameModel>> fetchImagesFromDatabase() async {
//     try {
//       // Fetch ảnh
//       final List<dynamic> response = await supabase.from('photos').select('id, url, name');

    
//       // Map response sang FrameModel
//       final List<FrameModel> data = response.map<FrameModel>((row) {
//         return FrameModel.fromJson(Map<String, dynamic>.from(row));
//       }).toList();

//       // In ra console
//       print('--- Danh sách ảnh ---');
//       for (var img in data) {
//         print(img); // sử dụng toString() của FrameModel
//       }
//       print('✅ Tải ${data.length} ảnh thành công');

//       return data;
//     } catch (e) {
//       print('❌ Lỗi khi tải ảnh từ DB: $e');
//       rethrow;
//     }
//   }
// }

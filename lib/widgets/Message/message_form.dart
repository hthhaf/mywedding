// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wedding_web/controllers/message_controller.dart';
import 'package:wedding_web/widgets/title.dart';

class MessageForm extends StatefulWidget {
  const MessageForm({super.key});

  @override
  State<MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  bool showThankYou = false; // ✅ Biến cục bộ để hiển thị thông báo cảm ơn

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MessageController>();

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 211, 251, 222),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const TitleText(text: 'Gửi đôi lời thương đến tụi mình nhé!'),
          Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.05,
          0,
          MediaQuery.of(context).size.width * 0.05,
          MediaQuery.of(context).size.height * 0.03,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),

            // 🩷 Ô nhập tên người gửi
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                hintText: 'Tên người gửi (có thể bỏ trống)',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              style: GoogleFonts.nunito(fontSize: 14),
              
              onChanged: (_) => controller.notifyListeners(),
            ),

            const SizedBox(height: 16),

            // 🩵 Hiển thị nội dung hiện tại trên nền ảnh
            AspectRatio(
              aspectRatio: 1.8 / 1,
              child: Container(
                alignment: Alignment.topLeft,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('card.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.03,
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      controller.messageController.text,
                      style: GoogleFonts.courierPrime(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🩷 Chọn team cô dâu / chú rể
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Center(
                      child: Text(
                        'Team Cô Dâu',
                        style: GoogleFonts.nunito(color: Colors.black),
                      ),
                    ),
                    selected: controller.isTeamBride,
                    selectedColor: const Color.fromARGB(255, 121, 198, 155),
                    onSelected: (_) => controller.toggleTeam(true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ChoiceChip(
                    label: Center(
                      child: Text(
                        'Team Chú Rể',
                        style: GoogleFonts.nunito(color: Colors.black),
                      ),
                    ),
                    selected: !controller.isTeamBride,
                    selectedColor: const Color.fromARGB(255, 121, 198, 155),
                    onSelected: (_) => controller.toggleTeam(false),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 🩵 Ô nhập nội dung + nút gửi
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      hintText: 'Nhập nội dung...',
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                    onChanged: (_) => controller.notifyListeners(),
                  ),
                ),
                const SizedBox(width: 8),

                controller.isSending
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Material(
                        color: controller.messageController.text.trim().isNotEmpty
                            ? const Color.fromARGB(255, 5, 41, 21)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: controller.messageController.text.trim().isEmpty
                              ? null
                              : () async {
                                  await controller.sendMessage();
                                  if (context.mounted) {
                                    setState(() => showThankYou = true);
                                    Future.delayed(const Duration(seconds: 3), () {
                                      if (mounted) {
                                        setState(() => showThankYou = false);
                                      }
                                    });
                                  }
                                },
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.send, color: Colors.white),
                          ),
                        ),
                      ),
              ],
            ),

            const SizedBox(height: 10),

            // ✅ Hiển thị dòng cảm ơn
            AnimatedOpacity(
              opacity: showThankYou ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Text(
                textAlign: TextAlign.center,
                "💌 Cảm ơn mọi người đã dành thời gian và gửi lời chúc đến tụi mình!",
                style: GoogleFonts.nunito(
                  
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 5, 41, 21),
                ),
              ),
            ),
          ],
        ),
      ),
        ],
      )
    );
  }
}

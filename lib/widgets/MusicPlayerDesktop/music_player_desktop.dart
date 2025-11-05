// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:wedding_web/controllers/player_controller.dart';
import 'package:wedding_web/widgets/MusicPlayerSection/cover.dart';
import 'package:wedding_web/widgets/MusicPlayerSection/notify.dart';
import 'package:wedding_web/widgets/MusicPlayerSection/player_controls.dart';

class MusicPlayerDesktop extends StatelessWidget {
  final double screenWidth;
  final PlayerController controller;

  const MusicPlayerDesktop({
    super.key,
    required this.screenWidth,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Ảnh nền toàn màn hình
        Positioned.fill(
          child: Image.asset('assets/bg.jpg', fit: BoxFit.cover),
        ),

        // Lớp phủ mờ
        Container(
          color: Colors.black.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(horizontal: 20),

          // LayoutBuilder để đo chiều cao màn hình
          child: LayoutBuilder(
            builder: (context, constraints) {
              final content = Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Notify(),
                  SizedBox(height: 16,),
                  Cover(),
                  
                  PlayerControls(controller: controller),
                  
                ],
              );

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    // Giữ ít nhất bằng chiều cao khung nhìn
                    minHeight: constraints.maxHeight,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: content,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

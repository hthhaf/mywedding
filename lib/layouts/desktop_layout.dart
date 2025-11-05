// lib/layouts/DesktopLayout.dart
import 'package:flutter/material.dart' hide Card;
import 'package:wedding_web/controllers/player_controller.dart';
import 'package:wedding_web/widgets/Frames/frames.dart';
import 'package:wedding_web/widgets/InvitationCard/invitation_card.dart';
import 'package:wedding_web/widgets/LoveStory/love_story.dart';
import 'package:wedding_web/widgets/Message/message_form.dart';
import 'package:wedding_web/widgets/MusicPlayerDesktop/music_player_desktop.dart';
import 'package:wedding_web/widgets/title.dart';

class DesktopLayout extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final PlayerController controller;

  const DesktopLayout({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // 1/3 màn hình cho MusicPlayer
    final double musicPlayerWidth = screenWidth / 3;

    // 2/3 còn lại cho phần nội dung
    final double contentWidth = screenWidth - musicPlayerWidth;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: musicPlayerWidth,
            height: screenHeight,
            child: MusicPlayerDesktop(
              screenWidth: musicPlayerWidth,
              controller: controller,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth * 0.8),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const LoveStory(),
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 211, 251, 222),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TitleText(text: 'The Big Day'),
                            const SizedBox(height: 12),

                            LayoutBuilder(
                              builder: (context, constraints) {
                                double cardWidth =
                                    (constraints.maxWidth - 40) /
                                    2; // chia đôi + khoảng cách
                                double cardAspectRatio = 1239 / 1556;
                                double cardHeight = cardWidth / cardAspectRatio;

                                return Container(
                                  height: cardHeight,

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: cardWidth,
                                        child: const InvitationCards(
                                          imageName: 'bride',
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      SizedBox(
                                        width: cardWidth,
                                        child: const InvitationCards(
                                          imageName: 'groom',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      Frame(),
                      const SizedBox(height: 20),
                      const MessageForm(),
                      const SizedBox(height: 20),
                      Text(
                        '2025 • Designed & developed by Hà',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wedding_web/controllers/player_controller.dart';
import 'package:wedding_web/widgets/Frames/frames.dart';
import 'package:wedding_web/widgets/InvitationCard/the_big_day.dart';
import 'package:wedding_web/widgets/LoveStory/love_story.dart';
import 'package:wedding_web/widgets/Message/message_form.dart';
import 'package:wedding_web/widgets/MusicPlayerMoblie/music_player_mobile.dart';
import 'package:wedding_web/widgets/footer.dart';

class MobileLayout extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final PlayerController controller;

  const MobileLayout({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.controller,
  });

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  final ScrollController _scrollController = ScrollController();
  double scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    final scale = (w / h) > 0.65 ? 0.85 : 1.0;
    final double baseDarkness = 0.3;
    final double darkness = (scrollOffset / 700).clamp(0, 0.8);

    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền toàn trang
          Positioned.fill(
            child: Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          // Lớp phủ tối dần
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(
                      ((baseDarkness + darkness * 0.6) * 255).round(),
                    ),
                    Colors.black.withAlpha(((darkness) * 255).round()),
                  ],
                ),
              ),
            ),
          ),

          // Nội dung chính
          Center(
            child: ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: w * 0.85 * scale),
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.9,
                        child: MusicPlayerMobile(
                          controller: widget.controller,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const LoveStory(),
                      const SizedBox(height: 20),
                      const TheBigDay(),
                      const SizedBox(height: 20),
                      Frame(),
                      const SizedBox(height: 20),
                      const MessageForm(),
                      const SizedBox(height: 20),
                      
                      const Footer(),
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

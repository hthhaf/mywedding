import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_web/controllers/player_controller.dart';

class PlayerControls extends StatefulWidget {
  final PlayerController controller;
  const PlayerControls({super.key, required this.controller});

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  late PlayerController controller;

  Future<void> togglePlayPause() async {
    if (!controller.isPlaying) {
      if (controller.currentDuration == Duration.zero) {
        await controller.play(0);
      } else {
        await controller.resume();
      }
    } else {
      await controller.pause();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double iconSize = width * 0.12;
        final double titleSongFontSize = width * 0.05;
        final double authorFontSize = width * 0.038;

        return Column(
          children: [
            // Song title
            SizedBox(
              width: width,
              child: Text(
                controller.currentSong.title,
                textAlign: TextAlign.left,
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: titleSongFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(
              width: width,
              child: Text(
                controller.currentSong.artist,
                textAlign: TextAlign.left,
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: authorFontSize,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),

            // Progress Bar
            StreamBuilder<Duration>(
              stream: controller.player.onPositionChanged,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration = controller.currentDuration;

                return Column(
                  children: [
                    SizedBox(
                      width: width,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 3,
                          trackShape: FullWidthTrackShape(),
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.white24,
                          thumbColor: Colors.white,
                        ),
                        child: Slider(
                          min: 0.0,
                          max: duration.inSeconds.toDouble(),
                          value: position.inSeconds.clamp(0, duration.inSeconds).toDouble(),
                          onChanged: (value) async {
                            final newPosition = Duration(seconds: value.toInt());
                            await controller.seek(newPosition);
                          },
                        ),
                      ),
                    ),

                    SizedBox(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(position),
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            "- ${_formatDuration(duration - position)}",
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            // Buttons
            SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.shuffle,
                    color: Colors.white,
                    size: iconSize * 0.5,
                  ),
                  GestureDetector(
                    onTap: controller.currentIndex > 0
                        ? () async {
                            await controller.previous();
                            setState(() {});
                          }
                        : null,
                    child: Icon(
                      Icons.skip_previous,
                      color: controller.currentIndex > 0 ? Colors.white : Colors.white38,
                      size: iconSize,
                    ),
                  ),
                  StreamBuilder<PlayerState>(
                    stream: controller.player.onPlayerStateChanged,
                    builder: (context, snapshot) {
                      final isPlaying = snapshot.data == PlayerState.playing;
                      return GestureDetector(
                        onTap: togglePlayPause,
                        child: Icon(
                          isPlaying ? Icons.pause_circle : Icons.play_circle,
                          color: Colors.white,
                          size: iconSize * 1.2,
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: controller.currentIndex < controller.playlist.length - 1
                        ? () async {
                            await controller.next();
                            setState(() {});
                          }
                        : null,
                    child: Icon(
                      Icons.skip_next,
                      color: controller.currentIndex < controller.playlist.length - 1
                          ? Colors.white
                          : Colors.white38,
                      size: iconSize,
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.repeat,
                    color: Colors.white,
                    size: iconSize * 0.5,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class FullWidthTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 2;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

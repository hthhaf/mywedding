import 'package:flutter/material.dart';
import 'package:wedding_web/controllers/player_controller.dart';
import 'package:wedding_web/widgets/MusicPlayerSection/cover.dart';
import 'package:wedding_web/widgets/MusicPlayerSection/notify.dart';
import 'package:wedding_web/widgets/MusicPlayerSection/player_controls.dart';

class MusicPlayerMobile extends StatelessWidget {
  final PlayerController controller;
  const MusicPlayerMobile({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Notify(),

        Cover(),

        PlayerControls(controller: controller),
      ],
    );
  }
}

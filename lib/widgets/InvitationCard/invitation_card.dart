// lib/widgets/InvitationCard/invitation_card.dart
import 'package:flutter/material.dart';

class InvitationCards extends StatelessWidget {
  final String imageName;
  const InvitationCards({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Xác định tỷ lệ ảnh gốc (của thiệp)
        //const double cardAspectRatio = 1239 / 1556;

        // Tính chiều cao theo chiều rộng hiện tại
        //double cardHeight = constraints.maxWidth / cardAspectRatio;

        return Center(
          child: Container(
            width: constraints.maxWidth,
            //height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                image: AssetImage('assets/card/$imageName.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}

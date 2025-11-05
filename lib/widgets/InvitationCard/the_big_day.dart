import 'package:flutter/material.dart';
import 'package:wedding_web/widgets/InvitationCard/invitation_card.dart';
import 'package:wedding_web/widgets/title.dart';

class TheBigDay extends StatefulWidget {
  const TheBigDay({super.key});

  @override
  State<TheBigDay> createState() => _TheBigDayState();
}

class _TheBigDayState extends State<TheBigDay> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = [
      const InvitationCards(imageName: 'bride'), // Nhà gái
      const InvitationCards(imageName: 'groom'), // Nhà trai
    ];

    return Container(
      //padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 211, 251, 222),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          TitleText(text: 'Ngày đặc biệt'),

          // --- Giống Spotify: trượt thủ công ---
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardAspectRatio = 1239 / 1556;
              final double cardHeight = constraints.maxWidth / cardAspectRatio;

              return SizedBox(
                height: cardHeight,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: cards.length,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: cards[index],
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // --- 2 chấm tròn ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(cards.length, (index) {
              bool isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color.fromARGB(255, 8, 59, 31)
                      : Colors.grey[400],
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wedding_web/widgets/title.dart';

class Frame extends StatefulWidget {
  const Frame({super.key});

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  /// Danh sách ảnh duy nhất
  final List<String> images = List.generate(
  34,
  (index) =>
      'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/pre_wedding/${index + 1}.jpg',
);


  /// Mở ảnh lớn (PhotoView)
  void openGallery(
    BuildContext context,
    List<String> images,
    int initialIndex,
  ) {
    final PageController pageController = PageController(
      initialPage: initialIndex,
    );

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.black,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // --- Bộ sưu tập có thể vuốt trái/phải ---
              ScrollConfiguration(
                behavior: const MaterialScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.trackpad,
                  },
                ),
                child: PhotoViewGallery.builder(
                  itemCount: images.length,
                  pageController: pageController,
                  scrollDirection: Axis.horizontal,
                  scrollPhysics: const BouncingScrollPhysics(),
                  onPageChanged: (i) {
                    setState(() {
                    });
                  },
                  builder: (context, i) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: AssetImage(images[i]),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    );
                  },
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),

              // --- Nút đóng có nền mờ ---
              Positioned(
                top: 40,
                right: 20,
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 26,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Grid hiển thị ảnh
  Widget buildGalleryGrid() {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth >= 1000 ? 6 : 4;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 211, 251, 222),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: GridView.custom(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: const [
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 2),
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 2),
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 2),
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 2),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            //final path = images[index];
            return GestureDetector(
              onTap: () => openGallery(context, images, index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(images[index], fit: BoxFit.cover),
              ),
            );
          }, childCount: images.length),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 211, 251, 222),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const TitleText(text: 'Trong từng khung hình'),

          // --- Giới hạn chiều cao bằng tỉ lệ, nội dung cuộn được ---
          AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: const Color.fromARGB(255, 234, 255, 241),
                child: SingleChildScrollView(child: buildGalleryGrid()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

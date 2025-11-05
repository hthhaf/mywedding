// lib/models/song.dart
import 'package:flutter/foundation.dart';

class Song {
  final String id;
  final String title;
  final String artist;
  final String audioPath;
  final String? coverImage;
  final Duration? duration;

  const Song({
    required this.id,
    this.title = "Unknown Title",
    this.artist = "Unknown Artist",
    required this.audioPath,
    this.coverImage,
    this.duration,
  });

  // ✅ Dễ khởi tạo từ JSON (sau này bạn có thể load từ file)
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? UniqueKey().toString(),
      title: json['title'] ?? 'Unknown Title',
      audioPath: json['audioPath'] ?? '',
      coverImage: json['coverImage'],
      duration: json['duration'] != null
          ? Duration(seconds: json['duration'])
          : null,
    );
  }

  // ✅ Dễ convert ngược lại sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'audioPath': audioPath,
      'coverImage': coverImage,
      'duration': duration?.inSeconds,
    };
  }

  // ✅ copyWith để cập nhật 1 phần dữ liệu mà không tạo mới toàn bộ
  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? audioPath,
    String? coverImage,
    Duration? duration,
  }) {
    return Song(
      id: id ?? this.id,
      audioPath: audioPath ?? this.audioPath,
      coverImage: coverImage ?? this.coverImage,
      duration: duration ?? this.duration,
    );
  }
}

final List<Song> playlist = [
  Song(
    id: '0',
    title: 'Young And Beautiful',
    artist: 'Lana Del Rey',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861915817_e67e78a31f23a0144f8eefb7f3d223f4.jpg',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/YoungAndBeautiful.mp3',
  ),
  Song(
    id: '1',
    title: 'You Are The Reason',
    artist: 'Calum Scott',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861417969_2980a0a3075bd3132fda302ad9aed575.jpg',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/YouAreTheReason.mp3',
  ),
  Song(
    id: '2',
    title: 'Until You',
    artist: 'Shayne Ward',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861327174_e0744a7749bdb455811fa298cc5a221c.jpg',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/UntilYou.mp3',
  ),
  Song(
    id: '3',
    title: 'Thinking Out Loud',
    artist: 'Ed Sheeran',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861327231_19c6b000a40dae8b0f5f07b0445f4242.jpg',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/ThinkingOutLoud.mp3',
  ),
  Song(
    id: '4',
    title: 'Sao Cũng Được',
    artist: 'Binz',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861762777_eaf3a405eb9fc0f8b2b91cab6fcb04d5.jpg',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/saocungduoc.mp3',
  ),
  Song(
    id: '5',
    title: 'Photograph',
    artist: 'Ed Sheeran',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861667086_bdc969f030b42eef0dcb4153091b31ba.jpg',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/Photograph.mp3',
  ),
  Song(
    id: '6',
    title: 'Perfect',
    artist: 'Ed Sheeran',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861579085_b3269b160841d0ba637f5ae556777abc.jpg',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/Perfect.mp3',
  ),
  Song(
    id: '7',
    title: 'Một Đời',
    artist: '14 Casper, Bon Nghiêm, buitruonglinh',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861500230_4fd4f322aefdcb06d1ee668431a4cb92.jpg',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/motdoi.mp3',
  ),
  Song(
    id: '8',
    title: 'Let\'s Not Fall In Love',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861418021_b24beb48d7958af62177324b07164f2e.jpg',
    artist: 'Big Bang',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/letsnotfallinlove.mp3',
  ),
  Song(
    id: '9',
    title: 'Girls Like You',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861327174_e0744a7749bdb455811fa298cc5a221c.jpg',
    artist: 'Maroon 5',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/GirlsLikeYou.mp3',
  ),
  Song(
    id: '10',
    title: 'Girls Like You',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861840472_7ab94e7bb42add55f16ed6a5fbc5ceb7.jpg',
    artist: 'Maroon 5',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/GirlsLikeYou.mp3',
  ),
  Song(
    id: '11',
    title: 'Girls Like You',
    coverImage: 'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/images/z7192861866900_e27489f272d4e4a3291da5df38d37a5a.jpg',
    artist: 'Maroon 5',
    audioPath:
        'https://svoyalmopdwzrymaesvf.supabase.co/storage/v1/object/public/song/GirlsLikeYou.mp3',
  ),
];

import 'package:audioplayers/audioplayers.dart';
import '../models/song.dart';

class PlayerController {
  final AudioPlayer _player = AudioPlayer();
  AudioPlayer get player => _player;

  final List<Song> playlist;

  int _currentIndex = 0;
  bool isPlaying = false;

  Duration currentPosition = Duration.zero;
  Duration currentDuration = Duration.zero;

  Stream<Duration> get positionStream => _player.onPositionChanged;
  Stream<Duration> get durationStream => _player.onDurationChanged;
  int get currentIndex => _currentIndex;

  PlayerController({required this.playlist}) {
    _player.onPositionChanged.listen((pos) {
      currentPosition = pos;
    });

    _player.onDurationChanged.listen((dur) {
      currentDuration = dur;
    });

    _player.onPlayerComplete.listen((_) async {
      await next(); // 🔄 dùng async để đảm bảo bài sau load ổn
    });
  }

  // 🟢 Lấy bài hiện tại (có kiểm tra)
  Song get currentSong =>
      (playlist.isNotEmpty && _currentIndex < playlist.length)
          ? playlist[_currentIndex]
          : playlist.first;

  // ▶️ Phát bài theo index
  Future<void> play(int index) async {
    if (index < 0 || index >= playlist.length) return;
    _currentIndex = index;

    await _player.stop();
    await _player.play(UrlSource(currentSong.audioPath));
    isPlaying = true;
  }

  // ⏸️ Tạm dừng
  Future<void> pause() async {
    await _player.pause();
    isPlaying = false;
  }

  // 🔄 Tiếp tục phát
  Future<void> resume() async {
    await _player.resume();
    isPlaying = true;
  }

  // ⏭️ Bài kế tiếp
  Future<void> next() async {
    if (_currentIndex < playlist.length - 1) {
      _currentIndex++;
      await play(_currentIndex);
    } else {
      await _player.stop();
      isPlaying = false;
    }
  }

  // ⏮️ Bài trước
  Future<void> previous() async {
    if (_currentIndex > 0) {
      _currentIndex--;
      await play(_currentIndex);
    }
  }

  // ⏩ Tua tiến trình
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  void dispose() {
    _player.dispose();
  }
}

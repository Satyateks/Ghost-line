
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../../core/theme/theme_route.dart';
import '../../model/message_model.dart';

class AudioMessageBubble extends StatefulWidget {
  final MessageModel message;

  const AudioMessageBubble({
    super.key,
    required this.message,
  });

  @override
  State<AudioMessageBubble> createState() => _AudioMessageBubbleState();
}

class _AudioMessageBubbleState extends State<AudioMessageBubble> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      if (widget.message.filePath != null) {
        await _audioPlayer.play(DeviceFileSource(widget.message.filePath!));
      } else {
        // dummy play for mocked audio
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mock audio playing...')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMe = widget.message.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            width: 172,
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.buttonBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _togglePlay,
                  child: Icon(
                    _isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: SizedBox(
                    height: 18,
                    child: CustomPaint(
                      painter: _WavePainter(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.message.audioDuration ?? '00:00',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 2, bottom: 14),
            child: Text(
              widget.message.time,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white38
                    : Colors.black38,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const bars = 22;
    final gap = size.width / bars;

    for (int i = 0; i < bars; i++) {
      final normalized = (i % 5) + 1;
      final barHeight = 4.0 + normalized * 2.4;
      final x = i * gap;
      final y1 = (size.height - barHeight) / 2;
      final y2 = y1 + barHeight;

      canvas.drawLine(Offset(x, y1), Offset(x, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';


import '../model/message_model.dart';

class ChatRoomController extends GetxController {
  final messageCtrl = TextEditingController();

  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isTyping = false.obs;
  final RxBool isRecording = false.obs;

  final ImagePicker _picker = ImagePicker();
  final _audioRecorder = AudioRecorder();
  String? _audioPath;

  @override
  void onInit() {
    super.onInit();
    _loadDummyMessages();
    messageCtrl.addListener(() {
      isTyping.value = messageCtrl.text.isNotEmpty;
    });
  }

  String _currentTime() {
    final now = DateTime.now();
    int hour = now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return '$hour:$minute $period';
  }

  void sendMessage() {
    final text = messageCtrl.text.trim();

    if (text.isEmpty) return;

    messages.insert(
      0,
      MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: text,
        time: _currentTime(),
        isMe: true,
        isRead: false,
      ),
    );

    messageCtrl.clear();
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      messages.insert(
        0,
        MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          message: '',
          time: _currentTime(),
          isMe: true,
          type: MessageType.image,
          filePath: image.path,
        ),
      );
    }
  }

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.pickFiles();
    if (result != null && result.files.single.path != null) {
      messages.insert(
        0,
        MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          message: result.files.single.name,
          time: _currentTime(),
          isMe: true,
          type: MessageType.document,
          filePath: result.files.single.path,
        ),
      );
    }
  }

  Future<void> toggleRecording() async {
    if (isRecording.value) {
      final path = await _audioRecorder.stop();
      isRecording.value = false;
      if (path != null) {
        messages.insert(
          0,
          MessageModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            message: '',
            time: _currentTime(),
            isMe: true,
            type: MessageType.audio,
            filePath: path,
            audioDuration: '00:05', // Mocked duration
          ),
        );
      }
    } else {
      if (await _audioRecorder.hasPermission()) {
        final Directory tempDir = await getTemporaryDirectory();
        _audioPath = '${tempDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
        await _audioRecorder.start(const RecordConfig(), path: _audioPath!);
        isRecording.value = true;
      }
    }
  }

  void sendAudioDummy() {
    messages.insert(
      0,
      MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: '',
        time: 'Just now',
        isMe: true,
        type: MessageType.audio,
        audioDuration: '00:16',
        isRead: true,
      ),
    );
  }

  void _loadDummyMessages() {
    messages.assignAll([
      MessageModel(
        id: '6',
        message: '',
        time: 'Read Just now',
        isMe: true,
        type: MessageType.audio,
        audioDuration: '00:16',
        isRead: true,
      ),
      MessageModel(
        id: '5',
        message: 'Ok wait',
        time: '10:05 AM',
        isMe: true,
      ),
      MessageModel(
        id: '4',
        message: '₹23,000? Also send the photos',
        time: '10:04 AM',
        isMe: false,
      ),
      MessageModel(
        id: '3',
        message:
            'Lorem ipsum dolor sit amet\nconsectetur. At molestie praesent\ndiam purus sit enim commodo\nlobortis in. Vitae bibendum\nmaecenas arcu sit quis duis.',
        time: '10:00 AM',
        isMe: false,
      ),
      MessageModel(
        id: '2',
        message: 'Hello ! Anil  How are you?',
        time: '09:59 AM',
        isMe: true,
      ),
      MessageModel(
        id: '1',
        message: 'Hello ! Satyam How are you?',
        time: '09:58 AM',
        isMe: false,
      ),
    ]);
  }

  @override
  void onClose() {
    messageCtrl.dispose();
    _audioRecorder.dispose();
    super.onClose();
  }
}
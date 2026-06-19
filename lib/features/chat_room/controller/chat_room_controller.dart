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
        id: '18',
        message: 'Awesome! Let me review this and get back to you. 👍',
        time: 'Read Just now',
        isMe: false,
        isRead: true,
      ),
      MessageModel(
        id: '17',
        message: 'Property_Brochure_v2.pdf (4.2 MB)',
        time: '11:22 AM',
        isMe: true,
        type: MessageType.document, 
      ),
      MessageModel(
        id: '16',
        message: 'Perfect. Sending over the official brochure and agreement draft now. 📄✨',
        time: '11:20 AM',
        isMe: true,
      ),
      MessageModel(
        id: '15',
        message: 'Thanks! I received the documents.',
        time: '11:19 AM',
        isMe: true,
        isRead: true,
      ),
      MessageModel(
        id: '14',
        message: '',
        time: '11:18 AM',
        isMe: false,
        type: MessageType.audio,
        audioDuration: '00:28',
      ),
      MessageModel(
        id: '13',
        message: 'Can you share the location as well? 📍',
        time: '11:15 AM',
        isMe: false,
      ),
      MessageModel(
        id: '12',
        message: 'Grand Avenue, Sector 62, Noida',
        time: '11:12 AM',
        isMe: true,
        type: MessageType.text,
      ),
      MessageModel(
        id: '11',
        message: 'The property is still available! It has 3 bedrooms, 2 bathrooms, a modular kitchen, and dedicated parking space. 🚗🏡',
        time: '11:10 AM',
        isMe: false,
      ),
      MessageModel(
        id: '10',
        message: 'Looks really good. What is the final expected price? 💰',
        time: '11:08 AM',
        isMe: true,
      ),
      MessageModel(
        id: '9',
        message: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2', // Living room image
        time: '11:06 AM',
        isMe: false,
        type: MessageType.image,
      ),
      MessageModel(
        id: '8',
        message: 'Here are the latest photos of the living room and balcony. 📸👇',
        time: '11:05 AM',
        isMe: false,
      ),
      MessageModel(
        id: '7',
        message: 'I can offer a slight discount if we close the deal this week. Let\'s schedule a visit. 🤝',
        time: '10:10 AM',
        isMe: false,
      ),
      MessageModel(
        id: '6',
        message: '',
        time: '10:08 AM',
        isMe: true,
        type: MessageType.audio,
        audioDuration: '00:16',
        isRead: true,
      ),
      MessageModel(
        id: '5',
        message: 'Ok wait, let me check with the owner.',
        time: '10:05 AM',
        isMe: true,
      ),
      MessageModel(
        id: '4',
        message: '₹23,000? That sounds reasonable. Also send the photos please! 🙏',
        time: '10:04 AM',
        isMe: false,
      ),
      MessageModel(
        id: '3',
        message: 'The current expected rent is ₹23,000 per month, plus maintenance. Let me know if that works for you.',
        time: '10:00 AM',
        isMe: true,
      ),
      MessageModel(
        id: '2',
        message: 'Hello Anil! I\'m doing great. Hope you are doing well too. Regarding that property you asked about...',
        time: '09:59 AM',
        isMe: true,
      ),
      MessageModel(
        id: '1',
        message: 'Hello Satyam! How are you doing today? 😊',
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




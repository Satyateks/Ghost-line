import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/greeting_model.dart';
import '../model/voicemail_model.dart';
 
 

enum GreetingType { defaultGreeting, customGreeting}

 
 

class VoicemailController extends GetxController {
  final searchController = TextEditingController();

  final selectedBottomIndex = 2.obs;
  final searchQuery = ''.obs;

  final selectedGreeting = GreetingType.customGreeting.obs;

  final voicemails = <VoicemailModel>[].obs;
  final greetings = <GreetingModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadVoicemails();
    loadGreetings();

    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });
  }

  void loadVoicemails() {
    voicemails.value = [
      VoicemailModel(
        id: "1",
        name: "Satyam",
        image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300",
        message: "Hi, please call...",
        date: "15/06/2026",
        time: "00:30",
        duration: "00:30",
        isRecent: true,
      ),
      VoicemailModel(
        id: "2",
        name: "Lavit Reddy",
        image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300",
        message: "Hi, please call...",
        date: "15/06/2026",
        time: "00:30",
        duration: "00:30",
        isRecent: true,
      ),
      VoicemailModel(
        id: "3",
        name: "Abhay Singh",
        image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300",
        message: "Hi, please call...",
        date: "15/06/2026",
        time: "00:30",
        duration: "00:30",
        isRecent: true,
      ),
      VoicemailModel(
        id: "4",
        name: "Sneha Singh",
        image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300",
        message: "Hi, please call...",
        date: "15/06/2026",
        time: "00:30",
        duration: "00:30",
        isRecent: true,
      ),
      VoicemailModel(
        id: "5",
        name: "Satyam Mishra",
        image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300",
        message: "Hi, please call...",
        date: "15/06/2026",
        time: "00:30",
        duration: "00:30",
        isRecent: false,
      ),
      VoicemailModel(
        id: "6",
        name: "Lavit Reddy",
        image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300",
        message: "Hi, please call...",
        date: "15/06/2026",
        time: "00:30",
        duration: "00:30",
        isRecent: false,
      ),
      VoicemailModel(
        id: "7",
        name: "Abhay Singh",
        image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300",
        message: "Hi, please call...",
        date: "15/06/2026",
        time: "00:30",
        duration: "00:30",
        isRecent: false,
      ),
      VoicemailModel(
        id: "8",
        name: "Sneha Singh",
        image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300",
        message: "Hi, please call...",
        date: "15/06/2026",
        time: "00:30",
        duration: "00:30",
        isRecent: false,
      ),
VoicemailModel(
  id: "9",
  name: "Rahul Sharma",
  image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300",
  message: "Please check the updated document.",
  date: "14/06/2026",
  time: "01:15",
  duration: "01:15",
  isRecent: false,
),
VoicemailModel(
  id: "10",
  name: "Neha Verma",
  image: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=300",
  message: "Call me when you're free.",
  date: "14/06/2026",
  time: "00:45",
  duration: "00:45",
  isRecent: false,
),
VoicemailModel(
  id: "11",
  name: "Amit Kumar",
  image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300",
  message: "Meeting rescheduled to 4 PM.",
  date: "13/06/2026",
  time: "00:20",
  duration: "00:20",
  isRecent: false,
),
VoicemailModel(
  id: "12",
  name: "Pooja Gupta",
  image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300",
  message: "Please review the proposal.",
  date: "13/06/2026",
  time: "01:05",
  duration: "01:05",
  isRecent: false,
),
VoicemailModel(
  id: "13",
  name: "Rohit Mehta",
  image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300",
  message: "Need your feedback.",
  date: "12/06/2026",
  time: "00:38",
  duration: "00:38",
  isRecent: false,
),
VoicemailModel(
  id: "14",
  name: "Anjali Jain",
  image: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=300",
  message: "Let's connect tomorrow.",
  date: "12/06/2026",
  time: "00:55",
  duration: "00:55",
  isRecent: false,
),
VoicemailModel(
  id: "15",
  name: "Vikas Yadav",
  image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300",
  message: "Please return my call.",
  date: "11/06/2026",
  time: "01:22",
  duration: "01:22",
  isRecent: false,
),
VoicemailModel(
  id: "16",
  name: "Sneha Kapoor",
  image: "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=300",
  message: "Urgent update regarding project.",
  date: "11/06/2026",
  time: "00:42",
  duration: "00:42",
  isRecent: false,
),
VoicemailModel(
  id: "17",
  name: "Karan Malhotra",
  image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300",
  message: "Please call back.",
  date: "10/06/2026",
  time: "00:27",
  duration: "00:27",
  isRecent: false,
),
VoicemailModel(
  id: "18",
  name: "Meera Sharma",
  image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300",
  message: "Waiting for your response.",
  date: "10/06/2026",
  time: "01:10",
  duration: "01:10",
  isRecent: false,
),
VoicemailModel(
  id: "19",
  name: "Sanjay Verma",
  image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300",
  message: "Project discussion pending.",
  date: "09/06/2026",
  time: "00:35",
  duration: "00:35",
  isRecent: false,
),
VoicemailModel(
  id: "20",
  name: "Nidhi Singh",
  image: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=300",
  message: "Please share the details.",
  date: "09/06/2026",
  time: "00:58",
  duration: "00:58",
  isRecent: false,
),      
    ];
  }

  void loadGreetings() {
    greetings.value = [
      GreetingModel(
        id: "1",
        title: "Hey there, Drop your m...",
        date: "15/06/2026",
        audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
      ),
      GreetingModel(
        id: "2",
        title: "Hey there, Drop your m...",
        date: "15/06/2026",
        audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3"
      ),
      GreetingModel(
        id: "3",
        title: "Hey there, Drop your m...",
        date: "21/06/2026",
        audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3"
      ),
    ];
  }

  List<VoicemailModel> get filteredVoicemails {
    if (searchQuery.value.isEmpty) {
      return voicemails;
    }

    return voicemails.where((item) {
      final query = searchQuery.value.toLowerCase();
      return item.name.toLowerCase().contains(query) ||
          item.message.toLowerCase().contains(query) ||
          item.date.toLowerCase().contains(query);
    }).toList();
  }

  List<VoicemailModel> get recentVoicemails {
    return filteredVoicemails.where((item) => item.isRecent).toList();
  }

  List<VoicemailModel> get olderVoicemails {
    return filteredVoicemails.where((item) => !item.isRecent).toList();
  }


  void toggleVoicemailPlay(String id) {
    for (final item in voicemails) {
      item.isPlaying = item.id == id ? !item.isPlaying : false;
    }
    voicemails.refresh();
  }

  void toggleGreetingPlay(String id) {
    for (final item in greetings) {
      item.isPlaying = item.id == id ? !item.isPlaying : false;
    }
    greetings.refresh();
  }

  void deleteVoicemail(String id) {
    voicemails.removeWhere((item) => item.id == id);
    Get.back();
  }

  void deleteGreeting(String id) {
    greetings.removeWhere((item) => item.id == id);
  }

  void useGreeting(String id) {
    selectedGreeting.value = GreetingType.customGreeting;
    Get.snackbar(
      "Greeting selected",
      "Custom greeting has been selected",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void selectGreeting(GreetingType type) {
    selectedGreeting.value = type;
  }

  void recordGreeting() {
    Get.snackbar(
      "Recording",
      "Recording feature will connect with audio recorder.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void changeBottomTab(int index) {
    selectedBottomIndex.value = index;

    // TODO: connect with actual project routes
    // 0 Calls
    // 1 Chat
    // 2 Voicemail
    // 3 Updates
    // 4 Profile
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}






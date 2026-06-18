import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghostline/features/voiceMall/ui/voicemail_detail_screen.dart';
import 'package:ghostline/features/voiceMall/ui/voicemail_greetings_screen.dart';

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
        name: "Rajat Tikaram",
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
        name: "Rajat Tikaram",
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
    ];
  }

  void loadGreetings() {
    greetings.value = [
      GreetingModel(
        id: "1",
        title: "Hey there, Drop your m...",
        date: "15/06/2026",
      ),
      GreetingModel(
        id: "2",
        title: "Hey there, Drop your m...",
        date: "15/06/2026",
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

  void openVoicemailDetail(VoicemailModel voicemail) {
    Get.to(VoicemailDetailScreen(), arguments: voicemail);
  }

  void openGreetings() {
    Get.to(VoicemailGreetingsScreen());
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






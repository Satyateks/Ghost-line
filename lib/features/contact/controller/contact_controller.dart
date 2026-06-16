
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/contact_detail_screen.dart';

class ContactController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  final profileImage =
      "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500";

  String get fullName {
    final first = firstNameController.text.trim();
    final last = lastNameController.text.trim();

    if (first.isEmpty && last.isEmpty) {
      return "Rajat Tikaram";
    }

    return "$first $last".trim();
  }

  String get mobileNumber {
    final number = mobileController.text.trim();
    return number.isEmpty ? "+91 9565494959" : number;
  }

  String get userHandle {
    final first = firstNameController.text.trim();
    if (first.isEmpty) return "@satyam1121";
    return "@${first.replaceAll(" ", "")}123";
  }

  void saveContact() {
    Get.to(ContactDetailScreen());
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.onClose();
  }
}


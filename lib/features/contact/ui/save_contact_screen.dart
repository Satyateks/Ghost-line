import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/contact_controller.dart';
import 'widgets/contact_text_field.dart';


class SaveContactScreen extends StatelessWidget {
  SaveContactScreen({super.key});

  final ContactController controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    const SizedBox(height: 42),

                    Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF075A6B),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        controller.profileImage,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 58),

                    ContactTextField(
                      controller: controller.firstNameController,
                      hintText: "First Name",
                    ),

                    const SizedBox(height: 12),

                    ContactTextField(
                      controller: controller.lastNameController,
                      hintText: "Last Name",
                    ),

                    const SizedBox(height: 12),

                    ContactTextField(
                      controller: controller.mobileController,
                      hintText: "Mobile Number",
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 12),

                    ContactTextField(
                      controller: controller.emailController,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(13, 10, 13, 15),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ),
              child: SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.saveContact,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F86F6),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    "Save Contact",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
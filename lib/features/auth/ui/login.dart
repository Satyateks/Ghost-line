// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme_route.dart';
import '../../../core/utils/utils_route.dart';
import '../../home/ui/home_screen.dart';
import '../controller/authCtl.dart';


class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final AuthUiController authCtrl = Get.put(AuthUiController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: isDark ? Colors.black : AppColors.lightBg,
        body: Container(
          decoration: BoxDecoration(
            gradient: isDark ? AppColors.darkBgGradient : AppColors.lightBgGradient,
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = MediaQuery.sizeOf(context);
                final bottomInset = MediaQuery.of(context).viewInsets.bottom;

                return SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(bottom: bottomInset + 12),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: size.height * 0.025,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset(
                              AppAssets.ghostLogo,
                              height: size.height * 0.035,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        Positioned(
                          top: size.height * 0.085,
                          left: 8,
                          right: 8,
                          child: Image.asset(
                            AppAssets.onboarding,
                            height: size.height * 0.36,
                            fit: BoxFit.contain,
                          ),
                        ),

                        Positioned(
                          top: size.height * 0.445,
                          left: 0,
                          right: 0,
                          child: const _AuthIntroText(),
                        ),

                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * 0.54),
                            child: Obx(
                              () => AnimatedSwitcher(
                                duration: const Duration(milliseconds: 280),
                                switchInCurve: Curves.easeOutCubic,
                                switchOutCurve: Curves.easeInCubic,
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,alwaysIncludeSemantics: true,
                                    child: SlideTransition(
                                      position: Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(animation),
                                      child: child,
                                    ),
                                  );
                                },
                                child: _cardByType( authCtrl.currentCard.value ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }



  Widget _cardByType(AuthCardType type) {
    switch (type) {
      case AuthCardType.login: return _LoginCard(key: const ValueKey('login'), controller: authCtrl);
      case AuthCardType.createAccount: return _CreateAccountCard( key: const ValueKey('createAccount'), controller: authCtrl);
      case AuthCardType.otp: return _OtpCard(key: const ValueKey('otp'), controller: authCtrl);
      case AuthCardType.username: return _UsernameCard( key: const ValueKey('username'), controller: authCtrl);
    }
  }
}

class _LoginCard extends StatelessWidget {
  final AuthUiController controller;

  const _LoginCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return _AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _AuthTitle("Log in"),
          const SizedBox(height: 12),

          _AuthField(
            controller: controller.loginIdCtrl,
            hint: "Enter Username or mobile",
          ),

          const SizedBox(height: 8),

          _AuthField(
            controller: controller.loginPasswordCtrl,
            hint: "Enter Password",
            obscureText: true,
          ),

          const SizedBox(height: 9),

          Center(
            child: GestureDetector(
              onTap: controller.showCreateAccount,
              child: Builder(
                builder: (context) {
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  return RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: isDark ? Colors.white.withOpacity(0.62) : AppColors.lightTextMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      children: const [
                        TextSpan(
                          text: "Create account",
                          style: TextStyle(fontSize: 15,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 15),

          _AuthPrimaryButton(
            title: "Continue",
            onTap: controller.showOtp,
          ),
        ],
      ),
    );
  }
}
class _CreateAccountCard extends StatelessWidget {
  final AuthUiController controller;

  const _CreateAccountCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return _AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _AuthTitle("Create an account"),
          const SizedBox(height: 12),

          _AuthField(
            controller: controller.createIdCtrl,
            hint: "Mobile or Email",
          ),

          const SizedBox(height: 8),

          _AuthField(
            controller: controller.createPasswordCtrl,
            hint: "Choose Password",
            obscureText: true,
          ),

          const SizedBox(height: 9),

          Center(
            child: GestureDetector(
              onTap: controller.showLogin,
              child: Builder(
                builder: (context) {
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  return RichText(
                    text: TextSpan(
                      text: "Have an existing account ",
                      style: TextStyle(
                        color: isDark ? Colors.white.withOpacity(0.62) : AppColors.lightTextMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      children: const [
                        TextSpan(
                          text: "Log in",
                          style: TextStyle(fontSize: 14,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 15),

          _AuthPrimaryButton(
            title: "Continue",
            onTap: controller.showOtp,
          ),
        ],
      ),
    );
  }
}

class _OtpCard extends StatelessWidget {
  final AuthUiController controller;

  const _OtpCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark ? Colors.white : AppColors.lightTextPrimary;
    
    return _AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: controller.showLogin,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textSecondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 6),
              _AuthTitle("Enter OTP"),
            ],
          ),

          const SizedBox(height: 11),

          Row(
            children: [
              Text(
                "An OTP was sent to xxx90",
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: controller.showLogin,
                child: const Text(
                  "Change Number",
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 17),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              6, (index) => _OtpBox(
                controller: controller.otpControllers[index],
                isLast: index == 5,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Resend in 35s",
              style: TextStyle(
                color: textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 16),

          _AuthPrimaryButton(
            title: "Continue",
            onTap: controller.showUsername,
          ),
        ],
      ),
    );
  }
}

class _UsernameCard extends StatelessWidget {
  final AuthUiController controller;

  const _UsernameCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return _AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _AuthTitle("Choose a Username"),
          const SizedBox(height: 21),

          _AuthField( controller: controller.usernameCtrl, hint: "Choose a Username"),

          const SizedBox(height: 27),

          _AuthPrimaryButton(
            title: "Continue",
            onTap: () {
              Get.offAll(() => HomeScreen());
            },
          ),
        ],
      ),
    );
  }
}
class _AuthTitle extends StatelessWidget {
  final String title;

  const _AuthTitle(this.title);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Text(
      title,
      style: AppTextStyles.authTitle(isDark ? Colors.white : AppColors.lightTextPrimary).copyWith(
        fontSize: 21,height: 1.24,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;

  const _AuthField({
    required this.controller,
    required this.hint,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final hintColor = isDark ? Colors.white.withOpacity(0.44) : AppColors.lightTextMuted;
    final fieldBgColor = isDark ? Colors.white.withOpacity(0.08) : AppColors.lightBorder.withOpacity(0.5);
    
    return SizedBox(
      height: 41,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: AppColors.primaryBlue,
        style: TextStyle(
          color: textColor,
          fontSize: 10.5,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 9.7,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: fieldBgColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 0,
          ),
          border: _fieldBorder(color: isDark ? Colors.transparent : AppColors.lightBorder),
          enabledBorder: _fieldBorder(color: isDark ? Colors.transparent : AppColors.lightBorder),
          focusedBorder: _fieldBorder(
            color: AppColors.primaryBlue.withOpacity(0.65),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _fieldBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.full),
      borderSide: BorderSide(
        color: color ?? Colors.transparent,
        width: 1,
      ),
    );
  }
}

class _AuthPrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _AuthPrimaryButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SizedBox(
      height: 41,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonBlue,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.white,
            fontSize: 10.8,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final bool isLast;

  const _OtpBox({
    required this.controller,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final fieldBgColor = isDark ? Colors.white.withOpacity(0.08) : AppColors.lightBorder.withOpacity(0.5);
    
    return SizedBox(
      height: 48,
      width: 51,
      child: TextFormField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(1)],
        cursorColor: AppColors.primaryBlue,
        style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: fieldBgColor,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && !isLast) FocusScope.of(context).nextFocus();
          if (value.isEmpty) FocusScope.of(context).previousFocus();
        },
      ),
    );
  }
}

class _AuthIntroText extends StatelessWidget {
  const _AuthIntroText();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final subtitleColor = isDark ? Colors.white.withOpacity(0.58) : AppColors.lightTextSecondary;
    
    return Column(
      children: [
        Text(
          "Find Your Dream Home\nWithout the Hassle",
          textAlign: TextAlign.center,
          style: AppTextStyles.h3(titleColor).copyWith(
            fontSize: 16,
            height: 1.16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Discover premium properties, connect with trusted owners,\nand lock your perfect space today.",
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall(
            subtitleColor,
          ).copyWith(
            fontSize: 10.5,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

class _AuthGlassCard extends StatelessWidget {
  final Widget child;

  const _AuthGlassCard({ required this.child });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur( sigmaX: 18, sigmaY: 18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 21, 12, 24),
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.white.withOpacity(0.075)
                : Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: isDark ? Colors.white.withOpacity(0.07) : Colors.white.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.35) : Colors.black.withOpacity(0.1),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}






// ignore_for_file: deprecated_member_use



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghostline/features/auth/ui/authGlassCard.dart';

import '../../../core/theme/theme_route.dart';
import '../../../core/utils/utils_route.dart';
import '../../home/ui/home_screen.dart';

import '../controller/authCtl.dart';
import 'premiumScreen.dart';
  

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
        body: Container(decoration: BoxDecoration(gradient: isDark ? AppColors.darkBgGradient : AppColors.lightBgGradient),
          child: SafeArea(top: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = MediaQuery.sizeOf(context);
                final bottomInset = MediaQuery.of(context).viewInsets.bottom;
          
                return SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(bottom: bottomInset + 7),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Stack(
                      children: [
                        Positioned.fill(child: Image.asset(isDark? AppAssets.authBg: AppAssets.authBgLight,alignment: Alignment.topCenter, fit: BoxFit.fill)),
                        Positioned(top: size.height * 0.065, left: 0, right: 0,
                          child: Center(child:isDark? Image.asset(AppAssets.ghostLogo, height: size.height * 0.045, fit: BoxFit.contain): Image.asset(AppAssets.ghostLogo1, height: size.height * 0.045, fit: BoxFit.contain),  ),
                        ),
          
                        Positioned(top: size.height * 0.06, left: 4, right: 4,
                          child: Image.asset(AppAssets.onboarding,fit: BoxFit.contain, // height: size.height * 0.36,
                          ),
                        ),
                        Positioned(top: size.height * 0.49, left: 0, right: 0, child: const _AuthIntroText()),
          
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
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
      case AuthCardType.username: return _UsernameCard(key: const ValueKey('username'), controller: authCtrl);
      case AuthCardType.forgetPwd: return _ForgetPwdCard(key: const ValueKey('forgetPwd'), controller: authCtrl);
      case AuthCardType.setPwd: return _SetPwdCard(key: const ValueKey('setPwd'), controller: authCtrl);
      case AuthCardType.forgetOtp: return _PwdOtpCard(key: const ValueKey('forgetOtp'), controller: authCtrl);
      case AuthCardType.sendOtp: return _SendOtpCard(key: const ValueKey('sendOtp'), controller: authCtrl);
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
    return AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthTitle("Log in"),
          const SizedBox(height: 12),

          AuthField(
            controller: controller.loginIdCtrl,
            hint: "Enter Username or mobile",
          ),

          const SizedBox(height: 8),

          AuthField(
            controller: controller.loginPasswordCtrl,
            hint: "Enter Password",
            obscureText: true,
          ),

          const SizedBox(height: 9),
           Row(
            children: [
              GestureDetector(onTap: controller.showCreateAccount,
                child: Text(
                  "Create account",
                  style:AppTextStyles.bodyMedium(AppColors.primaryBlue).copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: controller.showForgetPwd,
                child: Text("Forget password?",style:AppTextStyles.bodyMedium(AppColors.primaryBlue).copyWith(fontWeight: FontWeight.w700)),
              ),
            ],
          ),

         /* Center(
            child: GestureDetector(
              onTap: controller.showCreateAccount,
              child: Builder(
                builder: (context) {
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  return RichText( text: TextSpan( text: "Don't have an account? ",
                      style: TextStyle( color: isDark ? Colors.white.withOpacity(0.62) : AppColors.lightTextMuted, fontSize: 14, fontWeight: FontWeight.w400, ),
                      children: const [
                        TextSpan( text: "Create account", style: TextStyle(fontSize: 15, color: AppColors.primaryBlue, fontWeight: FontWeight.w700, ), ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),*/

          const SizedBox(height: 15),

          _AuthPrimaryButton(title: "Continue", onTap: controller.showOtp),
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
    return AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthTitle("Create an account"),
          const SizedBox(height: 12),

          AuthField(
            controller: controller.createIdCtrl,
            hint: "Mobile or Email",
          ),

          const SizedBox(height: 8),

          AuthField(
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
    
    return AuthGlassCard(
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
              AuthTitle("Enter OTP"),
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

          _AuthPrimaryButton(title: "Continue", onTap: controller.showUsername),
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
    return AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthTitle("Choose a Username"),
          const SizedBox(height: 21),

          AuthField( controller: controller.usernameCtrl, hint: "Choose a Username"),

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

class _ForgetPwdCard extends StatelessWidget {
  final AuthUiController controller;

  const _ForgetPwdCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark ? Colors.white : AppColors.lightTextPrimary;
    return AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            children: [
              GestureDetector(
                onTap: controller.showLogin,
                child: Icon( Icons.arrow_back_ios_new_rounded,
                  color: textSecondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 6),
              const AuthTitle("forget password"),
            ],
          ),
          const SizedBox(height: 21),

          AuthField( controller: controller.forgetPwdCtrl, hint: "enter username"),

          const SizedBox(height: 27),

          _AuthPrimaryButton(
            title: "Send verification",
            onTap:controller.showSendOtp,
          ),
        ],
      ),
    );
  }
}

class _SendOtpCard extends StatelessWidget {
  final AuthUiController controller;

  const _SendOtpCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final titleColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final subColor = isDark ? Colors.white60 : AppColors.lightTextSecondary;
    final dividerColor = isDark ? Colors.white.withOpacity(0.10) : Colors.black.withOpacity(0.08);
    final textSecondary = isDark ? Colors.white : AppColors.lightTextPrimary;

    return AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: controller.showForgetPwd,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textSecondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 6),
              AuthTitle( "Send OTP to" ),
            ],
          ),

          

          const SizedBox(height: 22),

          _OtpOptionTile(
            icon: Icons.mail_outline_rounded,
            title: "Mail",
            value: "*******dev@gmail.com",
            titleColor: titleColor,
            subColor: subColor,
            onTap: controller.showForgetOtp
          ),

          Divider( height: 7, thickness: 0.7, color: dividerColor),

          _OtpOptionTile(
            icon: Icons.phone_outlined,
            title: "Phone",
            value: "*******79",
            titleColor: titleColor,
            subColor: subColor,
            onTap: controller.showForgetOtp
          ),const SizedBox(height: 27),
        ],
      ),
    );
  }
}

class _PwdOtpCard extends StatelessWidget {
  final AuthUiController controller;

  const _PwdOtpCard({ super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark ? Colors.white : AppColors.lightTextPrimary;
    
    return AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: controller.showSendOtp,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textSecondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 6),
              AuthTitle("Enter OTP"),
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
                onTap: controller.showSendOtp,
                child: const Text(
                  "Choose another method",
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
            onTap:controller.showSetPwd,
          ),
        ],
      ),
    );
  }
}

class _SetPwdCard extends StatelessWidget {
  final AuthUiController controller;

  const _SetPwdCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AuthGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            AuthTitle("Choose new password"),
          const SizedBox(height: 21),

          AuthField( controller: controller.newPwdCtrl, hint: "New password"),
          const SizedBox(height: 8),
          AuthField( controller: controller.cNewPwdCtrl, hint: "Confirm new password"),

          const SizedBox(height: 27),

          _AuthPrimaryButton(title: "Done", onTap: ()=>Get.to(() => PremiumScreen())),
        ],
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
      width: 48,
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
            fontSize: 22,
            height: 1.16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Discover premium properties, connect with trusted owners,\nand lock your perfect space today.",
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge(subtitleColor),
        ),
      ],
    );
  }
}



class _OtpOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color titleColor;
  final Color subColor;
  final VoidCallback onTap;

  const _OtpOptionTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.titleColor,
    required this.subColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 24, color: titleColor),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyHighLarge(titleColor)),
                  const SizedBox(height: 2),
                  Text(value, style: AppTextStyles.bodySmall(subColor).copyWith(fontWeight: FontWeight.w400)),
                ],
              ),
            ),

            Icon(Icons.arrow_forward_ios_rounded, size: 18, color: titleColor),
          ],
        ),
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
      height: 45,
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
            fontSize: 16.8,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}



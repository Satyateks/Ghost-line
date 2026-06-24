
// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghostline/core/utils/app_assets.dart';
import 'package:ghostline/features/update/controller/updates_controller.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';




class SuggestedForYouWidget extends StatelessWidget {
  final List<dynamic> users;
  const SuggestedForYouWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final msgColor = isDark ? Colors.white : AppColors.lightTextSecondary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text("   Suggested for you", style:AppTextStyles.bodyHighLarge(msgColor)),
        const SizedBox(height: 12),

        SizedBox(
          height: 171,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final user = users[index];
              return _SuggestionCard(user: user);
            },
          ),
        ),
      ],
    );
  }
}





class _SuggestionCard extends StatefulWidget {
  final dynamic user;
  const _SuggestionCard({required this.user});

  @override
  State<_SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<_SuggestionCard> {
  bool isFollowing = false;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final msgColor = isDark ? Colors.white : AppColors.lightTextSecondary;
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:isDark ? AppColors.darkGlass : AppColors.lightBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(onTap: () {},
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: (widget.user.profileImage != null && widget.user.profileImage!.isNotEmpty)
                  ? NetworkImage(widget.user.profileImage!)
                  : const AssetImage(AppAssets.authBg,)
              as ImageProvider,
            ),
          ),
          const SizedBox(height: 10),

          GestureDetector(onTap: () {},
            child: Column(
              children: [
                Text(
                  widget.user.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:AppTextStyles.bodyMedium(msgColor).copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),

                // Text( widget.user.designation ?? "", maxLines: 1, overflow: TextOverflow.ellipsis,x style:AppTextStyles.bodyMedium(msgColor)),
              ],
            ),
          ),

          const Spacer(),
          _AuthPrimaryButton(
            title:isFollowing ? 'Following' : 'Follow',
            onTap: () async {
              final list = Get.put(UpdatesController());
              final result = await list.followBack(widget.user.userid);
          
              if (result != null) {
              final action = result['action']; // followed / unfollowed
              final message = result['message'];
          
              setState(() {
              isFollowing = action == 'followed';
              widget.user.following = isFollowing;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('✅ $message')));
              } else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Something went wrong')));
          
              },
          ),
        ],
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
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          title,
          style: AppTextStyles.bodyMedium(Colors.white,).copyWith(fontWeight: FontWeight.w700)),
      ),
    );
  }
}




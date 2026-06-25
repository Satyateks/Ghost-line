

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghostline/core/theme/theme_route.dart';
import 'package:ghostline/core/utils/app_assets.dart';
import 'package:ghostline/features/update/controller/updates_controller.dart';




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
          height: 220,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) { return _SuggestionCard(user: users[index]); },
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
  void initState() {
    super.initState();
    isFollowing = widget.user.following ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 145,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xff1B1B1F)
            : Colors.white,
        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: isDark
              ? Colors.white10
              : Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [

          /// Profile Image
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: widget.user.profileImage != null && widget.user.profileImage!.isNotEmpty ? NetworkImage(widget.user.profileImage!) : const AssetImage(AppAssets.authBg) as ImageProvider,
            ),
          ),

          const SizedBox(height: 14),

          /// Name
          Text(
            widget.user.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:AppTextStyles.bodyMedium(isDark ? Colors.white :AppColors.lightTextSecondary).copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),

          /// Optional Designation
          Text(
            widget.user.designation ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:AppTextStyles.bodyMedium(isDark ? Colors.white :AppColors.lightTextSecondary)),

          const Spacer(),

          SizedBox(
            height:36,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final list = Get.find<UpdatesController>();
                final result = await list.followBack(widget.user.userid);

                if (result != null) {
                  final action = result['action'];
                  setState(()=> isFollowing = action == 'followed');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowing ? Colors.grey.shade700 : const Color(0xff3B82F6),
                elevation: 0,
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(11)),
              ),
              child: Text( isFollowing ? "Following" : "Follow", style: AppTextStyles.bodyMedium(Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}



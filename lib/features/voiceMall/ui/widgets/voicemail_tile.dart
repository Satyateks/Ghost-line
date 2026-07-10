import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../model/voicemail_model.dart';


class VoicemailTile extends StatelessWidget {
  final VoicemailModel voicemail;
  final VoidCallback onTap;

  const VoicemailTile({
    super.key,
    required this.voicemail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final secondaryColor = textColor.withOpacity(0.7);
    final dividerColor = Theme.of(context).dividerColor.withOpacity(0.3);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: dividerColor, width: 0.5)),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 20, backgroundImage: NetworkImage(voicemail.image)),
            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voicemail.name,
                    style:AppTextStyles.bodyLarge(textColor).copyWith(fontWeight: FontWeight.w600)
                  ),
                  const SizedBox(height: 2),
                  Text(
                    voicemail.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:AppTextStyles.bodyLarge(secondaryColor)
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(voicemail.date, style: AppTextStyles.bodyMedium(textColor)),
                const SizedBox(height: 3),
                Text(voicemail.duration,style: AppTextStyles.bodyMedium(textColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



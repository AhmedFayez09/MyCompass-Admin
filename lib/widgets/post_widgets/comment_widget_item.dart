import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/widgets/post_widgets/reply_widget.dart';

import '../../core/functions/chect_equal_list.dart';
import '../../models/comment_model.dart';
import '../../models/post_model.dart';

class CommentWidgetItem extends StatelessWidget {
  const CommentWidgetItem({
    super.key,
    required this.comment,
    required this.onReplay,
  });

  final CommentModelData comment;
  final VoidCallback onReplay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.grey.shade600,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  backgroundImage: kIsWeb
                      ? NetworkImage("assets/images/logo.png")
                      : AssetImage("assets/images/logo.png"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.author ?? 'Unknown User',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        comment.commentContent ?? 'NoComment'.tr(context),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        extractDate(comment.createdAt ?? 'JustNow'.tr(context)),
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: onReplay,
                      child: Text("reply".tr(context),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                    Text(
                      extractTime(comment.createdAt ?? 'JustNow'.tr(context)),
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (comment.reply?.isNotEmpty ?? false)
          ...comment.reply!.map<Widget>(
            (reply) {
              return ReplyWidget(reply: reply);
            },
          ),
      ],
    );
  }
}

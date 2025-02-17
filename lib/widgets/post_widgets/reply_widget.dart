
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';

import '../../core/functions/chect_equal_list.dart';
import '../../models/comment_model.dart';
import '../../models/post_model.dart';

class ReplyWidget extends StatelessWidget {
  const ReplyWidget({super.key, required this.reply});

  final CommentModelDataReply reply;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 10,
        right: 10,
      ),
      margin: const EdgeInsets.only(
        left: 40,
        top: 3,
        bottom: 3,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                reply.author ?? 'Unknown User',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    extractDate(reply.createdAt ?? 'JustNow'.tr(context)),
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  Text(
                    extractTime(reply.createdAt  ?? 'JustNow'.tr(context)),
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  reply.commentContent ?? 'NoResponse'.tr(context),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

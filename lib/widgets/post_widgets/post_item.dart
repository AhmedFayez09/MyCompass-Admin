import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/local_storage/cach_keys.dart';
import 'package:mycompass_admin_website/core/local_storage/cache_helper.dart';
import 'package:mycompass_admin_website/models/post_model.dart';

import '../../core/functions/chect_equal_list.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    this.onEditPress,
    this.onLikePress,
    this.onUnLikePress,
    this.onShowComments,
    required this.postTitle,
    required this.dataTime,
    required this.postContent,
    required this.liked,
    required this.unLiked,
    this.comments,
    this.likeCount,
    this.createdBy,
    this.unLikeCount,
    this.imageUrl,
  });

  final VoidCallback? onEditPress;
  final VoidCallback? onLikePress;
  final VoidCallback? onUnLikePress;
  final VoidCallback? onShowComments;
  final List<Comments>? comments;
  final String postTitle;
  final String dataTime;
  final String? imageUrl;
  final String postContent;
  final bool liked;
  final int? likeCount;
  final bool unLiked;
  final int? unLikeCount;
  final CreatedBy? createdBy;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      color: bgColor.withOpacity(.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    createdBy?.userName ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  extractDate(dataTime),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey),
                ),
                if (CacheHelper.getString(key: CacheKeys.userId) ==
                    createdBy?.sId)
                  InkWell(
                      onTap: onEditPress, child: const Icon(Icons.more_vert)),
              ],
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              postTitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: defaultPadding / 2),

            Text(
              postContent,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: defaultPadding / 2),
            if (imageUrl != null && imageUrl!.isNotEmpty)
              Image.network(
                imageUrl!,
                height: !kIsWeb ? 100 : 400,

              ),

            const SizedBox(height: defaultPadding / 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: onLikePress,
                          icon: Icon(
                            Iconsax.like_15,
                             color: liked ? Colors.red : Colors.grey,
                          ),
                        ),
                        if (likeCount != null) Text("$likeCount"),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onUnLikePress,
                          icon: Icon(
                            Iconsax.dislike,
                            color: unLiked ? Colors.red : Colors.grey,
                          ),
                        ),
                        if (unLikeCount != null) Text("$unLikeCount"),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: onShowComments,
                  child: const Text("تعليقات"),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding / 2),

            // عرض آخر تعليق فقط
            if (comments?.isNotEmpty ?? false) ...[
              const Divider(),
              Text(
                comments?.last.commentContent ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //
            //         const SizedBox(width: 8),
            //         Text(
            //           "أعجبني",
            //           style: Theme
            //               .of(context)
            //               .textTheme
            //               .bodyMedium!
            //               .copyWith(color: Colors.grey),
            //         ),
            //       ],
            //     ),
            //     TextButton(
            //       onPressed: onPressComment,
            //       child: const Text("تعليقات"),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: defaultPadding / 2),
            //
            // Row(
            //   children: [
            //     IconButton(
            //       onPressed: onUnLikePress,
            //       icon: Icon(
            //         Iconsax.dislike,
            //         color: unLiked ? Colors.red : Colors.grey,
            //       ),
            //     ),
            //     Text("$likeCount"),
            //
            //     const SizedBox(width: 8),
            //     Text(
            //       "لم يعجبنى",
            //       style: Theme
            //           .of(context)
            //           .textTheme
            //           .bodyMedium!
            //           .copyWith(color: Colors.grey),
            //     ),
            //   ],
            // ),
            // عرض آخر تعليق فقط
            // if (
            //     item.comments?.isNotEmpty ??
            //         false) ...[
            //   const Divider(),
            //   Text(
            //     item.comments?.last.commentContent ??
            //         '',
            //     style: Theme.of(context)
            //         .textTheme
            //         .bodyMedium,
            //   ),
            // ],
          ],
        ),
      ),
    );
  }
}

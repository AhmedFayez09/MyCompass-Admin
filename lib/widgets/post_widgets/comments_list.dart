import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/managers/post/post_cubit.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

import '../../core/constants.dart';
import '../../models/comment_model.dart';
import '../../models/post_model.dart';

class CommentsList extends StatefulWidget {
  CommentsList({
    super.key,
    // required this.comments,
    required this.pastId,
  });

  // final List<Comments> comments;
  final String pastId;

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  TextEditingController commentController = TextEditingController();
  bool addReplay = false;
  String? commentId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostCubit>().getComment(postId: widget.pastId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state is AddCommentSuccess) {
          commentController.clear();
          Navigator.pop(context);
          context.read<PostCubit>().getComment(postId: widget.pastId);
        }
        if (state is AddReplaySuccess) {
          addReplay = false;
          commentController.clear();
          Navigator.pop(context);
          context.read<PostCubit>().getAllPosts();
        }
      },
      builder: (context, state) {
        var cubit = context.read<PostCubit>();
        var comments = cubit.commentModel?.comments;
        return comments == null || state is GetCommentLoading
            ? const Center(child: CircularProgressIndicator())
            : Directionality(
                textDirection: TextDirection.rtl,
                child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    color: Colors.black.withOpacity(0.3),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "التعليقات",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: defaultPadding),
                          ...comments.map<Widget>((comment) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          comment.commentContent ??
                                              'لا يوجد تعليق',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            commentId = comment.sId;
                                            addReplay = true;
                                          });
                                        },
                                        child: const Text(
                                          "رد",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (comment.reply?.isNotEmpty ?? false)
                                    Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: TextButton(
                                        onPressed: () {
                                          showReplyDialog(
                                              reply: comment.reply ?? []);
                                          // comment.reply ?? []);
                                        },
                                        child: const Text("رؤية الردود"),
                                      ),
                                    ),
                                  const Divider(color: Colors.white),
                                ],
                              ),
                            );
                          }),
                          // const Divider(color: Colors.white),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                    hintText: addReplay == true
                                        ? "أضف رد..."
                                        : "أضف تعليقًا...",
                                    hintStyle:
                                        const TextStyle(color: Colors.white70),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (commentController.text.isEmpty) {
                                    SnackbarWidget.show(
                                        context, "لا يمكنك ترك الحقل فارغ");
                                  } else {
                                    if (addReplay == true) {
                                      cubit.addReplay(
                                        id: commentId ?? '',
                                        replay: commentController.text,
                                      );
                                    } else {
                                      cubit.addComment(
                                        postId: widget.pastId,
                                        comment: commentController.text,
                                      );
                                    }
                                  }
                                },
                                icon: state is AddCommentLoading ||
                                        state is AddReplayLoading
                                    ? const SizedBox(
                                        width: 10,
                                        height: 10,
                                        child: CircularProgressIndicator(
                                            color: Colors.white))
                                    : const Icon(Icons.send,
                                        color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  showReplyDialog({required List<CommentModelDataReply> reply}) {
    showDialog(
        context: context,
        builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  color: Colors.red.withOpacity(0.3),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const BackButton(),
                            Text(
                              "الردود",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        ...reply.map<Widget>((reply) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        reply.commentContent ?? 'لا يوجد رد',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                    // TextButton(
                                    //   onPressed: () => {},
                                    //   // _replyToComment(index, comment),
                                    //   child: const Text(
                                    //     "رد",
                                    //     style: TextStyle(color: Colors.blue),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                // if (comment.reply?.isNotEmpty ?? false)
                                //   Align(
                                //     alignment: AlignmentDirectional.topStart,
                                //     child: TextButton(
                                //       onPressed: () {},
                                //       child: const Text("رؤية الردود"),
                                //     ),
                                //   ),
                                const Divider(color: Colors.white),
                              ],
                            ),
                          );
                        }),
                        // const Divider(color: Colors.white),
                        // BlocConsumer<PostCubit, PostState>(
                        //   listener: (context, state) {
                        //     if (state is AddCommentSuccess) {
                        //       context.read<PostCubit>().getAllPosts();
                        //     }
                        //   },
                        //   builder: (context, state) {
                        //     var cubit = context.read<PostCubit>();
                        //     return Row(
                        //       children: [
                        //         Expanded(
                        //           child: TextField(
                        //             controller: commentController,
                        //             decoration: InputDecoration(
                        //               hintText: "أضف تعليقًا...",
                        //               hintStyle: const TextStyle(color: Colors.white70),
                        //               border: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(8),
                        //                 borderSide: const BorderSide(color: Colors.grey),
                        //               ),
                        //             ),
                        //             style: const TextStyle(color: Colors.white),
                        //           ),
                        //         ),
                        //         IconButton(
                        //           onPressed: () {
                        //             if (commentController.text.isEmpty) {
                        //               SnackbarWidget.show(
                        //                   context, "لا يمكنك ترك التعليق فارغ");
                        //             } else {
                        //               cubit.addComment(
                        //                 postId: widget.pastId,
                        //                 comment: commentController.text,
                        //               );
                        //             }
                        //           },
                        //           icon: const Icon(Icons.send, color: Colors.white),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/post/post_cubit.dart';
import 'package:mycompass_admin_website/widgets/post_widgets/add_comment_text_field.dart';
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
  FocusNode? focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();

    context.read<PostCubit>().getComment(postId: widget.pastId);
  }

  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      // debugPrint("Reached the end of the list. Last item: ${_items.last}");
      // Perform actions when the end of the list is reached
    }
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
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: defaultPadding,
                          right: defaultPadding,
                          bottom: defaultPadding * 3,
                          left: defaultPadding,
                        ),
                        color: Colors.grey.shade900,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "comments".tr(context),
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
                                                  'Nocomment'.tr(context),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                commentId = comment.sId;
                                                addReplay = true;
                                                _scrollController
                                                    .addListener(_onScroll);
                                              });
                                            },
                                            child:   Text(
                                              "reply".tr(context),
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (comment.reply?.isNotEmpty ?? false)
                                        Align(
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          child: TextButton(
                                            onPressed: () {
                                              showReplyDialog(
                                                  reply: comment.reply ?? []);
                                              // comment.reply ?? []);
                                            },
                                            child:   Text("ViewResponses".tr(
                                                context)),
                                          ),
                                        ),
                                      const Divider(color: Colors.white),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      AddCommentTextField(
                        controller: commentController,
                        addReplay: addReplay,
                        load: state is AddCommentLoading ||
                            state is AddReplayLoading,
                        onSend: () {
                          if (commentController.text.isEmpty) {
                            SnackbarWidget.show(
                                context, "Youcannotleavethefieldblank".tr(context));
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
                      ),
                    ],
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
                  color: Colors.blueGrey.withOpacity(0.3),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const BackButton(),
                            Text(
                              "Replies".tr(context),
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
                                        reply.commentContent ?? 'NoResponse'.tr(context),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.white),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

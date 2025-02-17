import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/controllers/menu_app_controller.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/functions/show_loading.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/core/responsive.dart';
import 'package:mycompass_admin_website/managers/post/post_cubit.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_add_new_post_screen.dart';
import 'package:mycompass_admin_website/widgets/custom_progress_hud.dart';
import 'package:mycompass_admin_website/widgets/post_widgets/comments_list.dart';
import 'package:mycompass_admin_website/widgets/post_widgets/post_item.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/post_model.dart';

class AdminSocialMediaScreen extends StatefulWidget {
  const AdminSocialMediaScreen({super.key});

  @override
  State<AdminSocialMediaScreen> createState() => _AdminSocialMediaScreenState();
}

class _AdminSocialMediaScreenState extends State<AdminSocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!Responsive.isDesktop(context))
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: context
                        .read<MenuAppController>()
                        .contractorOfficerControlMenu,
                  ),
                  Text(
                    "Socialcommunication".tr(context),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            if (!Responsive.isMobile(context))
              Text(
                "Socialcommunication".tr(context),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            const SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delete All"),
                IconButton(
                  onPressed: () => context.read<PostCubit>().deleteAllPosts(),
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Socialcommunication".tr(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    print('Create');

                    /// Todo: navigate to add new announcement screen
                    Navigator.pushNamed(context, RoutesName.adminAddNewPost);
                  },
                  icon: const Icon(Icons.add),
                  label: Text("Addapost".tr(context),
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            BlocConsumer<PostCubit, PostState>(
              listener: (context, state) {
                if (state is DeletePostSuccess || state is DeleteAllPostsSuccess) {
                  SnackbarWidget.show(context, "تم الحذف بنجاح");
                  context.read<PostCubit>().getAllPosts();
                } else if (state is DeletePostFailure) {
                  SnackbarWidget.show(context,
                      state.errorModel.message ?? 'Error in Deleting Post');
                } else if (state is AddPostLikeSuccess) {
                  context.read<PostCubit>().getAllPosts();
                  SnackbarWidget.show(context, "تم اضافة الاعجاب بنجاح");
                } else if (state is AddPostUnLikeSuccess) {
                  context.read<PostCubit>().getAllPosts();
                  SnackbarWidget.show(context, "تم اضافة عدم الاعجاب بنجاح");
                }
              },
              builder: (context, state) {
                var cubit = context.read<PostCubit>();
                var model = cubit.postsModel;
                var list = model?.result;
                return list == null ||
                        state is AddPostLikeLoading ||
                        state is AddPostUnLikeLoading ||
                        state is DeletePostLoading ||
                        state is GetAllPostsLoading ||
                        state is DeleteAllPostsLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          PostsModelData item = list[index];
                          return PostItem(
                            postTitle: item.postTitle ?? '',
                            postContent: item.postContent ?? '',
                            dataTime: item.createdAt ?? '',
                            imageUrl: item.postImage ?? '',
                            liked: item.like ?? false,
                            unLiked: item.unliked ?? false,
                            likeCount: (item.likes?.isEmpty ?? true)
                                ? null
                                : item.likes?.length,
                            unLikeCount: (item.unlikes?.isEmpty ?? true)
                                ? null
                                : item.unlikes?.length,
                            comments: item.comments,
                            createdBy: item.createdBy,
                            onLikePress: item.like == true
                                ? null
                                : () =>
                                    cubit.addPostLike(postId: item.sId ?? ''),
                            onUnLikePress: item.unliked == true
                                ? null
                                : () => cubit.addPostUnLike(
                                      postId: item.sId ?? '',
                                    ),
                            onShowComments: () => _showCommentsDialog(
                              comments: item.comments ?? [],
                              pastId: item.sId ?? '',
                            ),
                            onEditPress: () => Navigator.pushNamed(
                              context,
                              RoutesName.adminAddNewPost,
                              arguments: PostConstants(
                                item.postTitle ?? '',
                                item.postContent ?? '',
                                item.sId ?? '',
                                item.postImage,
                              ),
                            ),
                          );
                        },
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  void _showCommentsDialog({
    required List<Comments> comments,
    required String pastId,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CommentsList(
          pastId: pastId,
        );
      },
    );
  }
}

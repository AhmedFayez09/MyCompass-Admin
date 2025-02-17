import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/post/post_cubit.dart';
import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

import '../../../core/helper_functions/image_helper.dart';

class AdminAddNewPostScreen extends StatefulWidget {
  const AdminAddNewPostScreen({super.key});

  @override
  State<AdminAddNewPostScreen> createState() => _AdminAddNewPostScreenState();
}

class _AdminAddNewPostScreenState extends State<AdminAddNewPostScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  int i = 0;

  @override
  Widget build(BuildContext context) {
    i++;
    PostConstants? postConstants =
        ModalRoute.of(context)!.settings.arguments as PostConstants?;
    if (postConstants != null && i == 1) {
      titleController.text = postConstants.title;
      contentController.text = postConstants.content;
    }
     return Scaffold(
       appBar: AppBar(
         title: Text(
             postConstants == null ? 'Addnewpost'.tr(context) : "Editpost".tr(context),
             style: Theme.of(context).textTheme.bodyLarge!),
         leading: IconButton(
           icon: const Icon(Icons.arrow_back),
           onPressed: () {
             Navigator.pop(context); // Back to previous screen
           },
         ),
         backgroundColor: Colors.deepPurple,
         actions: [
           if (postConstants != null)
             BlocConsumer<PostCubit, PostState>(
               listener: (context, state) {
                 if (state is DeletePostSuccess) {
                   context.read<PostCubit>().getAllPosts();
                   Navigator.pop(context);
                 }
               },
               builder: (context, state) {
                 return IconButton(
                   onPressed: () {
                     context
                         .read<PostCubit>()
                         .deletePost(postId: postConstants.postId);
                   },
                   icon: Icon(
                     Icons.delete,
                     color: Colors.red,
                   ),
                 );
               },
             )
         ],
       ),
       body: SafeArea(
         child: SingleChildScrollView(
           padding: const EdgeInsets.all(defaultPadding),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const SizedBox(height: defaultPadding),
               Container(
                 width: double.infinity,
                 padding: const EdgeInsets.all(defaultPadding),
                 decoration: BoxDecoration(
                   color: secondaryColor,
                   borderRadius: BorderRadius.circular(defaultPadding / 2),
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                       Text(
                       'PostInformation'.tr(context),
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 20,
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                     const SizedBox(height: defaultPadding),

                     CustomTextField(
                       label: 'PostTitle'.tr(context),
                       hintText: 'PostTitle'.tr(context),
                       controller: titleController,
                     ),
                     const SizedBox(height: defaultPadding),

                     CustomTextField(
                       label: 'PostContent'.tr(context),
                       hintText:'PostContent'.tr(context),
                       controller: contentController,
                       isContent: true,
                     ),
                     const SizedBox(height: defaultPadding),
                     ElevatedButton(
                         onPressed: () {
                           if (kIsWeb) {
                             _addImageInWeb();
                           } else {
                             postConstants == null
                                 ? _pickImage()
                                 : _editingPickImage();
                           }
                         },
                         child:   Text("AddImage".tr(context))),
                     const SizedBox(height: defaultPadding),

                     // in Web Case
                     if (kIsWeb)
                       SizedBox(
                         child: selectedImageInWeb == null
                             ? const SizedBox.shrink()
                             : selectedImageInWeb is Uint8List
                                 ? Image.memory(
                                     selectedImageInWeb!,
                                     fit: BoxFit.fill,
                                     width: MediaQuery.of(context).size.width *
                                         0.5,
                                     height:
                                         MediaQuery.of(context).size.width *
                                             0.3,
                                   )
                                 : Image.file(
                                     File(selectedImageInWeb as String),
                                     fit: BoxFit.cover,
                                     width: MediaQuery.of(context).size.width *
                                         0.5,
                                     height:
                                         MediaQuery.of(context).size.width *
                                             0.3,
                                   ),
                       ),
                     // in Mobile Case
                     if (!kIsWeb)
                       postConstants?.postImageUrl == null
                           ? _selectedImage == null
                               ? const SizedBox.shrink()
                               : SizedBox(
                                   height: 100,
                                   child: Image.file(
                                     _selectedImage!,
                                     height: 200,
                                   ),
                                 )
                           : editingSelectedImage == null
                               ? SizedBox(
                                   height: 200,
                                   child: Image.network(
                                     postConstants?.postImageUrl ?? '',
                                     height: 200,
                                   ),
                                 )
                               : SizedBox(
                                   height: 100,
                                   child: Image.file(
                                     editingSelectedImage!,
                                     height: 200,
                                   ),
                                 ),

                     const SizedBox(height: defaultPadding),

                     // Type dropdown
                     // Submit button
                     BlocConsumer<PostCubit, PostState>(
                       listener: (context, state) {
                         if (state is AddPostSuccess) {
                           SnackbarWidget.show(
                               context, "Postaddedsuccessfully".tr(context));
                           context.read<PostCubit>().getAllPosts();
                           Navigator.pop(context);
                         } else if (state is AddPostFailure) {
                           SnackbarWidget.show(
                               context,
                               state.errorModel.message ??
                                   'ErrorinCreatingPost'.tr(context));
                         } else if (state is UpdatePostSuccess) {
                           SnackbarWidget.show(
                               context, "Posthasbeensuccessfullymodified".tr(context));
                           context.read<PostCubit>().getAllPosts();
                           Navigator.pop(context);
                         } else if (state is UpdatePostFailure) {
                           SnackbarWidget.show(
                               context,
                               state.errorModel.message ??
                                   'ErrorInUpdatingPost'.tr(context));
                         }
                       },
                       builder: (context, state) {
                         return ElevatedButton(
                           onPressed: () {
                             if (postConstants == null) {
                               context.read<PostCubit>().addPost(
                                   title: titleController.text,
                                   description: contentController.text,
                                   image: _selectedImage,
                                   webImage: selectedImageInWeb);
                             } else {
                               context.read<PostCubit>().updatePost(
                                     postId: postConstants.postId,
                                     title: titleController.text,
                                     description: contentController.text,
                                     image: editingSelectedImage,
                                   );
                             }
                           },
                           child: state is AddPostLoading ||
                                   state is UpdatePostLoading
                               ? const SizedBox(
                                   height: 15,
                                   width: 15,
                                   child: CircularProgressIndicator())
                               : Text(postConstants == null
                                   ? 'Addnewpost'.tr(context)
                                   : "Editpost".tr(context)),
                         );
                       },
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
       ),
     );
  }

  File? _selectedImage;
  File? editingSelectedImage;

  void _pickImage() async {
    final ImagePickerService imagePickerService = ImagePickerService();
    print("in pick $_selectedImage");
    File? image = await imagePickerService.pickImage(context);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
      print("in pick After $_selectedImage");
    }
  }

  void _editingPickImage() async {
    final ImagePickerService imagePickerService = ImagePickerService();
    print("in pick $_selectedImage");
    File? image = await imagePickerService.pickImage(context);
    if (image != null) {
      setState(() {
        editingSelectedImage = image;
      });
      print("in pick After $_selectedImage");
    }
  }

  // in Web
  Uint8List? selectedImageInWeb;

  void _addImageInWeb() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: kIsWeb, // Important for web to get bytes
    );
    if (result != null) {
      // Web: Use bytes directly
      setState(() {
        // List<Uint8List?> list = result.files.map((file) => file.bytes).toList();
        // selectedImages.addAll(list);
        Uint8List? imageBytes =
            result.files.single.bytes; // Get the selected image
        selectedImageInWeb = imageBytes; // Store only one image
      });
    }
  }
}

class PostConstants {
  final String title;
  final String content;
  final String? postImageUrl;
  final String postId;

  PostConstants(
    this.title,
    this.content,
    this.postId,
    this.postImageUrl,
  );
}

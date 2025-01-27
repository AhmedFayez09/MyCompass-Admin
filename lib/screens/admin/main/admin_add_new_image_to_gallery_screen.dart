import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/responsive.dart';
import 'package:mycompass_admin_website/managers/gallery/gallery_cubit.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_dashboard_header.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart'; // To detect web platform

class AddNewImageToGalleryScreen extends StatefulWidget {
  const AddNewImageToGalleryScreen({super.key});

  @override
  State<AddNewImageToGalleryScreen> createState() =>
      _AddNewImageToGalleryScreenState();
}

class _AddNewImageToGalleryScreenState
    extends State<AddNewImageToGalleryScreen> {
  // List<File> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  // List<File> selectedImages = [];
  List<SelectedImage> selectedImages = [];

  List<Uint8List?> selectedImagesBytes = [];
  List<String> selectedImagesFiles = [];
  final titleC = TextEditingController();
  final descriptionC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'إضافة صور جديدة',
            style: Theme.of(context).textTheme.bodyLarge!,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Back to previous screen
            },
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "إضافة الصور",
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
                      onPressed: _addImage,
                      icon: const Icon(Icons.add),
                      label: Text(
                        "إضافة الصور",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  label: "عنوان الصورة",
                  hintText: "عنوان الصورة",
                  controller: titleC,
                ),
                const SizedBox(height: defaultPadding),
                CustomTextField(
                  label: "التفاصيل",
                  hintText: "التفاصيل",
                  controller: descriptionC,
                ),
                const SizedBox(height: defaultPadding),
                Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الصور المضافة",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: defaultPadding),
                      selectedImages.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Responsive.isDesktop(context)
                                    ? 4
                                    : Responsive.isTablet(context)
                                        ? 3
                                        : 2,
                                crossAxisSpacing: defaultPadding,
                                mainAxisSpacing: defaultPadding,
                                childAspectRatio: 1,
                              ),
                              itemCount: selectedImages.length,
                              itemBuilder: (context, index) {
                                final image = selectedImages[index];
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: kIsWeb == true
                                              ? Image.memory(
                                                  image.bytes!,
                                                  fit: BoxFit.fill,
                                                )
                                              : image.path != null
                                                  ? Image.file(
                                                      File(image.path!),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : const SizedBox(
                                                      child: Center(
                                                        child: Text(
                                                            'No valid file path'),
                                                      ),
                                                    )),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: IconButton(
                                        onPressed: () => _removeImage(index),
                                        icon: const Icon(
                                          Iconsax.box_remove,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                "لم يتم إضافة أي صور بعد",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding),
                BlocConsumer<GalleryCubit, GalleryState>(
                  listener: (context, state) {
                    if (state is AddGallerySuccess) {
                      context.read<GalleryCubit>().getAllGallery();
                      Navigator.pop(context);
                      SnackbarWidget.show(context, "تمت العملية بنجاح");
                    } else if (state is AddGalleryFailure) {
                      SnackbarWidget.show(
                          context, state.errorModel.message ?? '');
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (kIsWeb) {
                          if (selectedImagesBytes != [] ||
                              selectedImagesBytes.isNotEmpty) {
                            print("in onTap : ${selectedImagesBytes.length}");
                            context.read<GalleryCubit>().addGallery(
                                galleryTitle: titleC.text,
                                galleryDescription: descriptionC.text,
                                webImages: selectedImagesBytes);
                          }
                        } else {
                          if (selectedImagesFiles == [] ||
                              selectedImagesFiles.isEmpty) {
                            SnackbarWidget.show(context, "يجب أن تضيف أي صورة");
                          } else {
                            print("Call Function");
                            context.read<GalleryCubit>().addGallery(
                                  galleryTitle: titleC.text,
                                  galleryDescription: descriptionC.text,
                                  galleryImages: selectedImagesFiles,
                                );
                          }
                        }
                      },
                      child: state is AddGalleryLoading
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(),
                            )
                          : const Text("حفظ"),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _addImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: true,
  //     withData: kIsWeb, // Important for web to get bytes
  //   );
  //
  //   if (result != null) {
  //     if (kIsWeb) {
  //       // Web: Use bytes directly
  //       setState(() {
  //         selectedImages
  //             .addAll(result.files.map((file) => file.bytes).toList());
  //       });
  //     } else {
  //       // Mobile/Desktop: Use file paths
  //       setState(() {
  //         selectedImages.addAll(
  //             result.paths.where((path) => path != null).cast<String>());
  //       });
  //     }
  //   }
  // }
  void _addImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      withData: kIsWeb, // Important for web to get bytes
    );

    if (result != null) {
      setState(() {
        if (kIsWeb) {
          // Web: Use bytes directly
          List<Uint8List?> list =
              result.files.map((file) => file.bytes).toList();
          selectedImagesBytes.addAll(list);
          List<SelectedImage> listOfBytes =
              list.map((e) => SelectedImage(bytes: e)).toList();
          selectedImages.addAll(listOfBytes);

          print("selectedImages ${selectedImages.length}");
        } else {
          // Mobile/Desktop: Use file paths
          List<String> list =
              result.paths.where((e) => e != null).map((e) => e ?? '').toList();
          selectedImagesFiles.addAll(list);

          selectedImages.addAll(result.paths
              .where((path) => path != null)
              .map((path) => SelectedImage(path: path)));
        }
      });
    }
  }

  void _removeImage(int index) {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد من حذف الصورة؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog on 'No'
              },
              child: const Text('لا'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedImages.removeAt(index); // Remove image from list
                });
                Navigator.pop(context); // Close dialog on 'Yes'
                HapticFeedback.mediumImpact(); // Provide haptic feedback
              },
              child: const Text('نعم'),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedImage {
  final Uint8List? bytes; // For web
  final String? path; // For mobile/desktop

  SelectedImage({this.bytes, this.path});
}

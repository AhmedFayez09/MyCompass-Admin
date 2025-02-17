import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/helper_functions/image_helper.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/managers/announcement/announcement_cubit.dart';
import 'package:mycompass_admin_website/screens/admin/main/show%20_all_announcements_screen.dart';
import 'package:mycompass_admin_website/widgets/custom_drop_down_field.dart';
import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

class AddNewAnnouncementScreen extends StatefulWidget {
  const AddNewAnnouncementScreen({super.key});

  @override
  AddNewAnnouncementScreenState createState() =>
      AddNewAnnouncementScreenState();
}

class AddNewAnnouncementScreenState extends State<AddNewAnnouncementScreen> {
  // Controllers for text fields
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  // Dropdown selections
  String selectedType = 'Information';
  String selectedPriority = 'Normal';

  // Dropdown options
  final List<String> announcementTypes = [
    'Information',
    'Event',
    'Maintenance'
  ];
  final List<String> priorities = ['Normal', 'High'];
  String? editingType;
  String? editingPriority;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    i++;
    Announcement? announcement =
        ModalRoute.of(context)!.settings.arguments as Announcement?;
    if (announcement != null && i == 1) {
      titleController.text = announcement.title;
      contentController.text = announcement.content;
      selectedType = announcement.type;
      selectedPriority = announcement.priority;
      _selectedImage = File(announcement.imageUrl ?? '');
    }
    print("index $i");

    return Scaffold(
      appBar: AppBar(
        title: Text(
            announcement == null
                ? 'Addnewad'.tr(context)
                : "EditAd".tr(context),
            style: Theme.of(context).textTheme.bodyLarge!),
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
                      'AdvertisingInformation'.tr(context),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),

                    CustomTextField(
                      label: 'AdTitle'.tr(context),
                      hintText:'AdTitle'.tr(context),
                      controller: titleController,
                    ),
                    const SizedBox(height: defaultPadding),

                    CustomTextField(
                      label: 'Adcontent'.tr(context),
                      hintText:  'Adcontent'.tr(context),
                      controller: contentController,
                      isContent: true,
                    ),
                    const SizedBox(height: defaultPadding),

                    // Type dropdown
                    DropdownField(
                      label: 'AdType'.tr(context),
                      items: announcementTypes, // Example items
                      selectedValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                          if (announcement != null) {
                            editingType = value;
                          }
                        });
                      },
                    ),

                    const SizedBox(height: defaultPadding),

                    DropdownField(
                      label: 'Classification'.tr(context),
                      items: priorities, // Example items
                      selectedValue: selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          selectedPriority = value;
                          if (announcement != null) {
                            editingPriority = value;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: defaultPadding),
                    ElevatedButton(
                        onPressed: () {
                          if (kIsWeb) {
                            _addImageInWeb();
                          } else {
                            announcement == null
                                ? _pickImage()
                                : _editingPickImage();
                          }
                        },
                        child:   Text("Addimage".tr(context))),
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
                      announcement?.imageUrl == null
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
                                    announcement?.imageUrl ?? '',
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

                    // Submit button
                    BlocConsumer<AnnouncementCubit, AnnouncementState>(
                      listener: (context, state) {
                        var cubit = context.read<AnnouncementCubit>();

                        if (state is AddNewAnnouncementSuccess) {
                          Navigator.pop(context);
                          SnackbarWidget.show(context, "Addedsuccessfully".tr(context));
                        } else if (state is AddNewAnnouncementFailure) {
                          SnackbarWidget.show(context,
                              state.errorModel.message ?? 'Unknownerror'.tr(context));
                        } else if (state is UpdateAnnouncementSuccess) {
                          cubit.getAllAnnouncements();
                          Navigator.pop(context);
                          SnackbarWidget.show(context, "ModifiedSuccessfully".tr(context));
                        } else if (state is UpdateAnnouncementFailure) {
                          SnackbarWidget.show(context,
                              state.errorModel.message ?? 'Unknownerror'.tr(context));
                        }
                      },
                      builder: (context, state) {
                        var cubit = context.read<AnnouncementCubit>();
                        return ElevatedButton(
                          onPressed: () {
                            if (kIsWeb) {
                              announcement == null
                                  ? cubit.addNewAnnouncement(
                                      title: titleController.text,
                                      description: contentController.text,
                                      priority: selectedPriority,
                                      type: selectedType,
                                      webImage:
                                          selectedImageInWeb, // Pass Uint8List here for web
                                    )
                                  : cubit.updateAnnouncement(
                                      id: announcement.id ?? '',
                                      title: titleController.text,
                                      description: contentController.text,
                                      priority:
                                          editingPriority ?? selectedPriority,
                                      type: editingType ?? selectedType,
                                      webImage: selectedImageInWeb,
                                      // image: editingSelectedImage == null
                                      //     ? null
                                      //     : _selectedImage,
                                    );
                            } else {
                              announcement == null
                                  ? cubit.addNewAnnouncement(
                                      title: titleController.text,
                                      description: contentController.text,
                                      priority: selectedPriority,
                                      type: selectedType,
                                      image: _selectedImage)
                                  :
                                  // print(contentController.text);
                                  cubit.updateAnnouncement(
                                      id: announcement.id ?? '',
                                      title: titleController.text,
                                      description: contentController.text,
                                      priority: selectedPriority,
                                      type: selectedType,
                                      image: editingSelectedImage,
                                    );
                            }
                          },
                          child: state is AddNewAnnouncementLoading ||
                                  state is UpdateAnnouncementLoading
                              ? const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator())
                              : Text(announcement == null
                                  ? 'Addnewad'.tr(context)
                                  : "EditAd".tr(context)),
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

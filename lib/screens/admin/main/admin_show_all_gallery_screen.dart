import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/functions/chect_equal_list.dart';
import 'package:mycompass_admin_website/core/responsive.dart';
import 'package:mycompass_admin_website/managers/gallery/gallery_cubit.dart';
import 'package:mycompass_admin_website/models/gallery_model.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_dashboard_header.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

class AdminShowAllGalleryScreen extends StatefulWidget {
  const AdminShowAllGalleryScreen({super.key});

  @override
  State<AdminShowAllGalleryScreen> createState() =>
      _AdminShowAllGalleryScreenState();
}

class _AdminShowAllGalleryScreenState extends State<AdminShowAllGalleryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GalleryCubit>().getAllGallery();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // Added Scaffold for better structure
        body: SafeArea(
          // Added SafeArea to avoid overlaps
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                const AdminDashboardHeader(),
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "جميع الصور",
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
                        Navigator.pushNamed(
                            context, RoutesName.addNewImageToGallery);
                      },
                      icon: const Icon(Icons.add),
                      label: Text("إضافة الصور",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
                // const SizedBox(height: defaultPadding),
                BlocConsumer<GalleryCubit, GalleryState>(
                  listener: (context, state) {
                    if (state is DeleteAllGallerySuccess) {
                      context.read<GalleryCubit>().getAllGallery();
                      SnackbarWidget.show(context, "تم الحذف بنجاح");
                    }
                  },
                  builder: (context, state) {
                    return Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: TextButton(
                          onPressed: () {
                            context.read<GalleryCubit>().deleteAllGallery();
                          },
                          child: Text("مسح اكل")),
                    );
                  },
                ),
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
                        "جميع الصور",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: defaultPadding),
                      BlocConsumer<GalleryCubit, GalleryState>(
                        listener: (context, state) {
                          if (state is DeleteGallerySuccess) {
                            context.read<GalleryCubit>().getAllGallery();
                            SnackbarWidget.show(context, "تم الحذف بنجاح");
                          } else if (state is DeleteGalleryFailure) {
                            SnackbarWidget.show(context, "حدث خطأ ما");
                          }
                        },
                        builder: (context, state) {
                          GalleryCubit cubit = context.read<GalleryCubit>();
                          List<GalleryModelData>? list =
                              cubit.galleryModel?.result;
                          return list == null
                              ? const Center(child: CircularProgressIndicator())
                              : list.isEmpty
                                  ? const SizedBox.shrink()
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      // Important for nested scrolling
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      // Disable GridView scrolling
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            Responsive.isDesktop(context)
                                                ? 4
                                                : Responsive.isTablet(context)
                                                    ? 3
                                                    : 2,
                                        // Adjust count based on screen size
                                        crossAxisSpacing: defaultPadding,
                                        mainAxisSpacing: defaultPadding,
                                        childAspectRatio: kIsWeb
                                            ? 1.2
                                            : 0.7, // Make images square (or adjust as needed)
                                      ),
                                      itemCount: list.length,
                                      // images.length,
                                      itemBuilder: (context, index) {
                                        GalleryModelData item = list[index];
                                        return AllGalleryItem(
                                          title: item.galleryTitle,
                                          description: item.galleryDescription,
                                          image: item.galleryImages?.first
                                                  .imageUrl ??
                                              '',
                                          onTap: () => showListImage(item),
                                          onTapDelete: () =>
                                              cubit.deleteGallery(
                                            id: item.sId ?? '',
                                          ),
                                          onTapEdit: () => Navigator.pushNamed(
                                              context,
                                              RoutesName
                                                  .adminEditImageToGalleryScreen,
                                              arguments: GalleryData(
                                                id: item.sId ?? '',
                                                title: item.galleryTitle,
                                                description:
                                                    item.galleryDescription,
                                                imageUrl: item.galleryImages
                                                    ?.map(
                                                        (e) => e.imageUrl ?? '')
                                                    .toList(),
                                              )),
                                        );
                                      },
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
      ),
    );
  }

  showListImage(GalleryModelData item) {
    showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return Dialog(
            child: SizedBox(
          height: size.height * 0.8,
          width: size.width * 0.8,
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                kIsWeb ? const SizedBox(height: 15) : const SizedBox(width: 15),
            scrollDirection: Axis.vertical,
            itemCount: item.galleryImages?.length ?? 0,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              var image = item.galleryImages?[index];
              return InkWell(
                onTap: () {
                  zoomImage(context, image?.imageUrl ?? '');
                },
                child: Image.network(
                  image?.imageUrl ?? '',
                  fit: BoxFit.contain,
                  width: size.width * 0.3,
                  height: size.height * 0.45,
                ),
              );
            },
          ),
        ));
      },
    );
  }
}

class AllGalleryItem extends StatelessWidget {
  const AllGalleryItem({
    super.key,
    this.onTap,
    required this.image,
    this.onTapDelete,
    this.onTapEdit,
    this.title,
    this.description,
  });

  final VoidCallback? onTap;
  final String image;
  final VoidCallback? onTapDelete;
  final VoidCallback? onTapEdit;
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  title ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 150,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              onPressed: onTapDelete,
              // () => _removeItem(index),
              icon: const Icon(
                Iconsax.box_remove,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            child: IconButton(
              onPressed: onTapEdit,
              // () => _removeItem(index),
              icon: const Icon(
                Iconsax.edit,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GalleryData {
  final String? id;
  final String? title;
  final String? description;
  final List<String>? imageUrl;

  GalleryData({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

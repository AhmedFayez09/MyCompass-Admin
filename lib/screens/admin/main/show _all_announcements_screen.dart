import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/managers/announcement/announcement_cubit.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';

class Announcement {
  final String? id;
  final String title;
  final String content;
  final String type;
  final String priority;
  final String? imageUrl;

  Announcement(
      {required this.title,
      this.id,
      required this.content,
      required this.type,
      this.imageUrl,
      required this.priority});
}

class ShowAllAnnouncementsScreen extends StatelessWidget {
  const ShowAllAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AnnouncementCubit, AnnouncementState>(
        listener: (context, state) {
          var cubit = context.read<AnnouncementCubit>();

          if (state is DeleteAllAnnouncementSuccess ||
              state is DeleteAnnouncementSuccess) {
            cubit.getAllAnnouncements();
          }
        },
        builder: (context, state) {
          var cubit = context.read<AnnouncementCubit>();
          var model = cubit.announcementModel;
          var list = model?.result;
          return Scaffold(
            appBar: AppBar(
              title: Text('عرض جميع الإعلانات',
                  style: Theme.of(context).textTheme.bodyLarge!),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  icon: const Text("مسح الكل"),
                  onPressed: () {
                    context.read<AnnouncementCubit>().deleteAllAnnouncements();
                  },
                ),
              ],
              backgroundColor: Colors.deepPurple,
            ),
            body: SafeArea(
              child: list == null ||
                      state is DeleteAnnouncementLoading ||
                      state is GetAllAnnouncementLoading
                  ? const Center(child: CircularProgressIndicator())
                  : list.isEmpty
                      ? const Center(child: Text('لا يوجد اعلانات'))
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            var item = list[index];
                            return AnnouncementCard(
                              announcement: Announcement(
                                  title: item.announcementTitle ?? '',
                                  content: item.announcementDesc ?? '',
                                  type: item.type ?? '',
                                  priority: item.priority ?? '',
                                  imageUrl: item.announcementAttach),
                              onPressedEditAnnouncement: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.addNewAnnouncement,
                                  arguments: Announcement(
                                      id: item.sId ?? '',
                                      title: item.announcementTitle ?? '',
                                      content: item.announcementDesc ?? '',
                                      type: item.type ?? '',
                                      priority: item.priority ?? '',
                                      imageUrl: item.announcementAttach),
                                );
                              },
                              onPressedDeleteAnnouncement: () =>
                                  cubit.deleteAnnouncement(
                                id: item.sId ?? '',
                              ),
                            );
                          },
                        ),
            ),
          );
        },
      ),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback onPressedDeleteAnnouncement;
  final VoidCallback onPressedEditAnnouncement;

  const AnnouncementCard({
    super.key,
    required this.announcement,
    required this.onPressedDeleteAnnouncement,
    required this.onPressedEditAnnouncement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: defaultPadding),
      // Spacing between cards
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(defaultPadding / 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                announcement.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (announcement.imageUrl != null)
                if (kIsWeb)
                  SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.network(
                      announcement.imageUrl ?? '',
                      fit: BoxFit.contain,
                    ),
                  ),
              Column(
                children: [
                  IconButton(
                    onPressed: onPressedDeleteAnnouncement,
                    icon: const Icon(
                      Iconsax.message_remove,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: defaultPadding * 0.5),
                  IconButton(
                      onPressed: onPressedEditAnnouncement,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(height: defaultPadding / 2),
          Text(
            announcement.content,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: defaultPadding / 2),
          Text(
            'نوع الإعلان: ${announcement.type}',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: defaultPadding / 2),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2, vertical: defaultPadding / 4),
            decoration: BoxDecoration(
              color: announcement.priority == 'High'
                  ? Colors.red
                  : announcement.priority == 'Low'
                      ? bgColor.withOpacity(.8)
                      : Colors.yellow.shade400,
              borderRadius: BorderRadius.circular(defaultPadding / 2),
            ),
            child: Text(
              'التصنيف: ${announcement.priority}',
              style: TextStyle(
                  color: announcement.priority == 'Normal'
                      ? Colors.black
                      : Colors.white),
            ),
          ),
          const SizedBox(height: defaultPadding),
          if (!kIsWeb)
            announcement.imageUrl == null
                ? const SizedBox.shrink()
                : SizedBox(
                    height: 120,
                    child: Image.network(
                      announcement.imageUrl ?? "",
                      fit: BoxFit.fitWidth,
                    ),
                  )
        ],
      ),
    );
  }
}

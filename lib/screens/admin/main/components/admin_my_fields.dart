import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/core/responsive.dart';
import 'package:mycompass_admin_website/managers/announcement/announcement_cubit.dart';
import 'package:mycompass_admin_website/models/my_files.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';
import 'admin_file_info_card.dart';

class MyFamilies extends StatelessWidget {
  const MyFamilies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "AllFamilies".tr(context),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Responsive(
              mobile: _size.width < 450
                  ? ButtonsChoicesMobile()
                  : ButtonsChoicesTabletAndDesktop(),
              tablet: _size.width < 850
                  ? ButtonsChoicesTabletAndDesktop()
                  : ButtonsChoicesTabletAndDesktop(),
              desktop: _size.width < 1400
                  ? ButtonsChoicesTabletAndDesktop()
                  : ButtonsChoicesTabletAndDesktop(),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        // Responsive(
        //   mobile: FileInfoCardGridView(
        //     crossAxisCount: _size.width < 650 ? 2 : 4,
        //     childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
        //   ),
        //   tablet: const FileInfoCardGridView(),
        //   desktop: FileInfoCardGridView(
        //     childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
        //   ),
        // ),
      ],
    );
  }
}

class ButtonsChoicesTabletAndDesktop extends StatelessWidget {
  const ButtonsChoicesTabletAndDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            ),
          ),
          onPressed: () {
            print('Create');

            /// Todo: navigate to add new announcement screen
            Navigator.pushNamed(context, RoutesName.addNewAnnouncement);
          },
          icon: const Icon(Icons.add),
          label: Text("Addads".tr(context),
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        const SizedBox(width: defaultPadding),
        BlocListener<AnnouncementCubit, AnnouncementState>(
          listener: (context, state) {
            // if (state is GetAllAnnouncementSuccess) {
            //   Navigator.pushNamed(context, RoutesName.showAllAnnouncements);
            // } else if (state is GetAllAnnouncementFailure) {
            //   SnackbarWidget.show(context, "حدث خطا ما");
            // }
          },
          child: ElevatedButton.icon(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
                vertical:
                    defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
              ),
            ),
            onPressed: () {
              print('Create');
              Navigator.pushNamed(context, RoutesName.showAllAnnouncements);

              context.read<AnnouncementCubit>().getAllAnnouncements();

              /// Todo: navigate to add new announcement screen
            },
            icon: const Icon(Icons.add),
            label: Text("ViewAllAds".tr(context),
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
        const SizedBox(width: defaultPadding),
        ElevatedButton.icon(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            ),
          ),
          onPressed: () {
            print('Create');

            Navigator.pushNamed(context, RoutesName.addNewFamily);
          },
          icon: const Icon(Icons.add),
          label: Text("Addanewfamily".tr(context),
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}

class ButtonsChoicesMobile extends StatelessWidget {
  const ButtonsChoicesMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            ),
          ),
          onPressed: () {
            print('Create');

            Navigator.pushNamed(context, RoutesName.addNewFamily);
          },
          icon: const Icon(Icons.add),
          label: Text("Addanewfamily".tr(context),
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        const SizedBox(height: defaultPadding),
        BlocBuilder<AnnouncementCubit, AnnouncementState>(
          builder: (context, state) {
            return ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                print('Create');
                context.read<AnnouncementCubit>().getAllAnnouncements();
                Navigator.pushNamed(context, RoutesName.showAllAnnouncements);

                /// Todo: navigate to add new announcement screen
                ///
              },
              icon: const Icon(Icons.add),
              label: Text("ViewAllAds".tr(context),
                  style: Theme.of(context).textTheme.bodyMedium),
            );
          },
        ),
        const SizedBox(height: defaultPadding),
        ElevatedButton.icon(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            ),
          ),
          onPressed: () {
            print('Create');
            Navigator.pushNamed(context, RoutesName.addNewAnnouncement);

            /// Todo: navigate to add new announcement screen
          },
          icon: const Icon(Icons.add),
          label: Text("Addads".tr(context),
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}

// class FileInfoCardGridView extends StatelessWidget {
//   const FileInfoCardGridView({
//     super.key,
//     this.crossAxisCount = 4,
//     this.childAspectRatio = 1,
//   });
//
//   final int crossAxisCount;
//   final double childAspectRatio;
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: demoMyFiles.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         crossAxisSpacing: defaultPadding,
//         mainAxisSpacing: defaultPadding,
//         childAspectRatio: childAspectRatio,
//       ),
//       itemBuilder: (context, index) =>
//           AdminFileInfoCard(info: demoMyFiles[index]),
//     );
//   }
// }

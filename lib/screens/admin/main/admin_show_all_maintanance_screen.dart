import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/maintenance/maintenance_cubit.dart';
import 'package:mycompass_admin_website/models/maintanance_model.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_dashboard_header.dart';

import '../../../core/functions/chect_equal_list.dart';

class AdminShowAllMaintananceScreen extends StatefulWidget {
  const AdminShowAllMaintananceScreen({super.key});

  @override
  State<AdminShowAllMaintananceScreen> createState() =>
      _AdminShowAllMaintananceScreenState();
}

class _AdminShowAllMaintananceScreenState
    extends State<AdminShowAllMaintananceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const AdminDashboardHeader(),
              const SizedBox(height: defaultPadding),
              Text(
                "AllFixes".tr(context),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: defaultPadding),
              Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: BlocConsumer<MaintenanceCubit, MaintenanceState>(
                    listener: (context, state) {
                      if (state is DeleteMaintenanceSuccess) {
                        context.read<MaintenanceCubit>().getAllMaintenances();
                      }
                    },
                    builder: (context, state) {
                      var model =
                          context.read<MaintenanceCubit>().maintenanceModel;
                      var list = model?.result;
                      return list == null ||
                              state is DeleteMaintenanceLoading ||
                              state is DeleteMaintenanceSuccess
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              children: list
                                  .map((e) => MaintenanceItem(
                                        date: e.createdAt ?? '',
                                        title: e.categoryName ?? '',
                                        description:
                                            e.maintenanceDescription ?? '',
                                        statusTags: [
                                          MaintenanceTag(
                                            text: e.priority ?? '',
                                            color: e.priority == "High"
                                                ? Colors.redAccent
                                                : e.priority == "Medium"
                                                    ? Colors.yellowAccent
                                                    : Colors.orange,
                                          ),
                                          MaintenanceTag(
                                              text:
                                                  e.maintenanceOrderStatuses ??
                                                      '',
                                              color: e.maintenanceOrderStatuses ==
                                                      "Accepted"
                                                  ? Colors.lightBlueAccent
                                                  : e.maintenanceOrderStatuses ==
                                                          "In-Progress"
                                                      ? Colors.orangeAccent
                                                      : e.maintenanceOrderStatuses ==
                                                              "Completed"
                                                          ? Colors.greenAccent
                                                          : e.maintenanceOrderStatuses ==
                                                                  "Cancelled"
                                                              ? Colors
                                                                  .redAccent
                                                              : Colors
                                                                  .yellowAccent),
                                        ],
                                        onDelete: () {
                                          context
                                              .read<MaintenanceCubit>()
                                              .deleteMaintenances(
                                                  e.sId ?? '');
                                        },
                                        onUpdatePriority: () {},
                                        onUpdateStatus: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) =>
                                                StatusUpdateDialog(
                                              item: e,
                                            ),
                                          );
                                        },
                                        feedbackComment: e.feedbackComment,
                                      ))
                                  .toList(),
                            );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// Dialog for updating status
class StatusUpdateDialog extends StatelessWidget {
  final MaintenanceModelData item;

  StatusUpdateDialog({super.key, required this.item});

  final pendingC = TextEditingController();
  final acceptedC = TextEditingController();
  final inProgressC = TextEditingController();
  final completedC = TextEditingController();
  final cancelledC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaintenanceCubit, MaintenanceState>(
      listener: (context, state) {
        if (state is ChangeMaintenanceStateSuccess) {
          context.read<MaintenanceCubit>().getAllMaintenances();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<MaintenanceCubit>();
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //[Pending, Accepted, In-Progress, Completed, Cancelled]
              statusItem(
                context: context,
                title: "Pending".tr(context),
                controller: pendingC,
                onSend: () => cubit.changeStatus(
                  id: item.sId ?? '',
                  feedbackComment: pendingC.text,
                  maintenanceStatus: "Pending",
                ),
              ),
              statusItem(
                context: context,
                title: "Accepted".tr(context),
                controller: acceptedC,
                onSend: () => cubit.changeStatus(
                  id: item.sId ?? '',
                  feedbackComment: acceptedC.text,
                  maintenanceStatus: "Accepted",
                ),
              ),
              statusItem(
                context: context,
                title: "InProgress".tr(context),
                controller: inProgressC,
                onSend: () => cubit.changeStatus(
                  id: item.sId ?? '',
                  feedbackComment: inProgressC.text,
                  maintenanceStatus: "In-Progress",
                ),
              ),
              statusItem(
                context: context,
                title: "Completed".tr(context),
                controller: completedC,
                onSend: () => cubit.changeStatus(
                  id: item.sId ?? '',
                  feedbackComment: completedC.text,
                  maintenanceStatus: "Completed",
                ),
              ),
              statusItem(
                context: context,
                title: "Cancelled".tr(context),
                controller: cancelledC,
                onSend: () => cubit.changeStatus(
                  id: item.sId ?? '',
                  feedbackComment: cancelledC.text,
                  maintenanceStatus: "Cancelled",
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget statusItem(
      {required String title,
      VoidCallback? onSend,
      TextEditingController? controller,
      required BuildContext context
      // required String
      }) {
    return ListTile(
      leading: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      title: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "OptionalComment".tr(context),
          hintStyle: const TextStyle(fontSize: 13),
          suffixIcon: IconButton(
            onPressed: onSend,
            icon: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}

// Maintenance Item Component
class MaintenanceItem extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String? feedbackComment;
  final List<MaintenanceTag> statusTags;
  final VoidCallback onUpdateStatus;
  final VoidCallback onUpdatePriority;
  final VoidCallback onDelete;
  final String? image;

  const MaintenanceItem({
    super.key,
    required this.title,
    required this.date,
    this.image,
    required this.description,
    required this.statusTags,
    required this.onUpdateStatus,
    required this.onUpdatePriority,
    required this.onDelete,
    this.feedbackComment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpdateStatus, // Allow tapping the item to update the status
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: onDelete,
                      child: const Icon(Icons.delete, color: Colors.red)),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: CupertinoColors.systemGrey4,
                    ),
              ),
              const SizedBox(height: 8),
              if (image != null)
                InkWell(
                  onTap: () => zoomImage(context, image),
                  child: Image.network(
                    image ?? '',
                    height: 200,
                    width: kIsWeb ? 200 : double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                children: statusTags.map((tag) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: tag.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag.text,
                      style: TextStyle(color: tag.color, fontSize: 12),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              if (feedbackComment != null) Text(feedbackComment ?? ''),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(extractDate(date)),
                  const SizedBox(width: 20),
                  Text(extractTime(date)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Tag Component
class MaintenanceTag {
  final String text;
  final Color color;

  MaintenanceTag({required this.text, required this.color});
}

// Dialog for updating priority
class PriorityUpdateDialog extends StatelessWidget {
  final Function(String, Color) onUpdate;

  const PriorityUpdateDialog({super.key, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text("Low".tr(context)),
          onTap: () => onUpdate("منخفضة", Colors.green),
        ),
        ListTile(
          title: Text("Medium".tr(context)),
          onTap: () => onUpdate("متوسطة", Colors.yellow),
        ),
        ListTile(
          title: Text("High".tr(context)),
          onTap: () => onUpdate("عالية", Colors.red),
        ),
      ],
    );
  }
}

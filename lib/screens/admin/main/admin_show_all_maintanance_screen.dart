import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/constants.dart';
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                const AdminDashboardHeader(),
                const SizedBox(height: defaultPadding),
                Text(
                  "جميع الأصلاحات",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: defaultPadding),
                Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: BlocBuilder<MaintenanceCubit, MaintenanceState>(
                      builder: (context, state) {
                        var model =
                            context.read<MaintenanceCubit>().maintenanceModel;
                        var list = model?.result;
                        return list == null
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                                children: list
                                    .map((e) => MaintenanceItem(
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
                                                    ? Colors.redAccent
                                                    : Colors
                                                    .yellowAccent),
                                          ],
                                          onUpdatePriority: () {},
                                          onUpdateStatus: () {
                                            // Example of updating the status

                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) =>
                                                  StatusUpdateDialog(
                                                item: e,
                                                // maintenanceItem: e,
                                                // onUpdate:
                                                //     (newStatus, newColor) {
                                                //   // updateStatus(index, newStatus, newColor);
                                                //   print(newStatus);
                                                //   Navigator.pop(context);
                                                // },
                                              ),
                                            );
                                          },
                                          feedbackComment: e.feedbackComment,
                                        ))
                                    .toList(),
                              );
                      },
                    )
                    //
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: maintenanceItems
                    //       .asMap()
                    //       .entries
                    //       .map((entry) {
                    //     int index = entry.key;
                    //     Map<String, dynamic> item = entry.value;
                    //     return Column(
                    //       children: [
                    //         MaintenanceItem(
                    //           title: item['title'],
                    //           description: item['description'],
                    //           statusTags: [
                    //             MaintenanceTag(
                    //               text: item['status'],
                    //               color: item['statusColor'],
                    //             ),
                    //             MaintenanceTag(
                    //               text: item['priority'],
                    //               color: item['priorityColor'],
                    //             ),
                    //           ],
                    //           onUpdateStatus: () {
                    //             // Example of updating the status
                    //             showModalBottomSheet(
                    //               context: context,
                    //               builder: (context) => StatusUpdateDialog(
                    //                 onUpdate: (newStatus, newColor) {
                    //                   updateStatus(index, newStatus, newColor);
                    //                   Navigator.pop(context);
                    //                 },
                    //               ),
                    //             );
                    //           },
                    //           onUpdatePriority: () {
                    //             // Example of updating the priority
                    //             showModalBottomSheet(
                    //               context: context,
                    //               builder: (context) => PriorityUpdateDialog(
                    //                 onUpdate: (newPriority, newColor) {
                    //                   updatePriority(index, newPriority, newColor);
                    //                   Navigator.pop(context);
                    //                 },
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //         const SizedBox(height: defaultPadding),
                    //       ],
                    //     );
                    //   }).toList(),
                    // ),
                    //

                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Dialog for updating status
class StatusUpdateDialog extends StatelessWidget {
  // final Function(String, Color) onUpdate;
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
                title: "Pending",
                controller: pendingC,
                onSend: () => cubit.changeStatus(
                  id: item.sId ?? '',
                  feedbackComment: pendingC.text,
                  maintenanceStatus: "Pending",
                ),
              ),
              statusItem(
                title: "Accepted",
                controller: acceptedC,
                onSend: () => cubit.changeStatus(
                  id: item.sId ?? '',
                  feedbackComment: acceptedC.text,
                  maintenanceStatus: "Accepted",
                ),
              ),
              statusItem(
                title: "In-Progress",
                controller: inProgressC,
                onSend: () => cubit.changeStatus(
                  id: item.sId ?? '',
                  feedbackComment: inProgressC.text,
                  maintenanceStatus: "In-Progress",
                ),
              ),
              statusItem(
                title: "Completed",
                controller: completedC,
                onSend: () => cubit.changeStatus(
                  id: item.sId ?? '',
                  feedbackComment: completedC.text,
                  maintenanceStatus: "Completed",
                ),
              ),
              statusItem(
                title: "Cancelled",
                controller: cancelledC,
                onSend: () => cubit.changeStatus(
                  id: item.sId ?? '',
                  feedbackComment: cancelledC.text,
                  maintenanceStatus: "Cancelled",
                ),
              ),
              // ListTile(
              //   leading: const Text(
              //     "قيد الانتظار",
              //     style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   title: TextFormField(
              //     decoration: InputDecoration(
              //       hintText: "Optional Comment",
              //       hintStyle: const TextStyle(fontSize: 13),
              //       suffixIcon: IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.send),
              //       ),
              //     ),
              //   ),
              //   onTap: () => onUpdate("قيد الانتظار", Colors.orange),
              // ),
              // ListTile(
              //   leading: const Text(
              //     "تم الأصلاح",
              //     style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   title: TextFormField(
              //     decoration: InputDecoration(
              //       hintText: "Optional Comment",
              //       hintStyle: const TextStyle(fontSize: 13),
              //       suffixIcon: IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.send),
              //       ),
              //     ),
              //   ),
              //   onTap: () => onUpdate("تم الأصلاح", Colors.green),
              // ),
              // ListTile(
              //   leading: const Text(
              //     "تم الألغاء",
              //     style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   title: TextFormField(
              //     decoration: InputDecoration(
              //       hintText: "Optional Comment",
              //       hintStyle: const TextStyle(fontSize: 13),
              //       suffixIcon: IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.send),
              //       ),
              //     ),
              //   ),
              //   // title: const Text("تم الألغاء"),
              //   onTap: () => onUpdate("تم الألغاء", Colors.red),
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget statusItem({
    required String title,
    VoidCallback? onSend,
    TextEditingController? controller,
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
          hintText: "Optional Comment",
          hintStyle: const TextStyle(fontSize: 13),
          suffixIcon: IconButton(
            onPressed: onSend,
            icon: const Icon(Icons.send),
          ),
        ),
      ),
      // onTap: () => onUpdate("قيد الانتظار", Colors.orange),
    );
  }
}

// Maintenance Item Component
class MaintenanceItem extends StatelessWidget {
  final String title;
  final String description;
  final String? feedbackComment;
  final List<MaintenanceTag> statusTags;
  final VoidCallback onUpdateStatus;
  final VoidCallback onUpdatePriority;
  final String? image;

  const MaintenanceItem({
    super.key,
    required this.title,
    this.image,
    required this.description,
    required this.statusTags,
    required this.onUpdateStatus,
    required this.onUpdatePriority,
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
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
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
              if (feedbackComment != null) Text(feedbackComment ?? '')
              // ElevatedButton(
              //   onPressed: onUpdatePriority,
              //   child: const Text("تغيير الأولوية"),
              // ),
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
          title: const Text("منخفضة"),
          onTap: () => onUpdate("منخفضة", Colors.green),
        ),
        ListTile(
          title: const Text("متوسطة"),
          onTap: () => onUpdate("متوسطة", Colors.yellow),
        ),
        ListTile(
          title: const Text("عالية"),
          onTap: () => onUpdate("عالية", Colors.red),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';

class AddCommentTextField extends StatelessWidget {
  const AddCommentTextField({
    super.key,
    required this.controller,
    required this.addReplay,
    required this.load,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool addReplay;
  final bool load;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: addReplay == true ? "...${"Addareply".tr(context)}" : "${"Addacomment".tr(context)}...",
                hintStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: onSend,
            icon: load
                ? const SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(color: Colors.white))
                : const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

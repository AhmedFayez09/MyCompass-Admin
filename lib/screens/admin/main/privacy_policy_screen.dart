import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});

  TextEditingController privacy = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PrivacyPolicy".tr(context)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLines: 20,
                  minLines: 1,
                  controller: privacy,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "EnterPrivacyPolicy".tr(context);
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "AddPrivacyPolicy".tr(context),
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<AdminCubit, AdminState>(
                  listener: (context, state) {
                    if (state is AddPrivacyPolicySuccess) {
                      Navigator.pop(context);
                      SnackbarWidget.show(context, "Success Added");
                    } else if (state is AddPrivacyPolicyFailure) {
                      SnackbarWidget.show(
                          context, state.errorModel.message.toString());
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context
                                .read<AdminCubit>()
                                .addPrivacyPolicy(privacy: privacy.text);
                          }
                        },
                        child: state is AddPrivacyPolicyLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                "AddPrivacyPolicy".tr(context),
                                style: const TextStyle(color: Colors.white),
                              ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

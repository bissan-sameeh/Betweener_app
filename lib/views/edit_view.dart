import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/my-button_widget.dart';

import '../controllers/add_new_link.dart';
import '../controllers/edit_link_controller.dart';
import '../models/link.dart';

class EditeView extends StatefulWidget {
  static const id = "/editView";
  const EditeView({super.key});

  @override
  State<EditeView> createState() => _EditeViewState();
}

class _EditeViewState extends State<EditeView> {
  late TextEditingController titleController;
  late int linkId;
  late TextEditingController linkController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    titleController = TextEditingController();
    linkController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    linkController.dispose();
    super.dispose();
  }

  editLinkUser() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'title': titleController.text,
        'link': linkController.text,
      };
      editLink(userId: linkId, body: body).then((checkEdit) {
        if (checkEdit == true && mounted) {
          Navigator.pop(context, checkEdit);
        }
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(12),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    titleController.text = args[0];
    linkController.text = args[1];
    linkId = args[2];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 60.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  label: 'Title',
                  controller: titleController,
                  prefix: Icons.text_fields,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextFormField(
                  controller: linkController,
                  prefix: Icons.link,
                  label: 'link',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
                MyButton(
                  text: 'Edit',
                  onTap: editLinkUser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

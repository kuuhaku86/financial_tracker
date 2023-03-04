import 'dart:io';

import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Interfaces/widgets/button_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/input_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddIncomeSourcePage extends StatefulWidget {
  const AddIncomeSourcePage({Key? key}) : super(key: key);
  static const String route = "/main/add_income_source_page";

  @override
  State<StatefulWidget> createState() => _AddIncomeSourcePageState();
}

class _AddIncomeSourcePageState extends State<AddIncomeSourcePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();
  File? image;
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: themeColor.primary,
        body: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InputCustom(
                          title: "Name",
                          child: TextFormField(
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                            ),
                            style: TextStyle(
                              color: themeColor.text,
                            ),
                            controller: nameController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          )),
                      (image != null)
                          ? Semantics(
                              label: "picked_image",
                              child: Image.file(
                                File(image!.path),
                                width: MediaQuery.of(context).size.width * 0.8,
                              ),
                            )
                          : Container(),
                      ButtonCustom(
                          icon: Icons.photo_camera,
                          text: "Select Photo",
                          onTap: () {
                            pickImage();
                          }),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: ButtonCustom(
                      icon: Icons.save, text: "Save", onTap: () {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await _picker.getImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
}

import 'dart:io';

import 'package:financial_tracker/Applications/usecase/add_source_usecase.dart';
import 'package:financial_tracker/Applications/usecase/update_source_usecase.dart';
import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:financial_tracker/Infrastructures/providers/model/income_source_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/source_model.dart';
import 'package:financial_tracker/Interfaces/widgets/alert_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/button_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/input_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;

class AddOrEditIncomeSourcePage extends StatefulWidget {
  const AddOrEditIncomeSourcePage({Key? key}) : super(key: key);
  static const String route = "/main/add_income_source_page";

  @override
  State<StatefulWidget> createState() => _AddOrEditIncomeSourcePageState();
}

class _AddOrEditIncomeSourcePageState extends State<AddOrEditIncomeSourcePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();
  final SourceRepository repository = dependency_container.Container.container
      .getInstance(SourceRepository) as SourceRepository;
  File? image;
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: themeColor.primary,
        body: Form(
          key: _formKey,
          child: SizedBox(
            height: mediaQuerySize.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: mediaQuerySize.height,
                  child: SingleChildScrollView(
                    child: Consumer<IncomeSourceModel>(
                        builder: (context, incomeSourceModel, _) {
                      if (incomeSourceModel.source != null) {
                        if (nameController.text.isEmpty) {
                          nameController.text = incomeSourceModel.source!.name;
                        }

                        image ??= File(incomeSourceModel.source!.imageRoute);
                      }

                      return Column(
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
                          Container(
                            margin: EdgeInsets.only(
                                bottom: mediaQuerySize.height * 0.01),
                            child: ButtonCustom(
                                icon: Icons.photo_camera,
                                text: "Select Photo",
                                onTap: () {
                                  pickImage(context);
                                }),
                          ),
                          (image != null)
                              ? Semantics(
                                  label: "picked_image",
                                  child: Image.file(
                                    image!,
                                    width: mediaQuerySize.width * 0.8,
                                  ),
                                )
                              : Container(),
                        ],
                      );
                    }),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: ButtonCustom(
                      icon: Icons.save,
                      text: "Save",
                      onTap: () async {
                        await storeSource(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImage(BuildContext context) async {
    try {
      PermissionStatus status;

      if (Platform.isAndroid) {
        if (await Permission.storage.request().isGranted ||
            await Permission.photos.request().isGranted ||
            await Permission.mediaLibrary.request().isGranted) {
          final picked = await _picker.pickImage(source: ImageSource.gallery);
          if (picked == null) return;

          setState(() {
            image = File(picked.path);
          });
        } else {
          openAppSettings();
        }
      } else {
        // iOS
        if (await Permission.photos.request().isGranted) {
          final picked = await _picker.pickImage(source: ImageSource.gallery);
          if (picked == null) return;

          setState(() {
            image = File(picked.path);
          });
        } else {
          openAppSettings();
        }
      }

      // if (Platform.isAndroid) {
      //   status = await Permission.photos.request();
      // } else {
      //   status = await Permission.photos.request();
      // }

      // if (status.isGranted) {
      //   final image = await _picker.getImage(source: ImageSource.gallery);
      //   if (image == null) return;
      //   final imageTemp = File(image.path);
      //   setState(() => this.image = imageTemp);
      // } else {
      //   await Permission.mediaLibrary.request(); // for broader support
      //   openAppSettings(); // Optional: guide user to manually enable
      // }
      // } else if (status.isDenied) {
      //   openAppSettings(); // Optional: guide user to manually enable
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text("Access to Photo Not Permitted"),
      //       actions: [
      //         TextButton(
      //           child: Text("OK"),
      //           onPressed: () {
      //             Navigator.of(context).pop(); // Close the dialog
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
      // } else if (status.isPermanentlyDenied) {
      //   openAppSettings(); // Optional: guide user to manually enable
      // }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  storeSource(BuildContext context) async {
    if (!_formKey.currentState!.validate() || image == null) {
      const snackBar = SnackBar(
        content: Text('The form is still incomplete'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    try {
      final source =
          Provider.of<IncomeSourceModel>(context, listen: false).source;
      SnackBar? snackBar;
      final addSource = AddSource(name: nameController.text, image: image!);

      if (source == null) {
        final AddSourceUsecase usecase = dependency_container
            .Container.container
            .getInstance(AddSourceUsecase) as AddSourceUsecase;
        await usecase.execute(addSource);

        snackBar = const SnackBar(
          content: Text("Add Source success"),
        );
      } else {
        final UpdateSourceUsecase usecase = dependency_container
            .Container.container
            .getInstance(UpdateSourceUsecase) as UpdateSourceUsecase;

        await usecase.execute(source, addSource);

        snackBar = const SnackBar(
          content: Text("Update Source success"),
        );
      }

      if (context.mounted) {
        Provider.of<IncomeSourceListModel>(context, listen: false).refresh();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pop(context);
      }
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.toString()),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

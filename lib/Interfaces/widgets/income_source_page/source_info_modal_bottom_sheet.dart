import 'dart:io';

import 'package:financial_tracker/Applications/usecase/get_source_usecase.dart';
import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Interfaces/widgets/general_modal_bottom_sheet.dart';
import 'package:financial_tracker/Interfaces/widgets/image_custom.dart';
import 'package:flutter/material.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;

class SourceInfoModalBottomSheet {
  static showModal(BuildContext context, int sourceId) async {
    final mediaQuerySize = MediaQuery.of(context).size;
    final GetSourceUsecase usecase = dependency_container.Container.container
        .getInstance(GetSourceUsecase) as GetSourceUsecase;
    final Source source = await usecase.execute(sourceId);

    if (context.mounted) {
      showGeneralBottomSheet(
          context: context,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageCustom(imageProvider: FileImage(File(source.imageRoute))),
              SizedBox(
                width: mediaQuerySize.width * 0.03,
              ),
              Text(
                source.name,
                style: TextStyle(color: themeColor.text),
              ),
            ],
          )),
          height: mediaQuerySize.height * 0.25);
    }
  }
}

import 'dart:io';

import 'package:financial_tracker/Applications/usecase/get_source_usecase.dart';
import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
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
      showModalBottomSheet<void>(
          elevation: 2.0,
          barrierColor: themeColor.secondary.withOpacity(0.075),
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          backgroundColor: themeColor.primary,
          builder: (BuildContext context) {
            return Container(
              height: mediaQuerySize.height * 0.25,
              decoration: BoxDecoration(
                color: themeColor.primary,
                boxShadow: [
                  BoxShadow(
                    color: themeColor.secondary.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageCustom(
                      imageProvider: FileImage(File(source.imageRoute))),
                  SizedBox(
                    width: mediaQuerySize.width * 0.03,
                  ),
                  Text(
                    source.name,
                    style: TextStyle(color: themeColor.text),
                  ),
                ],
              )),
            );
          });
    }
  }
}

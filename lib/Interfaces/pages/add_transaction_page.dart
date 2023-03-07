import 'dart:io';

import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Interfaces/widgets/button_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/input_custom.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);
  static const String route = "/main/add_transaction_page";

  @override
  State<StatefulWidget> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();
  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  List<TransactionType> transactionTypes = [
    TransactionType(id: 1, name: "Income"),
    TransactionType(id: 2, name: "Outcome"),
  ];
  late TransactionType transactionTypeSelected = transactionTypes[0];
  List<Source> sourceList = [
    Source(id: 1, name: "Bank One", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Two", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Three", imageRoute: "assets/images/logo.png"),
  ];
  late Source sourceSelected = sourceList[0];
  final recurrentOptionList = [
    {"name": "No", "value": false},
    {"name": "Yes", "value": true},
  ];
  late Map isRecurrent = recurrentOptionList[0];
  TextEditingController repeatableNumberOfRecurrentPeriodController =
      TextEditingController(text: "1");
  final listOfRecurrentPeriod = ["Days", "Months", "Years"];
  late String recurrentPeriodSelected = listOfRecurrentPeriod[0];

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
                          title: "Transaction Name",
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
                      InputCustom(
                          title: "Transaction Detail",
                          child: TextFormField(
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                            ),
                            style: TextStyle(
                              color: themeColor.text,
                            ),
                            controller: detailController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          )),
                      InputCustom(
                        title: "Transaction Type",
                        child: Center(
                          child: DropdownButton(
                            alignment: Alignment.center,
                            dropdownColor: themeColor.primary,
                            isDense: true,
                            value: transactionTypeSelected,
                            style: TextStyle(
                              color: themeColor.text,
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                            items: transactionTypes.map((TransactionType item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (TransactionType? newValue) {
                              setState(() {
                                transactionTypeSelected = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      InputCustom(
                          title: "Transaction Amount",
                          child: TextFormField(
                            keyboardType: TextInputType.number,
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
                                return 'Please enter some number';
                              }
                              return null;
                            },
                          )),
                      InputCustom(
                        title: "Source Selection",
                        child: Center(
                          child: DropdownButton(
                            alignment: Alignment.center,
                            dropdownColor: themeColor.primary,
                            isDense: true,
                            value: sourceSelected,
                            style: TextStyle(
                              color: themeColor.text,
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                            items: sourceList.map((Source item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Row(
                                  children: [
                                    Image(image: AssetImage(item.imageRoute)),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Text(
                                      item.name,
                                      style: TextStyle(color: themeColor.text),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (Source? newValue) {
                              setState(() {
                                sourceSelected = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      InputCustom(
                        title: "Is Recurrent?",
                        child: Center(
                          child: DropdownButton(
                            alignment: Alignment.center,
                            dropdownColor: themeColor.primary,
                            isDense: true,
                            value: isRecurrent,
                            style: TextStyle(
                              color: themeColor.text,
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                            items: recurrentOptionList.map((Map item) {
                              return DropdownMenuItem(
                                  value: item, child: Text(item["name"]));
                            }).toList(),
                            onChanged: (Map? newValue) {
                              setState(() {
                                isRecurrent = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      isRecurrent["value"]
                          ? InputCustom(
                              title: "Repeat Every?",
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                        ),
                                        style: TextStyle(
                                          color: themeColor.text,
                                        ),
                                        controller:
                                            repeatableNumberOfRecurrentPeriodController,
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: DropdownButton(
                                          alignment: Alignment.center,
                                          dropdownColor: themeColor.primary,
                                          isDense: true,
                                          value: recurrentPeriodSelected,
                                          style: TextStyle(
                                            color: themeColor.text,
                                          ),
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                          ),
                                          items: listOfRecurrentPeriod
                                              .map((String item) {
                                            return DropdownMenuItem(
                                                value: item, child: Text(item));
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              recurrentPeriodSelected =
                                                  newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
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
}

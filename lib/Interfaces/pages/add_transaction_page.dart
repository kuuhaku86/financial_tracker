import 'dart:io';

import 'package:financial_tracker/Applications/usecase/add_transaction_usecase.dart';
import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Infrastructures/providers/model/income_source_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/period_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_type_list_model.dart';
import 'package:financial_tracker/Interfaces/widgets/button_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/image_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/input_custom.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);
  static const String route = "/main/add_transaction_page";

  @override
  State<StatefulWidget> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TransactionType? transactionTypeSelected;
  Source? sourceSelected;

  final recurrentOptionList = [
    {"name": "No", "value": false},
    {"name": "Yes", "value": true},
  ];
  late Map isRecurrent = recurrentOptionList[0];
  TextEditingController repeatableNumberOfRecurrentPeriodController =
      TextEditingController(text: "1");
  Period? recurrentPeriodSelected;

  @override
  void dispose() {
    nameController.dispose();
    detailController.dispose();
    amountController.dispose();
    repeatableNumberOfRecurrentPeriodController.dispose();
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
                            child: Consumer<TransactionTypeListModel>(builder:
                                (context, transactionTypeListModel, _) {
                              return DropdownButton<TransactionType>(
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
                                items: transactionTypeListModel.transactionTypes
                                    .map((TransactionType item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item.name),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    transactionTypeSelected = newValue;
                                  });
                                },
                              );
                            }),
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
                              controller: amountController,
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
                            child: Consumer<IncomeSourceListModel>(
                                builder: (context, incomeSourceListModel, _) {
                              return DropdownButton<Source>(
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
                                items: incomeSourceListModel.sources
                                    .map((Source item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Row(
                                      children: [
                                        ImageCustom(
                                            imageProvider: FileImage(
                                                File(item.imageRoute))),
                                        SizedBox(
                                          width: mediaQuerySize.width * 0.01,
                                        ),
                                        Text(
                                          item.name,
                                          style:
                                              TextStyle(color: themeColor.text),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    sourceSelected = newValue;
                                  });
                                },
                              );
                            }),
                          ),
                        ),
                        InputCustom(
                          title: "Is Recurrent?",
                          child: Center(
                            child: DropdownButton<Map>(
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
                              onChanged: (newValue) {
                                setState(() {
                                  isRecurrent = newValue as Map;
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
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 0, vertical: 0),
                                          ),
                                          style: TextStyle(
                                            color: themeColor.text,
                                          ),
                                          controller:
                                              repeatableNumberOfRecurrentPeriodController,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Consumer<PeriodListModel>(
                                              builder: (context,
                                                  periodListModel, _) {
                                            return DropdownButton<Period>(
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
                                              items: periodListModel.periods
                                                  .map((Period item) {
                                                return DropdownMenuItem(
                                                    value: item,
                                                    child: Text(item.name));
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  recurrentPeriodSelected =
                                                      newValue;
                                                });
                                              },
                                            );
                                          }),
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
                ),
                Positioned(
                  bottom: 0.0,
                  child: ButtonCustom(
                      icon: Icons.save,
                      text: "Save",
                      onTap: () {
                        storeTransaction(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  isFormValid(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    if (transactionTypeSelected == null || sourceSelected == null) {
      return false;
    }

    if (isRecurrent["value"] == true &&
        (recurrentPeriodSelected == null ||
            int.parse(repeatableNumberOfRecurrentPeriodController.text) < 1)) {
      return false;
    }

    return true;
  }

  storeTransaction(BuildContext context) async {
    if (!isFormValid(context)) {
      const snackBar = SnackBar(
        content: Text('The form is still incomplete'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    try {
      SnackBar? snackBar;

      final AddTransactionUsecase usecase = dependency_container
          .Container.container
          .getInstance(AddTransactionUsecase) as AddTransactionUsecase;
      AddTransaction addTransaction = AddTransaction(
        transactionTypeId: transactionTypeSelected!.id,
        sourceId: sourceSelected!.id,
        name: nameController.text,
        explanation: detailController.text,
        amount: double.parse(amountController.text),
        isRecurring: isRecurrent["value"],
      );

      if (isRecurrent["value"]) {
        addTransaction.numberInPeriod =
            int.parse(repeatableNumberOfRecurrentPeriodController.text);
        addTransaction.period = recurrentPeriodSelected;
      }

      await usecase.execute(addTransaction);

      snackBar = const SnackBar(
        content: Text("Add Transaction success"),
      );

      if (context.mounted) {
        Provider.of<TransactionListModel>(context, listen: false).refresh();
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

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_tracker/config/app_data.dart';
import 'package:wallet_tracker/screens/add_expense/blocs/create_category/create_category_bloc.dart';

import 'custom_save_button.dart';

Future getCategoryDialog(BuildContext context) {
  var formKey = GlobalKey<FormState>();
  List<String> categoryIconList = AppData.categoryIconList;
  bool isExpanded = false;
  String iconSelected = '';
  Color colorSelected = Colors.white;
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  Category category = Category.empty;

  return showDialog(
      context: context,
      builder: (cxt) {
        return StatefulBuilder(builder: (cxt, setState) {
          return BlocProvider.value(
            value: context.read<CreateCategoryBloc>(),
            child: BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                if (state is CreateCategorySuccess) {
                  Navigator.of(cxt).pop(category);
                } else if (state is CreateCategoryLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: AlertDialog(
                title: const Text(
                  'Create a Category',
                  textAlign: TextAlign.center,
                ),
                content: SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (nameController.text.isEmpty) return 'Type a name for the category';
                              return null;
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (iconSelected.isEmpty) return 'Select an icon';
                              return null;
                            },
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Icon',
                                prefixIcon: iconSelected.isEmpty
                                    ? null
                                    : Image.asset(
                                        'assets/images/$iconSelected',
                                        scale: 2,
                                      ),
                                suffixIcon: const Icon(
                                  CupertinoIcons.chevron_down,
                                  size: 13,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: isExpanded
                                        ? const BorderRadius.vertical(
                                            top: Radius.circular(10),
                                          )
                                        : BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          isExpanded
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(12),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridView.builder(
                                        itemCount: categoryIconList.length,
                                        itemBuilder: (context, int i) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                iconSelected =
                                                    categoryIconList[i];
                                                isExpanded = false;
                                              });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  border: iconSelected ==
                                                          categoryIconList[i]
                                                      ? Border.all()
                                                      : null,
                                                  borderRadius: iconSelected ==
                                                          categoryIconList[i]
                                                      ? BorderRadius.circular(
                                                          50)
                                                      : BorderRadius.zero),
                                              child: Image.asset(
                                                  'assets/images/${categoryIconList[i]}'),
                                            ),
                                          );
                                        },
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 20,
                                                crossAxisSpacing: 10,
                                                mainAxisExtent: 40)),
                                  ),
                                )
                              : Container(),
                          const SizedBox(height: 20),
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: colorSelected,
                                hintText: 'Color',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (cxt) => AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ColorPicker(
                                                  pickerColor: colorSelected,
                                                  onColorChanged: (value) {
                                                    setState(() {
                                                      colorSelected = value;
                                                    });
                                                  }),
                                              const SizedBox(height: 20),
                                              customSaveTextButton(
                                                  save: () =>
                                                      Navigator.of(context)
                                                          .pop())
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : customSaveTextButton(save: () {
                                    if(formKey.currentState!.validate()) {
                                      category.categoryId = const Uuid().v1();
                                      category.name = nameController.text;
                                      category.color = colorSelected.value;
                                      category.icon = iconSelected;

                                      context
                                          .read<CreateCategoryBloc>()
                                          .add(CreateCategory(category));
                                    }
                                    }))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      });
}

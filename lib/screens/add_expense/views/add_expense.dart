import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_tracker/screens/add_expense/blocs/create_expense/create_expense_cubit.dart';
import 'package:wallet_tracker/screens/add_expense/blocs/get_categories/get_categories_cubit.dart';

import '../../common_widgets/global_custom_widgets.dart';
import '../widgets/category_dialog.dart';


class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  late Expense expense;

  var formKey = GlobalKey<FormState>();
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    expense = Expense.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseCubit, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.of(context).pop(true);
        } else {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.surface),
            body: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
                builder: (context, state) {
              if (state is GetCategoriesSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Add Expense',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextFormField(
                              controller: expenseController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field can\'t be empty';
                                }

                                final phoneRegex = RegExp(r'^\+?\d[\d -]*$');
                                if (!phoneRegex.hasMatch(value)) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  suffixText: '.00',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    CupertinoIcons.money_dollar,
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select a category or add new one';
                              }
                              return null;
                            },
                            controller: categoryController,
                            textAlignVertical: TextAlignVertical.center,
                            readOnly: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: expense.category == Category.empty
                                    ? Colors.white
                                    : Color(expense.category.color),
                                prefixIcon: expense.category == Category.empty
                                    ? const Icon(
                                        CupertinoIcons.list_bullet,
                                        color: Colors.grey,
                                        size: 22,
                                      )
                                    : Image.asset(
                                        'assets/images/${expense.category.icon}',
                                        scale: 1.8,
                                      ),
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      var category =
                                          await getCategoryDialog(context);

                                      setState(() {
                                        state.categories.insert(0, category);
                                      });
                                    },
                                    icon: Icon(Icons.add,
                                        color: expense.category.color != 0
                                            ? Color(expense.category.color)
                                                        .computeLuminance() >
                                                    0.5
                                                ? Colors.black
                                                : Colors.white
                                            : Colors.black)),
                                hintText: 'Categories',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  itemCount: state.categories.length,
                                  itemBuilder: (context, int i) {
                                    final category = state.categories[i];
                                    final tileColor = Color(category.color);

                                    final textColor =
                                        tileColor.computeLuminance() > 0.5
                                            ? Colors.black
                                            : Colors.white;
                                    return Card(
                                      child: ListTile(
                                        onTap: () {
                                          setState(() {
                                            expense.category = category;
                                            categoryController.text =
                                                category.name;
                                          });
                                        },
                                        leading: Image.asset(
                                          'assets/images/${category.icon}',
                                          scale: 2,
                                          color: textColor,
                                        ),
                                        title: Text(
                                          category.name,
                                          style: TextStyle(color: textColor),
                                        ),
                                        tileColor: tileColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: dateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Set a date for the expense';
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: expense.date,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              );
                              if (newDate != null) {
                                final now = DateTime.now();
                                newDate = DateTime(
                                  newDate.year,
                                  newDate.month,
                                  newDate.day,
                                  now.hour,
                                  now.minute,
                                  now.second,
                                );
                                setState(() {
                                  dateController.text = DateFormat('dd/MM/yyyy').format(newDate!);
                                  expense.date = newDate;
                                });
                              }
                            },
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                  Icons.date_range,
                                  color: Colors.grey,
                                  size: 22,
                                ),
                                hintText: 'Date',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                              height: kToolbarHeight,
                              width: double.infinity,
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : customSaveTextButton(save: () {
                                      if (formKey.currentState!.validate()) {
                                        expense.amount =
                                            int.parse(expenseController.text);
                                        expense.expenseId = const Uuid().v1();
                                        context
                                            .read<CreateExpenseCubit>().createExpense(expense);
                                      }
                                    }))
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })),
      ),
    );
  }
}

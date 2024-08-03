import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_tracker/screens/add_income/blocs/create_income/create_income_cubit.dart';

import '../../common_widgets/global_custom_widgets.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  late Income income;

  var formKey = GlobalKey<FormState>();

  TextEditingController incomeController = TextEditingController();
  TextEditingController incomeNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isLoading = false;


  @override
  void initState() {
    income = Income.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateIncomeCubit, CreateIncomeState>(
  listener: (context, state) {
    if(state is CreateIncomeSuccess){
      Navigator.of(context).pop(true);
    }else if(state is CreateIncomeFailure){
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text('Income creation failed: ${state.message}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }else{
      isLoading = true;
    }
  },
  child: GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar:
            AppBar(backgroundColor: Theme.of(context).colorScheme.surface),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Add Income',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: incomeController,
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
                        )),
                    const SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      controller: incomeNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field can\'t be empty';
                        }
                        return null;
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          hintText: 'Income source',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.source,
                            color: Colors.grey,
                            size: 22,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none)),
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
                          initialDate: income.date,
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
                            income.date = newDate;
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
                            ? const Center(child: CircularProgressIndicator())
                            : customSaveTextButton(save: () {
                                if (formKey.currentState!.validate()) {
                                  income.amount =
                                      int.parse(incomeController.text);
                                  income.name = incomeNameController.text;
                                  income.incomeId = const Uuid().v1();
                                  context
                                  .read<CreateIncomeCubit>().createIncome(income);
                                }
                              }))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
);
  }
}

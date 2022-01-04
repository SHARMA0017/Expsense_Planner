// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;
  NewTransactions(this.addTx);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _inputTitleController = TextEditingController();

  final _inputAmountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_inputAmountController.text.isEmpty) {
      return;
    }
    final String title = _inputTitleController.text;
    final double amount = double.parse(_inputAmountController.text);
    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(_inputTitleController.text,
        double.parse(_inputAmountController.text), (_selectedDate as DateTime));
    Navigator.pop(context);
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021, 12),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            onSubmitted: (_) => _submitData(),
            controller: _inputTitleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          TextField(
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
            controller: _inputAmountController,
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Choosen !'
                        : DateFormat.yMd()
                            .format((_selectedDate as DateTime)),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: _datePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.purple),
            onPressed: _submitData,
            child: Text(
              'Add Transaction',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

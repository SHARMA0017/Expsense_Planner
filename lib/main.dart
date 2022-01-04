// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:expense_planner/models/transactions.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transactions.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Planner ',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTx(String txTitle, double txAmount, DateTime datePicked) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        id: DateTime.now().toString(),
        date: datePicked);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddnewTransactions(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: NewTransactions(_addNewTx),
            ),
          );
        });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Planner'),
        actions: [
          IconButton(
            onPressed: () => _startAddnewTransactions(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(_recentTransactions),
          TransactionList(_userTransactions, _deleteTransactions),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddnewTransactions(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

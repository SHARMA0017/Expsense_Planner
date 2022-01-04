// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:expense_planner/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetransaction;
  TransactionList(this.transactions, this.deletetransaction);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.7,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions added yet !',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset(
                    'images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text(
                                transactions[index].amount.toStringAsFixed(2))),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      onPressed: () =>
                          deletetransaction(transactions[index].id),
                      icon: Icon(Icons.delete, size: 30, color: Colors.red),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

/* Card(
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                        ),
                        child: Text(
                          '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                );*/
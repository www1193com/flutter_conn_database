import 'package:flutter/material.dart';
import 'package:flutter_conn_database/model/Transactions.dart';
import 'package:flutter_conn_database/providers/transaction_provider.dart';
import 'package:flutter_conn_database/screens/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomepage(title: 'แอพบัญชี'),
      ),
    );
  }
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomepage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormScreen();
                }));
              },
            )
          ],
        ),
        body:
            Consumer(builder: (context, TransactionProvider provider, Widget) {
          var count = provider.transactions.length; //สร้างตัวแปรข้อมูล
          if (count <= 0) {
            return Center(
              child: Text(
                "ไม่พบข้อมูล",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, int index) {
                  Transactions data = provider.transactions[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: FittedBox(
                          child: Text(data.amount.toString()),
                        ),
                      ),
                      title: Text(data.title),
                      subtitle: 
                        Text(DateFormat("dd/MM/yyyy").format(data.date)),
                    ),
                  );
                });
          }
        }));
  }
}

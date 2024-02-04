import 'package:flutter/material.dart';
import 'package:flutter_conn_database/model/Transactions.dart';
import 'package:flutter_conn_database/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  //const FormScreen({Key? key}) : super(key: key);

  void saveData() {
    // ทำงานเมื่อปุ่มถูกกด
    // คุณสามารถดึงข้อมูลจากฟอร์มที่นี่แล้วบันทึกได้
    // เช่น ให้ใช้ GlobalKey<FormState> เพื่อเข้าถึงข้อมูลฟอร์ม
  }
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แบบฟอร์มบันทึกข้อความ"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: GlobalKey<FormState>(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: new InputDecoration(labelText: "ชื่อรายการ"),
                autofocus: true,
                controller: titleController,
                //keyboardType: TextInputType.text,
              ),
              TextFormField(
                  decoration: new InputDecoration(labelText: "จำนวนเงิน"),
                  keyboardType: TextInputType.number,
                  controller: amountController),
              TextButton(
                child: Text('บันทึก'),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  var title = titleController.text;
                  var amount = amountController.text;

                  //print(title);
                  //print(amount);

                  //เตรียมข้อมูล
                  Transactions statement = Transactions(
                      title: title,
                      amount: double.parse(amount),
                      date: DateTime.now());

                  //เรียก provider
                  var provider =
                      Provider.of<TransactionProvider>(context, listen: false);
                  provider.addTransactior(statement);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

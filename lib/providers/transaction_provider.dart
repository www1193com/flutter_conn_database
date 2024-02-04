import 'package:flutter/foundation.dart';
import 'package:flutter_conn_database/database/transaction_db.dart';
import 'package:flutter_conn_database/model/Transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [
    // Transactions(title: "หนังสือ", amount: 500, date: DateTime.now()),
    // Transactions(title: "เสื้อผ้า", amount: 900, date: DateTime.now()),
    // Transactions(title: "กางเกง", amount: 400, date: DateTime.now()),
    // Transactions(title: "รองเท้า", amount: 700, date: DateTime.now())
  ];

  List<Transactions> getTransction() {
    return transactions;
  }

  void addTransactior(Transactions statement) async {
    //transactions.add(statement);
    //transactions.insert(0, statement);
    var db = TransactionDB(dbname: "transactions.db");

    //บันทึกข้อมูล
    await db.insertData(statement);

    //ดึงข้อมูลมาแสดงผล
    await db.loadAllData();
    
     //insert ข้อมูลเข้าไปใน staement
    transactions.insert(0, statement);

    //แจ้งเตือน consumer
    notifyListeners();
  }
}

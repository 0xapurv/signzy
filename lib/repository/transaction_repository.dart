import 'dart:async';

import 'package:signzy/core/messageMethods.dart';

class TransactionRepository {
 Methods methods = Methods();
  Future<List<double>> getTransaction() async{
    List<double> response = await methods.getTransaction();
    print(response);
    return response;
  }

}
import 'package:provider/provider.dart';
import 'package:signzy/repository/transaction_repository.dart';

List<SingleChildCloneableWidget> providers = dependentServices;




List<SingleChildCloneableWidget> dependentServices = [
  Provider<TransactionRepository>(
    create: (context) => TransactionRepository(),
  ),
];

import 'package:flutter/cupertino.dart';
import 'package:signzy/helper/error_handling.dart';
import 'package:signzy/repository/transaction_repository.dart';
import 'package:signzy/viewModel/base_viewModel.dart';

class TransactionViewModel extends BaseViewModel {
  TransactionRepository _transactionRepository;
  List<double> _response;

  TransactionViewModel({@required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  List<double> get getTransaction => _response;

  void _setTransaction(List<double> response) {
    _response = response;
    print(response);
  }

  Future transactions() async {
    _setTransaction(null);
    setFailure(null);
    setLoadingState(LoadingState.loading);
    try {
      print('hello');
      final success = await _transactionRepository.getTransaction();
      _setTransaction(success);
    } on Failure catch (f) {
      print("helooo");
      setFailure(f);
    }
    setLoadingState(LoadingState.loaded);
  }
}
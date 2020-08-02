import 'package:flutter/cupertino.dart';
import 'package:signzy/helper/error_handling.dart';

enum LoadingState { initial, loading, loaded }

class BaseViewModel extends ChangeNotifier{

  LoadingState _loadingState = LoadingState.initial;
  LoadingState get loadingState => _loadingState;
  void setLoadingState(LoadingState state) {
    _loadingState = state;
    notifyListeners();
  }

  Failure _failure;
  Failure get failure => _failure;
  void setFailure(Failure failure) {
    _failure = failure;
  }
}
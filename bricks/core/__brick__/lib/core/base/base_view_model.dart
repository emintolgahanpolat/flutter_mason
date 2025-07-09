// Flutter imports:
import 'package:flutter/material.dart';
import '../base/view_state.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isDispose = false;
  ViewState _viewState = IdleState();
  ViewState get viewState => _viewState;
  void setViewState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }
}

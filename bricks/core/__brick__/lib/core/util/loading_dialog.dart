// Flutter imports:
import 'package:flutter/material.dart';

class LoadingDialog {
  bool _isShow = false;
  late BuildContext _context;
  LoadingDialog._(BuildContext context) {
    if (!_isShow) {
      _context = context;
      _isShow = true;
      showDialog(
          useRootNavigator: true,
          barrierDismissible: false,
          context: _context,
          builder: (_) => const PopScope(
                canPop: false,
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: _Loading(
                    width: 56,
                  ),
                ),
              ));
    }
  }
  static LoadingDialog show(BuildContext context) {
    return LoadingDialog._(context);
  }

  void close() {
    if (_isShow) {
      _isShow = false;
      Navigator.of(_context, rootNavigator: true).pop();
    }
  }
}

class _Loading extends StatelessWidget {
  final double width;
  const _Loading({
    this.width = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: const Padding(
        padding: EdgeInsets.all(24.0),
        child: CircularProgressIndicator(),
      ),
    ));
  }
}

extension BuildContextEx on BuildContext {
  LoadingDialog showLoading() => LoadingDialog.show(this);
}

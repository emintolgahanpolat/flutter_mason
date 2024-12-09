import 'package:flutter/material.dart';
import '../util/alert_message.dart';

extension FutureExtension<T> on Future<T> {
  Future<T> setData(Function(T) function) async {
    function.call(await this);
    return this;
  }

  Future<T> handleErrorWithSnackbar(BuildContext context) async {
    try {
      await this;
    } catch (error) {
      context.showSnackBar(
        error.toString(),
        status: AlertStatus.error,
      );
    }
    return this;
  }

  Future<T> showLoading(
    BuildContext context,
  ) async {
    showDialog(
        useRootNavigator: true,
        barrierDismissible: false,
        context: context,
        builder: (_) => PopScope(
              canPop: false,
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Center(
                    child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(),
                  ),
                )),
              ),
            ));

    try {
      T result = await this;
      return result;
    } catch (error) {
      context.showSnackBar(
        error.toString(),
        status: AlertStatus.error,
      );
      return this;
    } finally {
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }
}

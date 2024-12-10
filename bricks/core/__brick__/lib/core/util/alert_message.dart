// Flutter imports:
import 'package:flutter/material.dart';
import '../res/icons.dart';
import '../res/l10n/l10n.dart';
import '../extension/context_ex.dart';

extension BuildContextEx on BuildContext {
  void showSnackBar(String message,
      {SnackBarAction? action,
      AlertStatus status = AlertStatus.info,
      bool showCloseIcon = false,
      SnackBarDuration duration = SnackBarDuration.long}) {
    ScaffoldMessenger.of(this)
      ..removeCurrentMaterialBanner()
      ..showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              _getIcon(status),
              color: _getColor(status),
              size: 36,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DefaultTextStyle(
                  style: textTheme
                      .bodyMedium!
                      .copyWith(color: colorScheme.onSurface),
                  child: Text(
                    message.toString().trim(),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: colorScheme.surface,
        duration: _getTime(duration),
        action: action, showCloseIcon: showCloseIcon,
        closeIconColor: colorScheme.onSurface,
        //behavior: SnackBarBehavior.floating,
      ));
  }

  Future<bool> showAlertDialog(
    String title, {
    String? message,
    AlertStatus status = AlertStatus.success,
  }) {
    return showAdaptiveDialog<bool>(
        context: this,
        builder: (c) {
          return AlertDialog.adaptive(
            icon: Icon(
              _getIcon(status),
              color: _getColor(status),
              size: 36,
            ),
            title: Text(title),
            content: message != null
                ? Text(
                    message,
                  )
                : null,
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Navigator.pop(c, true);
                  },
                  child: Text(l10n.okay)),
              TextButton(
                  style: OutlinedButton.styleFrom(
                    overlayColor: Colors.transparent,
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(c, false);
                  },
                  child: Text(l10n.cancel))
            ],
          );
        }).then((value) => value == true);
  }

  Future<void> showInfoDialog(
    String title, {
    String? message,
    AlertStatus status = AlertStatus.success,
  }) {
    return showAdaptiveDialog(
        context: this,
        builder: (c) {
          return AlertDialog.adaptive(
            icon: Icon(
              _getIcon(status),
              color: _getColor(status),
              size: 36,
            ),
            title: Text(title),
            content: message != null
                ? Text(
                    message,
                  )
                : null,
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Navigator.pop(c, true);
                  },
                  child: Text(l10n.okay)),
            ],
          );
        });
  }
}

class InfoMessage {
  AlertStatus status;
  String? title;
  String? message;
  SnackBarDuration duration;

  InfoMessage(
      {this.status = AlertStatus.success,
      this.title,
      this.message,
      this.duration = SnackBarDuration.long});

  void snack(BuildContext context, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentMaterialBanner()
      ..showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              _getIcon(status),
              color: Colors.white,
              size: 36,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (title != null)
                      DefaultTextStyle(
                        style: context.theme.textTheme.titleSmall!
                            .copyWith(color: Colors.white),
                        child: Text(
                          title!,
                        ),
                      ),
                    if (message != null)
                      DefaultTextStyle(
                        style: context.theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.white),
                        child: Text(
                          message.toString().trim(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: _getColor(status),
        duration: _getTime(duration),
        action: action,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ));
  }
}

IconData _getIcon(AlertStatus s) {
  switch (s) {
    case AlertStatus.success:
      return AppIcons.success;
    case AlertStatus.error:
      return AppIcons.error;
    case AlertStatus.info:
      return AppIcons.info;
    case AlertStatus.warning:
      return AppIcons.warning;
    default:
      return AppIcons.info;
  }
}

Color _getColor(AlertStatus s) {
  switch (s) {
    case AlertStatus.success:
      return Colors.green;
    case AlertStatus.error:
      return Colors.red;
    case AlertStatus.info:
      return Colors.blue;
    case AlertStatus.warning:
      return Colors.yellow;
    default:
      return Colors.blue;
  }
}

Duration _getTime(SnackBarDuration s) {
  switch (s) {
    case SnackBarDuration.indefinite:
      return const Duration(minutes: 1);
    case SnackBarDuration.long:
      return const Duration(milliseconds: 2750);
    default:
      return const Duration(milliseconds: 1500);
  }
}

enum AlertStatus { success, error, info, warning }

enum SnackBarDuration { indefinite, long, short }

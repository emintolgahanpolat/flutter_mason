import 'package:flutter/material.dart';
import '../../core/util/loading_dialog.dart';
import '../base/base_view_model.dart';

sealed class ViewState {}

class IdleState extends ViewState {}

class LoadingState extends ViewState {}

class ErrorState extends ViewState {
  final String message;
  ErrorState(this.message);
}

class ViewStateBuilder<T extends BaseViewModel> extends StatelessWidget {
  final T viewModel;
  final Widget Function(BuildContext context) builder;
  final Widget Function(BuildContext context, String message)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;

  const ViewStateBuilder({
    super.key,
    required this.viewModel,
    required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final state = viewModel.viewState;

    if (state is LoadingState) {
      return loadingBuilder?.call(context) ??
          Scaffold(appBar: AppBar(), body: const CenterLoading());
    }

    if (state is ErrorState) {
      return errorBuilder?.call(context, state.message) ??
          Scaffold(
            appBar: AppBar(),
            extendBodyBehindAppBar: true,
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.warning_amber, size: 100),
                    const Text(
                      "Oh No!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(state.message, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          );
    }

    return builder(context);
  }
}

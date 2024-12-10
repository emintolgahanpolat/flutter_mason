import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import '../util/loading_dialog.dart';

extension BuildContextEx on BuildContext {
  Future<List<XFile>> pickImage(ImageSource source,
      {int? selectableItemCount, bool isSupportAlfa = false}) async {
    final imagePicker = ImagePicker();

    if (selectableItemCount != null && selectableItemCount > 1) {
      return (await imagePicker.pickMultiImage())
          .map((image) async => await _compressImage(image))
          .whereType<XFile>()
          .toList();
    }

    final image = await imagePicker.pickImage(source: source);
    if (image == null) return [];

    final loading = LoadingDialog.show(this);
    final compressedImage = await _compressImage(image);
    loading.close();

    return compressedImage != null ? [compressedImage] : [];
  }
}

Future<XFile?> _compressImage(XFile file, {bool isSupportAlfa = false}) async {
  final filePath = file.path;
  final splitted = filePath.substring(0, filePath.lastIndexOf('.'));
  if (isSupportAlfa) {
    final outPath = "${splitted}_out.png";
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        file.path, outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
        format: CompressFormat.png);
    return compressedImage;
  } else {
    final outPath = "${splitted}_out.jpeg";
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      minWidth: 1000,
      minHeight: 1000,
      quality: 50,
    );
    return compressedImage;
  }
}

extension ThemeEx on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
}

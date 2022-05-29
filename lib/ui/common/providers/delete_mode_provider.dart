import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeleteModeProvider with ChangeNotifier {

  void setIsDeleteMode(bool isDeleteMode) {
    _deleteMode = isDeleteMode;
    notifyListeners();
  }

  bool _deleteMode = false;

  bool get isDeleteMode => _deleteMode;
}
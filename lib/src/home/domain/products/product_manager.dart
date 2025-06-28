import 'package:buytx/src/home/data/product.dart';
import 'package:flutter/widgets.dart';

enum ManagerState { initial, editting, failure, done }

class ProductManager extends ValueNotifier<Product> {
  ProductManager(super.value);
  //Hold any message the user should be aware of.
  String? _message;
  String? get message {
    String? tmp = _message;
    _message = null;
    return _message;
  }

  
}

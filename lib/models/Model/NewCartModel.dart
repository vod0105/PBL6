import 'package:android_project/models/Model/CartModel.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';

class NewCartModel {
  StoresItem? storeItem;
  List<CartData>? cartData;

  NewCartModel({
    this.storeItem,
    this.cartData
  });
}
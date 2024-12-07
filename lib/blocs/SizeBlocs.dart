import 'dart:async';

class Sizeblocs {
  int _size = 1;
  final sizeController = StreamController<int>.broadcast();
  Stream<int> get sizeStream => sizeController.stream;
  sizeBloc() {
    sizeController.sink.add(_size);
  }

  void setSizeStr(String newSize) {
    if (newSize == "M") {
      sizeController.sink.add(1);
    } else if (newSize == "L") {
      sizeController.sink.add(2);
    } else if (newSize == "XL") {
      sizeController.sink.add(3);
    }
  }

  void setSize(int newSize) {
    sizeController.sink.add(newSize);
    _size = newSize;
  }

  int getSize() {
    return _size;
  }

  int getNewPrice(int price) {
    return price + (_size - 1) * 10000;
  }

  void dispose() {
    sizeController.close();
  }
}

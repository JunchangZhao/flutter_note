import 'dart:async';

abstract class BaseViewModel<T> {
  StreamController streamController = StreamController<T>.broadcast();

  Stream<T> get outDatas => streamController.stream.map((data) {
        return data;
      });

  initDatas();

  dispose() {
    streamController.close();
  }
}

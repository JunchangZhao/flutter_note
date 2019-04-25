import 'dart:async';

abstract class BaseViewModel<T, K> {
  StreamController streamController = StreamController<K>.broadcast();

  Stream<T> get outDatas => streamController.stream.map((data) {
        return data;
      });

  initDatas();

  dispose() {
    streamController.close();
  }
}

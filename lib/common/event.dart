import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class SortChangeEvent {}

class FontChangeEvent {
  int fontType;

  FontChangeEvent(this.fontType);
}

class CompressEvent {
  bool flag;

  CompressEvent(this.flag);
}

class PullNoteEvent {}

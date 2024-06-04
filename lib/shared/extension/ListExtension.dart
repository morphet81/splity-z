extension Listextension on List {
  void removeAll(List items) {
    items.toList().forEach((item) => this.remove(item));
  }
}

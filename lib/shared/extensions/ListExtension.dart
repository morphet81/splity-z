extension Listextension on List {
  void removeAll(List items) {
    items.toList().forEach((item) => this.remove(item));
  }

  void replace(dynamic item, dynamic newItem) {
    final index = this.indexOf(item);
    this.removeAt(index);
    this.insert(index, newItem);
  }

  bool containsAny(List<dynamic> elements) {
    bool containsAny = false;

    this.forEach((el) {
      if (elements.contains(el)) {
        containsAny = true;
      }
    });

    return containsAny;
  }
}

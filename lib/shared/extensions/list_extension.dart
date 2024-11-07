extension Listextension on List {
  void removeAll(List items) {
    items.toList().forEach((item) => remove(item));
  }

  void replace(dynamic item, dynamic newItem) {
    final index = indexOf(item);

    if (index >= 0) {
      removeAt(index);
      insert(index, newItem);
    }
  }

  bool containsAny(List<dynamic> elements) {
    bool containsAny = false;

    forEach((el) {
      if (elements.contains(el)) {
        containsAny = true;
      }
    });

    return containsAny;
  }
}

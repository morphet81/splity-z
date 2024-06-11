import 'package:flutter/material.dart';

class SelectableIcon extends StatefulWidget {
  const SelectableIcon({required this.icon, required this.onChange, super.key});

  final IconData icon;
  final void Function(bool) onChange;

  @override
  State<SelectableIcon> createState() => _SelectableIconState();
}

class _SelectableIconState extends State<SelectableIcon> {
  bool _isSelected = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.onChange(!_isSelected);

        setState(() {
          _isSelected = !_isSelected;
        });
      },
      icon: Icon(
        widget.icon,
        color: _isSelected ? Colors.black : Colors.grey,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SelectButtonsWidget extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  const SelectButtonsWidget({super.key, this.onChanged});

  @override
  State<SelectButtonsWidget> createState() => _SelectButtonsWidgetState();
}

class _SelectButtonsWidgetState extends State<SelectButtonsWidget> {
  bool _isFirst = true;

  void _toggle(bool value) {
    if (_isFirst != value) {
      setState(() => _isFirst = value);
      widget.onChanged?.call(value);
    }
  }

  ButtonStyle _buttonStyle(bool isActive) => FilledButton.styleFrom(
    backgroundColor: isActive ? Colors.deepPurple : Colors.deepPurple.shade50,
    foregroundColor: isActive ? Colors.white : Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton(
            onPressed: () => _toggle(true),
            style: _buttonStyle(_isFirst),
            child: const Text('Подписки'),
          ),
          FilledButton(
            onPressed: () => _toggle(false),
            style: _buttonStyle(!_isFirst),
            child: const Text('Подписчики'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  bool value;
  void Function(bool value) onChanged;
  CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.value,
      activeColor: Colors.green,
      onChanged: widget.onChanged,
    );
  }
}
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    required this.text,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final String text;
  final ValueChanged<String> onChanged;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        hintText: 'Что будем искать?',
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      onChanged: widget.onChanged,
    );
  }
}

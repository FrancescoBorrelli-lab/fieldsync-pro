import 'package:flutter/material.dart';

class TagsInput extends StatefulWidget {
  final List<String> initialTags;
  final Function(List<String>) onTagsChanged;

  const TagsInput({
    super.key,
    this.initialTags = const [],
    required this.onTagsChanged,
  });

  @override
  State<TagsInput> createState() => _TagsInputState();
}

class _TagsInputState extends State<TagsInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.initialTags);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    final trimmed = tag.trim();
    if (trimmed.isNotEmpty && !_tags.contains(trimmed)) {
      setState(() {
        _tags.add(trimmed);
        widget.onTagsChanged(_tags);
      });
      _controller.clear();
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
      widget.onTagsChanged(_tags);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Campo di input
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  labelText: 'Aggiungi tag',
                  hintText: 'Inserisci un tag e premi Invio',
                  prefixIcon: Icon(Icons.label),
                  suffixIcon: Icon(Icons.add_circle_outline),
                ),
                onSubmitted: _addTag,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _addTag(_controller.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(12),
              ),
              child: const Icon(Icons.add, size: 24),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Tags visualizzati
        if (_tags.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tags.map((tag) {
              return Chip(
                label: Text(
                  tag,
                  style: const TextStyle(fontSize: 13),
                ),
                onDeleted: () => _removeTag(tag),
                deleteIcon: const Icon(Icons.close, size: 16),
                backgroundColor: Colors.blue.shade50,
                deleteIconColor: Colors.blue.shade700,
                side: BorderSide(color: Colors.blue.shade200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
              );
            }).toList(),
          ),
      ],
    );
  }
}
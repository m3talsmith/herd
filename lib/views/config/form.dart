import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/config.dart';
import '../../providers/configs.dart';

class ConfigForm extends ConsumerStatefulWidget {
  const ConfigForm({super.key, this.config});

  final Config? config;

  @override
  ConsumerState<ConfigForm> createState() => _ConfigFormState();
}

class _ConfigFormState extends ConsumerState<ConfigForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();

  submit(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    messenger.clearSnackBars();

    if (_nameController.text.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Name is required')),
      );
      return;
    }

    if (_contentController.text.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Config YAML is required')),
      );
      return;
    }

    Config? config;
    if (widget.config != null) {
      widget.config!
        ..name = _nameController.text
        ..description = _descriptionController.text
        ..content = _contentController.text;
      config =
          await ref.read(configsProvider.notifier).updateConfig(widget.config!);
      if (config == null) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Failed to update config')),
        );
        return;
      }
    } else {
      final newConfig = Config(
        name: _nameController.text,
        description: _descriptionController.text,
        content: _contentController.text,
      );
      config = await ref.read(configsProvider.notifier).createConfig(newConfig);
      if (config == null) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Failed to create config')),
        );
        return;
      }
    }
    navigator.pop(config);
  }

  @override
  void initState() {
    super.initState();
    if (widget.config != null) {
      _nameController.text = widget.config!.name ?? '';
      _descriptionController.text = widget.config!.description ?? '';
      _contentController.text = widget.config!.content ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(8),
                  prefixIcon: const Icon(Icons.text_fields),
                ),
                onSubmitted: (value) => submit(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(8),
                  prefixIcon: const Icon(Icons.text_fields),
                ),
                onSubmitted: (value) => submit(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _contentController,
                maxLines: 11,
                decoration: InputDecoration(
                  labelText: 'Config YAML',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(8),
                  prefixIcon: const Icon(Icons.code_rounded),
                ),
                onSubmitted: (value) => submit(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        label: const Text('Cancel'),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          iconColor: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () => submit(context),
                        icon: const Icon(Icons.save),
                        label:
                            Text(widget.config != null ? 'Update' : 'Create'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:uuid/uuid.dart';
import 'dart:html' as html;
import '../../controllers/management_controller.dart';

class AddManagementPage extends StatefulWidget {
  const AddManagementPage({super.key});

  @override
  State<AddManagementPage> createState() => _AddManagementPageState();
}

class _AddManagementPageState extends State<AddManagementPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _bioController = TextEditingController();
  final _controller = Get.find<ManagementController>();
  html.File? _selectedImage;
  String? _imagePreviewUrl;

  Future<void> _pickImage() async {
    try {
      final media = await ImagePickerWeb.getImageAsBytes();
      if (media != null) {
        setState(() {
          _selectedImage = html.File([media], 'image.png');
          _imagePreviewUrl = Uri.dataFromBytes(media, mimeType: 'image/png').toString();
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _submitManagement() async {
    if (!_formKey.currentState!.validate()) return;

    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl = await _controller.uploadImage(_selectedImage!);
    }

    final management = {
      'id': const Uuid().v4(),
      'name': _nameController.text.trim(),
      'position': _positionController.text.trim(),
      'bio': _bioController.text.trim(),
      'image_url': imageUrl,
    };

    await _controller.addManagement(management);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Management Member'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_imagePreviewUrl != null)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.network(
                      _imagePreviewUrl!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => setState(() {
                        _selectedImage = null;
                        _imagePreviewUrl = null;
                      }),
                    ),
                  ],
                )
              else
                OutlinedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text('Add Profile Photo'),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(
                  labelText: 'Position',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter position';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter bio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: Obx(() => ElevatedButton(
                  onPressed: _controller.isLoading.value || _controller.isUploading.value
                      ? null
                      : _submitManagement,
                  child: _controller.isLoading.value || _controller.isUploading.value
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('ADD MEMBER'),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _bioController.dispose();
    super.dispose();
  }
} 
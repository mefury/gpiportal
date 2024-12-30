import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:uuid/uuid.dart';
import 'dart:html' as html;
import '../../controllers/instructor_controller.dart';
import '../../models/instructor.dart';

class AddInstructorPage extends StatefulWidget {
  final Instructor? instructor;
  const AddInstructorPage({super.key, this.instructor});

  @override
  State<AddInstructorPage> createState() => _AddInstructorPageState();
}

class _AddInstructorPageState extends State<AddInstructorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _controller = Get.find<InstructorController>();
  html.File? _selectedImage;
  String? _imagePreviewUrl;
  final _formFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.instructor != null) {
      _nameController.text = widget.instructor!.name;
      _positionController.text = widget.instructor!.position;
      _phoneController.text = widget.instructor!.phone;
      _emailController.text = widget.instructor!.email;
      if (widget.instructor!.imageUrl != null) {
        _imagePreviewUrl = widget.instructor!.imageUrl;
      }
    }
  }

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

  Future<void> _submitInstructor() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      String? imageUrl = _imagePreviewUrl;
      if (_selectedImage != null) {
        imageUrl = await _controller.uploadImage(_selectedImage!);
        if (imageUrl == null) return;
      }

      final instructor = {
        'id': widget.instructor?.id ?? const Uuid().v4(),
        'name': _nameController.text.trim(),
        'position': _positionController.text.trim(),
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'image_url': imageUrl ?? widget.instructor?.imageUrl,
      };

      if (widget.instructor != null) {
        await _controller.updateInstructor(instructor);
      } else {
        await _controller.addInstructor(instructor);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save instructor: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(widget.instructor != null ? 'Edit Instructor' : 'Add Instructor'),
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
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(_imagePreviewUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => setState(() {
                              _selectedImage = null;
                              _imagePreviewUrl = null;
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    child: OutlinedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.add_photo_alternate),
                      label: const Text('Add Profile Photo'),
                      style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                focusNode: _formFocus,
                autofocus: false,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter instructor name';
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
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email address';
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
                      : _submitInstructor,
                  child: _controller.isLoading.value || _controller.isUploading.value
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        )
                      : Text(widget.instructor != null ? 'UPDATE' : 'ADD INSTRUCTOR'),
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
    _phoneController.dispose();
    _emailController.dispose();
    _formFocus.dispose();
    super.dispose();
  }
} 
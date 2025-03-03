import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog extends StatefulWidget {
  final Function(String) onImageSelected;

  const ImagePickerDialog({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<ImagePickerDialog> createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  String _imageToBase64(File image) {
    final bytes = image.readAsBytesSync();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Image',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (_image != null) ...[
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: FileImage(_image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.black,
                      size: 15,
                    ),
                    label: const Text(
                      'Gallery',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 45),
                      backgroundColor: Colors.deepOrange.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 15,
                    ),
                    label: const Text(
                      'Camera',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 45),
                      backgroundColor: Colors.deepOrange.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _image == null
                      ? null
                      : () {
                          final base64Image = _imageToBase64(_image!);
                          widget.onImageSelected(base64Image);
                          Navigator.of(context).pop();
                        },
                  child: const Text('Use Image'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
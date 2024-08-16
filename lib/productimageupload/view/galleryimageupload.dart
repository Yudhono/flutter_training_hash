import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_shop/productimageupload/bloc/productimageupload_bloc.dart';

class GalleryImageUploadView extends StatefulWidget {
  const GalleryImageUploadView({super.key});

  @override
  _GalleryImageUploadViewState createState() => _GalleryImageUploadViewState();
}

class _GalleryImageUploadViewState extends State<GalleryImageUploadView> {
  XFile? _imageFromGallery;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFromGallery = image;
    });

    if (image != null) {
      context.read<ProductImageUploadBloc>().add(
            ProductImageUploadRequested(File(image.path), ImageSource.gallery),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _pickImageFromGallery,
          icon: const Icon(Icons.photo),
          label: const Text('Gallery'),
        ),
        const SizedBox(height: 10),
        if (_imageFromGallery != null)
          Image.file(
            File(_imageFromGallery!.path),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        BlocBuilder<ProductImageUploadBloc, ProductImageUploadState>(
          builder: (context, state) {
            if (state is ProductImageUploadLoading) {
              return const CircularProgressIndicator();
            } else if (state is ProductImageUploadSuccess) {
              return const Text('Upload Successful');
            } else if (state is ProductImageUploadFailure) {
              return Text('Upload Failed');
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

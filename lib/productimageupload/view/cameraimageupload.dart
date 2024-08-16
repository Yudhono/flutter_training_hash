import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_shop/productimageupload/bloc/productimageupload_bloc.dart';

class CameraImageUploadView extends StatefulWidget {
  const CameraImageUploadView({Key? key}) : super(key: key);

  @override
  _CameraImageUploadViewState createState() => _CameraImageUploadViewState();
}

class _CameraImageUploadViewState extends State<CameraImageUploadView> {
  XFile? _imageFromCamera;

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFromCamera = image;
    });

    if (image != null) {
      context.read<ProductImageUploadBloc>().add(
            ProductImageUploadRequested(File(image.path), ImageSource.camera),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _pickImageFromCamera,
          icon: const Icon(Icons.camera),
          label: const Text('Camera'),
        ),
        const SizedBox(height: 10),
        if (_imageFromCamera != null)
          Image.file(
            File(_imageFromCamera!.path),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        BlocBuilder<ProductImageUploadBloc, ProductImageUploadState>(
          builder: (context, state) {
            if (state is ProductImageUploadLoading) {
              return const CircularProgressIndicator();
            } else if (state is ProductImageUploadSuccess) {
              return Text('Upload Successful');
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_shop/addproduct/bloc/create_product_bloc_bloc.dart';
import 'package:new_shop/addproduct/bloc/create_product_bloc_event.dart';
import 'package:new_shop/addproduct/bloc/create_product_bloc_state.dart';
import 'package:new_shop/productimageupload/bloc/productimageupload_bloc.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  XFile? _imageFromCamera;
  XFile? _imageFromGallery;
  final List<String> _imageLocations = [];

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageFromCamera = image;
      });
      context.read<ProductImageUploadBloc>().add(
            ProductImageUploadRequested(File(image.path), ImageSource.camera),
          );
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFromGallery = image;
      });
      context.read<ProductImageUploadBloc>().add(
            ProductImageUploadRequested(File(image.path), ImageSource.gallery),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ProductImageUploadBloc, ProductImageUploadState>(
          listener: (context, state) {
            if (state is ProductImageUploadSuccess) {
              setState(() {
                _imageLocations.add(state.location);
              });
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickImageFromCamera,
                        icon: const Icon(Icons.camera),
                        label: const Text('Camera'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _pickImageFromGallery,
                        icon: const Icon(Icons.photo),
                        label: const Text('Gallery'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (_imageFromCamera != null)
                    Image.file(
                      File(_imageFromCamera!.path),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  if (_imageFromGallery != null)
                    Image.file(
                      File(_imageFromGallery!.path),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 20),
                  state is CreateProductLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_imageLocations.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please upload at least one image')),
                                );
                                return;
                              }

                              // Ensure each image URL in the array is a string
                              final imageArray = _imageLocations
                                  .map((url) => url.toString())
                                  .toList();

                              final productData = {
                                'title': _titleController.text,
                                'price': _priceController.text,
                                'description': _descriptionController.text,
                                'categoryId': _categoryController.text,
                                'images':
                                    imageArray, // Ensure this is an array of strings
                              };

                              context
                                  .read<CreateProductBloc>()
                                  .add(CreateProductRequest(productData));
                            }
                          },
                          child: const Text('Create Product'),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}

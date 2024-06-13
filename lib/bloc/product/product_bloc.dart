import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:furnix_admin/models/products_model.dart';
import 'package:furnix_admin/repositories/product_repository.dart';
import 'package:furnix_admin/utils/constants/toasts.dart';
import 'package:image_picker/image_picker.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository = ProductRepository();
  
  ProductBloc() : super(ProductInitial()) {
    on<GetImageRequested>(_onGetImageRequested);
    on<CategoryChangeRequested>(_onCategoryChangeRequested);
    on<UploadImageRequested>(_onUploadImageRequested);
    on<AddProductRequested>(_onAddProductRequested);
    on<LoadProductsRequested>(_onLoadProductsRequested);
    on<DeleteProductRequested>(_onDeleteProductRequested);
    on<EditProductButtonClicked> (_onEditProductButtonClicked);
    on<EditProductRequested>(_onEditProductRequested);
  }



  Future<void> _onGetImageRequested(
      GetImageRequested event, Emitter<ProductState> emit) async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image,allowMultiple: false);
      print('picked image $result');
      if (result != null) {
        emit(ProductImageLoading()); // Indicate loading state while uploading
        emit(ProductImagePicked(pickedImage:result.files.first));
      } else {
        toast('Image not selected');
      }
    } catch (error) {
      emit(AddProductError(message: 'Error fetching image: $error'));
    }
  }
  Future<void> _onUploadImageRequested(UploadImageRequested event , Emitter<ProductState> emit) async{
    emit(ProductImageLoading());
    
   final url = await productRepository.uploadImage(event.image);
    emit(ProductImageUploaded(imageUrl: url));
  }
  Future<void> _onCategoryChangeRequested(CategoryChangeRequested event, Emitter<ProductState> emit) async{
    emit(CategoryChanged(category: event.category));
  }


  Future<void> _onAddProductRequested (AddProductRequested event, Emitter<ProductState> emit)async{
    final bool success = await productRepository.addProduct(product: event.product);
    if(success){
      emit(AddProductSuccess());
    }
    else{
      emit(AddProductError(message: 'boolean error $success'));
    }
  }

  Future<void> _onLoadProductsRequested (LoadProductsRequested event, Emitter<ProductState> emit)async{
    emit(ProductsLoading());
    debugPrint('loadProducts Requestedd');
    try {
      final List<ProductsModel>? products = await productRepository.loadProducts();
      
      emit(ProductsLoaded(products:products));
    } catch (e) {
      debugPrint('error fetching $e');
    }
  }

  Future<void> _onDeleteProductRequested (DeleteProductRequested event, Emitter<ProductState> emit) async{
    emit(DeleteProductLoading());
    await productRepository.deleteProduct(productId:event.productId);
    await Future.delayed(const Duration(seconds: 1));
    emit(ProductDeleted());
  }
  Future<void> _onEditProductButtonClicked (EditProductButtonClicked event, Emitter<ProductState> emit) async{
    emit(EditProductPageLoaded(product: event.product));
  }
  Future<void> _onEditProductRequested (EditProductRequested event, Emitter<ProductState> emit) async{
    emit(EditProductLoading());

    await productRepository.editProduct(product: event.product,productId: event.product.productId!);
    emit(EditProductSuccess());
  }
  
}

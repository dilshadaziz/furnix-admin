part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductImageLoading extends ProductState{}
final class AddProductLoading extends ProductState{}
final class ProductImagePicked extends ProductState{
  final PlatformFile pickedImage;

  const ProductImagePicked({required this.pickedImage});
}
final class ProductsLoading extends ProductState{}
final class AddProductError extends ProductState{
  final String message;

  const AddProductError({required this.message});
}

final class CategoryChanged extends ProductState{
  final String category;

  const CategoryChanged({required this.category});
}

final class ProductImageUploaded extends ProductState{
  final String imageUrl;

  const ProductImageUploaded({required this.imageUrl});
}
final class AddProductSuccess extends ProductState{}

final class ProductsLoaded extends ProductState{
  final List<ProductsModel>? products;

  const ProductsLoaded({required this.products});
}

final class ProductDeleted extends ProductState{}
final class DeleteProductLoading extends ProductState{}
final class DeleteProductFailure extends ProductState{
  final String message;

  const DeleteProductFailure({required this.message});
}
final class ProductEdited extends ProductState{}
final class EditProductFailure extends ProductState{}
final class EditProductPageLoaded extends ProductState{
  final ProductsModel product;

  const EditProductPageLoaded({required this.product});
}
final class EditProductLoading extends ProductState{}
final class EditProductSuccess extends ProductState{}
part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class GetImageRequested extends ProductEvent {}

final class AddProductRequested extends ProductEvent {
  final ProductsModel product;
 

  const AddProductRequested({
    required this.product,
    
  });
}

final class CategoryChangeRequested extends ProductEvent{
  final String category;

  const CategoryChangeRequested({required this.category});
}

final class UploadImageRequested extends ProductEvent{
  final PlatformFile image;

  const UploadImageRequested({required this.image});
  
}

final class LoadProductsRequested extends ProductEvent{}

final class DeleteProductRequested extends ProductEvent{
  final String productId;

  const DeleteProductRequested({required this.productId});
}

final class EditProductRequested extends ProductEvent{
  final ProductsModel product;

  const EditProductRequested({required this.product});
}
final class EditProductButtonClicked extends ProductEvent{
  final ProductsModel product;

  const EditProductButtonClicked({required this.product});
}

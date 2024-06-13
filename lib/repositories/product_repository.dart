import 'package:file_picker/file_picker.dart';
import 'package:furnix_admin/models/products_model.dart';
import 'package:furnix_admin/services/product.service.dart';
import 'package:image_picker/image_picker.dart';

class ProductRepository {
  final FirebaseProductService _productService = FirebaseProductService();


  Future<bool>addProduct({required ProductsModel product,}) async{
   return await _productService.addProduct(product: product);
  }

  Future<String> uploadImage (PlatformFile imageFile) async{
     return await _productService.uploadImage(imageFile);
  }
  Future<List<ProductsModel>?> loadProducts()async{
    final List<ProductsModel>? products = await _productService.loadProducts();
    return products;
  }
  Future<void> deleteProduct({required String productId}) async{
    await _productService.deleteProduct(productId:productId);
    
  }
  Future<void> editProduct({required String productId,required ProductsModel product}) async{
    await _productService.editProduct(productId:productId,product:product);
  }
}
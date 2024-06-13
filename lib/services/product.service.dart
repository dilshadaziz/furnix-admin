import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furnix_admin/models/products_model.dart';
import 'package:furnix_admin/utils/constants/firebase_consts.dart';
import 'package:furnix_admin/utils/constants/toasts.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseProductService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> createCollection(
      {required Map<String, dynamic> newProduct}) async {
    final productCollection =
        firebaseFirestore.collection(FirebaseConsts.products);
    final isCollectionExist =
        await productCollection.get().then((snapshot) => snapshot.size > 0);

    if (!isCollectionExist) {
      debugPrint('collection not exists');
      await productCollection.doc().set(newProduct);
      return false;
    }
    return true;
  }

  Future<bool> addProduct({required ProductsModel product}) async {
    try {
      final productCollection =
          firebaseFirestore.collection(FirebaseConsts.products);
      final newProduct = ProductsModel(
        productName: product.productName,
        category: product.category,
        productDescription: product.productDescription,
        price: product.price,
        color: product.color,
        quantity: product.quantity,
        image: product.image,
        imageUrl: product.imageUrl,
      ).toMap();
      final bool isExist = await createCollection(newProduct: newProduct);
      if (isExist) {
        final productRef = await productCollection.add(newProduct);
        debugPrint("added to db");
        return true;
      }
    } catch (e) {
      toast('error adding product $e');
    }
    return true;
  }

  Future<String> uploadImage(PlatformFile imageFile) async {
    try {
      // final Uint8List imageAsUint8 = await imageFile.readAsBytes();
      // final reference = _storage.ref().child('product_images');
      // debugPrint('got the reference $reference');
      // final uploadTask = reference.putData(imageAsUint8);
      // debugPrint('uploaded');
      // final url = await uploadTask.snapshot.ref.getDownloadURL();
      // debugPrint('got the Url $url');
      final ref = firebase_storage.FirebaseStorage.instance
          .ref('images')
          .child(imageFile.name);
      final metaData =
          firebase_storage.SettableMetadata(contentType: 'image/jpg');
      await ref.putData(imageFile.bytes!, metaData);
      debugPrint('put in to the db');
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      toast('Error upoloading image $e');
      debugPrint('$e');
    }
    return '';
  }

  Future<List<ProductsModel>?> loadProducts() async {
    final productsCollectionRef =
        firebaseFirestore.collection(FirebaseConsts.products);

    final snapShot = await productsCollectionRef.get();
    List<ProductsModel> products = [];

    if (snapShot.docs.isNotEmpty) {
      for (var doc in snapShot.docs) {
        final product =
            ProductsModel.fromMap(map: doc.data(), productId: doc.id);
        products.add(product);
      }
      return products;
    }
    return null;
  }

  Future<void> deleteProduct({required String productId}) async {
    final productsDocRef =
        firebaseFirestore.collection(FirebaseConsts.products).doc(productId);

    try {
      debugPrint(productId);
      await productsDocRef.delete();
      debugPrint(
          '${firebaseFirestore.collection(FirebaseConsts.products).doc(productId)}}');
      debugPrint('product Deleted');
    } catch (e) {
      debugPrint('error deleting $e');
    }
  }

  Future<void> editProduct({required String productId,required ProductsModel product}) async{
    final productDocRef = firebaseFirestore.collection(FirebaseConsts.products).doc(productId);

    try {
      await productDocRef.update(product.toMap());
    } catch (e) {
      debugPrint('error updating -- $e');
    }
    debugPrint("Product Updated successfully");
  }
}

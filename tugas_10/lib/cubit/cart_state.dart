import 'package:equatable/equatable.dart';
import '../models/product_model.dart';

/// CartItem: menyimpan produk dan jumlahnya di keranjang
class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    this.quantity = 1,
  });

  /// Harga total untuk item ini (harga × quantity)
  double get totalPrice => product.price * quantity;

  /// Copy dengan quantity baru
  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}

/// CartState: state untuk keranjang belanja
class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  /// Jumlah total item di keranjang (termasuk quantity)
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  /// Jumlah jenis produk yang berbeda
  int get totalProducts => items.length;

  /// Total harga semua item di keranjang
  double get totalPrice => items.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Cek apakah produk sudah ada di keranjang
  bool containsProduct(String productId) {
    return items.any((item) => item.product.id == productId);
  }

  /// Ambil quantity produk tertentu di keranjang
  int getQuantity(String productId) {
    final item = items.where((item) => item.product.id == productId);
    return item.isNotEmpty ? item.first.quantity : 0;
  }

  @override
  List<Object?> get props => [items];
}

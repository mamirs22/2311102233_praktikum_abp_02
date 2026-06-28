import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import 'cart_state.dart';

/// CartCubit: mengelola state keranjang belanja
/// Menggunakan Cubit (bagian dari BLoC pattern) untuk state management
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  /// Menambahkan produk ke keranjang
  /// Jika produk sudah ada, quantity akan bertambah 1
  void addToCart(Product product) {
    final currentItems = List<CartItem>.from(state.items);
    final existingIndex =
        currentItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      // Produk sudah ada → tambah quantity
      final existingItem = currentItems[existingIndex];
      currentItems[existingIndex] =
          existingItem.copyWith(quantity: existingItem.quantity + 1);
    } else {
      // Produk baru → tambahkan ke list
      currentItems.add(CartItem(product: product));
    }

    emit(CartState(items: currentItems));
  }

  /// Menghapus satu quantity produk dari keranjang
  /// Jika quantity menjadi 0, produk dihapus dari keranjang
  void removeFromCart(Product product) {
    final currentItems = List<CartItem>.from(state.items);
    final existingIndex =
        currentItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      final existingItem = currentItems[existingIndex];
      if (existingItem.quantity > 1) {
        // Kurangi quantity
        currentItems[existingIndex] =
            existingItem.copyWith(quantity: existingItem.quantity - 1);
      } else {
        // Hapus dari keranjang
        currentItems.removeAt(existingIndex);
      }
      emit(CartState(items: currentItems));
    }
  }

  /// Menghapus produk sepenuhnya dari keranjang (semua quantity)
  void removeProductCompletely(Product product) {
    final currentItems = List<CartItem>.from(state.items);
    currentItems.removeWhere((item) => item.product.id == product.id);
    emit(CartState(items: currentItems));
  }

  /// Mengosongkan seluruh keranjang
  void clearCart() {
    emit(const CartState());
  }
}

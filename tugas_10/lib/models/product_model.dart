import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final double price;
  final String description;
  final String emoji; // Menggunakan emoji sebagai ikon produk

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.emoji,
  });

  @override
  List<Object?> get props => [id, name, price, description, emoji];
}

// Data dummy produk (minimal 5 produk)
final List<Product> dummyProducts = [
  const Product(
    id: '1',
    name: 'Smartphone Pro',
    price: 8999000,
    description: 'Smartphone flagship dengan kamera 108MP dan layar AMOLED 6.7"',
    emoji: '📱',
  ),
  const Product(
    id: '2',
    name: 'Laptop Ultra',
    price: 15499000,
    description: 'Laptop tipis dan ringan dengan prosesor terbaru dan RAM 16GB',
    emoji: '💻',
  ),
  const Product(
    id: '3',
    name: 'TWS Earbuds',
    price: 1299000,
    description: 'Earbuds wireless dengan ANC dan battery life 30 jam',
    emoji: '🎧',
  ),
  const Product(
    id: '4',
    name: 'Smartwatch Elite',
    price: 3499000,
    description: 'Smartwatch dengan sensor kesehatan lengkap dan GPS built-in',
    emoji: '⌚',
  ),
  const Product(
    id: '5',
    name: 'Tablet Pro',
    price: 7999000,
    description: 'Tablet 11" dengan stylus support dan performa desktop-class',
    emoji: '📲',
  ),
  const Product(
    id: '6',
    name: 'Mechanical Keyboard',
    price: 1899000,
    description: 'Keyboard mekanikal RGB dengan switch Cherry MX dan hot-swappable',
    emoji: '⌨️',
  ),
  const Product(
    id: '7',
    name: 'Wireless Mouse',
    price: 899000,
    description: 'Mouse wireless ergonomis dengan sensor 25K DPI dan koneksi tri-mode',
    emoji: '🖱️',
  ),
  const Product(
    id: '8',
    name: 'USB-C Hub',
    price: 599000,
    description: 'Hub USB-C 7-in-1 dengan HDMI 4K, USB 3.0, dan SD card reader',
    emoji: '🔌',
  ),
];

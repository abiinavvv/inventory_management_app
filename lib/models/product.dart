class Product {
  final String productId; // 5-DIGIT PRODUCT ID
  final String productName;
  final String description;
  final String imageUrl;
  final DateTime firstInventoryDate;
  final String supervisorName;
  final int currentStock;

  Product({
    required this.productId,
    required this.productName,
    required this.description,
    required this.imageUrl,
    required this.firstInventoryDate,
    required this.supervisorName,
    required this.currentStock,
  }) {
    // VALIDATION FOR SEARCHING

    if (productId.length != 5) {
      throw ArgumentError('Product ID must be 5 characters long');
    }
    if (!RegExp(r'^[a-zA-Z0-9]{5}$').hasMatch(productId)) {
      throw ArgumentError('Product ID must only contain letters and numbers');
    }
  }

  // CREATING PRODUCT FROM JSON

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      firstInventoryDate: json['firstInventoryDate'] != null
          ? DateTime.parse(json['firstInventoryDate'])
          : DateTime.now(),
      supervisorName: json['supervisorName'] ?? '',
      currentStock: json['currentStock'] ?? 0,
    );
  }

  // CONVERTING PRODUCT TO JSON

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'description': description,
      'imageUrl': imageUrl,
      'firstInventoryDate': firstInventoryDate.toIso8601String(),
      'supervisorName': supervisorName,
      'currentStock': currentStock,
    };
  }

  // CREATING COPY WITH CHANGES

  Product copyWith({
    String? productId,
    String? productName,
    String? description,
    String? imageUrl,
    DateTime? firstInventoryDate,
    String? supervisorName,
    int? currentStock,
  }) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      firstInventoryDate: firstInventoryDate ?? this.firstInventoryDate,
      supervisorName: supervisorName ?? this.supervisorName,
      currentStock: currentStock ?? this.currentStock,
    );
  }

  // INVENTORY FORMAT

  String get formattedInventoryDate {
    return '${firstInventoryDate.day}/${firstInventoryDate.month}/${firstInventoryDate.year}';
  }
}

// SAMPLE PRODUCT DETAILS (THIS IS HARDCODED BECAUSE I HAVEN'T INTEGRATED DATABASE) //


final List<Product> sampleProducts = [
  Product(
    productId: "AB123",
    productName: "Sample Product",
    description: "Sample description of the product",
    imageUrl: "assets/drone.png",
    firstInventoryDate: DateTime(2024, 1, 15),
    supervisorName: "John Smith",
    currentStock: 50,
  ),
  Product(
    productId: "XY789",
    productName: "Sample Product",
    description: "Sample description of the product",
    imageUrl: "assets/iPhone.png",
    firstInventoryDate: DateTime(2024, 2, 1),
    supervisorName: "Sarah Johnson",
    currentStock: 30,
  ),
  Product(
    productId: 'ACD12',
    productName: "Sample Product",
    description: "Sample description of the product",
    imageUrl: "assets/headPhone.png",
    firstInventoryDate: DateTime(2024, 1, 15),
    supervisorName: "will smith ",
    currentStock: 50,
  ),
  Product(
      productId: 'ACC32',
      productName: "Sample Product",
      description: "Sample description of the product",
      imageUrl: "assets/watch.png",
      firstInventoryDate: DateTime(2024, 1, 15),
      supervisorName: "will smith ",
      currentStock: 50),
  Product(
      productId: 'AJK54',
      productName: "Sample Product",
      description: "Sample description of the product",
      imageUrl: "assets/speaker.png",
      firstInventoryDate: DateTime(2024, 1, 15),
      supervisorName: "will smith ",
      currentStock: 50)
];

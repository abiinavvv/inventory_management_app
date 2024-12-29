import 'package:flutter/material.dart';
import 'package:inventory_management/screens/product_detail_page.dart';
import 'package:inventory_management/models/product.dart';
import 'package:inventory_management/screens/user_profile.dart';

class InventoryListScreen extends StatefulWidget {
  const InventoryListScreen({super.key});

  @override
  State<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen>
    with SingleTickerProviderStateMixin {
  bool isDarkMode = false;

// ANIMATION CONTROLLER //

  late AnimationController _animationController;
  late Animation<double> _iconTurns;
  List<Product> products = sampleProducts;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }
  // CONTROLLER WILL BE DISPOSED //
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //PRODUCT STOCK UPDATION FUNCTION //

  void updateProductStock(String productId, int newStock) {
    setState(() {
      final productIndex = products.indexWhere((p) => p.productId == productId);
      if (productIndex != -1) {
        final updatedProduct = Product(
            productId: products[productIndex].productId,
            productName: products[productIndex].productName,
            description: products[productIndex].description,
            imageUrl: products[productIndex].imageUrl,
            firstInventoryDate: products[productIndex].firstInventoryDate,
            supervisorName: products[productIndex].supervisorName,
            currentStock: newStock);
        products[productIndex] = updatedProduct;
      }
    });
  }

  // THEME TOGGLE FUNCTION //

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      if (isDarkMode) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  // SEARCH FUNCTIONALITY //

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  List<Product> get filteredProducts {
    if (searchQuery.isEmpty) return products;
    return products.where((product) {
      return product.productName.toLowerCase().contains(searchQuery) ||
          product.productId.toLowerCase().contains(searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: isDarkMode
          ? ThemeData.dark().copyWith(
              primaryColor: const Color(0xFF0D47A1),
              scaffoldBackgroundColor: Colors.grey[900],
            )
          : ThemeData.light().copyWith(
              primaryColor: const Color(0xFF0D47A1),
              scaffoldBackgroundColor: Colors.grey[100],
            ),
      duration: const Duration(milliseconds: 300),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
  centerTitle: true,
  title: const Text(
    'AlgoBotix',
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  backgroundColor: const Color(0xFF0D47A1),
  leading: Builder(builder: (context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(Icons.menu, color: Colors.white),
    );
  }),
  actions: [
    IconButton(
      icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('QR coming soon',
            style: TextStyle(color: Colors.white),),
            backgroundColor: Color(0xFF0D47A1),
            duration: Duration(seconds: 2),
          ),
        );
      },
    ),
    const SizedBox(width: 8), 
  ],
),
drawer: AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  color: isDarkMode ? Colors.grey[850] : Colors.white,
  child: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: Color(0xFF0D47A1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // NAVIGATION TO USER PROFILE 
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfilePage(), // You'll need to create this page
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: const Icon(
                          Icons.person,
                          size: 35,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Abiinavvv', 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Admin',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                'Tap to view profile',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.admin_panel_settings,
            color: isDarkMode ? Colors.white70 : Colors.grey[700],
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
            ),
            child: const Text('Admin Dashboard'),
          ),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: Icon(
            Icons.manage_accounts,
            color: isDarkMode ? Colors.white70 : Colors.grey[700],
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
            ),
            child: const Text('Manager Dashboard'),
          ),
          onTap: () => Navigator.pop(context),
        ),
      ],
    ),
  ),
),

// COLUMN FOR BUILDING THE WIDGETS

          body: Column(
            children: [
              Container(
                color: const Color(0xFF0D47A1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Inventory List',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: _toggleTheme,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  RotationTransition(
                                    turns: _iconTurns,
                                    child: Icon(
                                      isDarkMode
                                          ? Icons.light_mode
                                          : Icons.dark_mode,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Text(
                                      isDarkMode ? 'Light' : 'Dark',
                                      key: ValueKey<bool>(isDarkMode),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.grey[850]!.withValues()
                              : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.black.withValues()
                                  : Colors.grey.withValues(),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Material(
                            color: Colors.transparent,
                            child: TextField(
                              onChanged: _filterProducts,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: 15,
                              ),
                              cursorColor: const Color(0xFF0D47A1),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Icon(
                                      Icons.search_rounded,
                                      key: ValueKey<bool>(isDarkMode),
                                      color: isDarkMode
                                          ? Colors.grey[400]
                                          : const Color(0xFF0D47A1),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                suffixIcon: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Icon(
                                      Icons.mic_rounded,
                                      key: ValueKey<bool>(isDarkMode),
                                      color: isDarkMode
                                          ? Colors.grey[400]
                                          : Colors.grey[600],
                                      size: 22,
                                    ),
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: 'Search products...',
                                hintStyle: TextStyle(
                                  color: isDarkMode
                                      ? Colors.grey[500]
                                      : Colors.grey[400],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: isDarkMode
                                        ? const Color(0xFF0D47A1).withValues()
                                        : const Color(0xFF0D47A1),
                                    width: 1.5,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) => _buildAnimatedProductCard(
                    product: filteredProducts[index],
                  ),
                ),
              ),
            ],
          ),

          //FLOATING ACTION BUTTON FOR PRODUCT ADDING //


          floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            backgroundColor: const Color(0xFF0D47A1),
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
  
  // PRODUCT CARD WIDGET //

  Widget _buildAnimatedProductCard({required Product product}) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                product: product,
                onStockUpdate: updateProductStock,
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withValues()
                    : Colors.grey.withValues(),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      child: Text('#${product.productId}'),
                    ),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      child: Text('Stock : ${product.currentStock}'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(product.imageUrl, height: 100,
                      errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 64,
                      color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      child: Text(
                        product.productName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[900],
                      ),
                      child: Text('SuperVisor : ${product.supervisorName}'),
                    ),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[900],
                      ),
                      child: Text('Added : ${product.firstInventoryDate}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

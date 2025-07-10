class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _cartViewed = true; // Commence comme "vu"

  final List<Widget> _screens = [
    RestautListScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cart = Provider.of<CartRepository>(context);
    cart.removeListener(_cartListener); // évite les doublons
    cart.addListener(_cartListener);
  }

  void _cartListener() {
    if (_currentIndex != 1) {
      setState(() {
        _cartViewed = false;
      });
    }
  }

  @override
  void dispose() {
    Provider.of<CartRepository>(context, listen: false).removeListener(_cartListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartRepository>();
    final hasNew = cart.count > 0 && !_cartViewed;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFFF002B),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 1) _cartViewed = true;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_bag),
                if (hasNew)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                      child: const Text('', style: TextStyle(fontSize: 8)),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
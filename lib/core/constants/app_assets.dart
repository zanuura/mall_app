class AppAssets {
  // icons bottom nav
  static const String icHome = 'assets/Nav Icon - Home.png';
  static const String icHomeActive = 'assets/Nav Icon - Home Green.png';
  static const String icMall = 'assets/Nav Icon - Mall.png';
  static const String icMallActive = 'assets/Nav Icon - Mall Green.png';
  static const String icDiscover = 'assets/Nav Icon - Discover.png';
  static const String icInbox = 'assets/Nav Icon - Inbox.png';
  static const String icAccount = 'assets/Nav Icon - Account.png';

  // home screen icons
  static const String icCredit =
      'assets/Icon -Location.png'; // Assuming a placeholder for credit icon. Let's use image_57657e.png assets names for clarity on home screen items.
  static const String icCalendar = 'assets/Icon - Calender.png';
  static const String icClock = 'assets/Icon - Clock.png';
  static const String icLocation = 'assets/Icon - Location.png';
  static const String icArrowRight = 'assets/Icon -Arrow.png';

  // image banner/product
  static const String imgHomeBanner = 'assets/Home Banner.jpg';
  static const String imgProductPlaceholder =
      'assets/Image.jpg'; // Placeholder for product image
  static const String imgTrendingDiscoveries =
      'assets/Trending Discoveries.jpg';

  // shop plant icons (home screen categories)
  static const String icShopPlant1 = 'assets/Button - Icon 1.png';
  static const String icShopPlant2 = 'assets/Button - Icon 2.png';
  static const String icShopPlant3 = 'assets/Button - Icon 3.png';
  static const String icShopPlant4 = 'assets/Button - Icon 4.png';
  static const String icShopPlant5 = 'assets/Button - Icon 5.png';

  // button labels (for PrimaryButton in Home)
  static const String btnShop = 'assets/Button - Shop.png';
  static const String btnServices = 'assets/Button - Services.png';
  static const String btnPosts = 'assets/Button - Posts.png';

  // mall screen icons
  static const String icSearch = 'assets/Icon - Search.png';
  static const String icFilter = 'assets/Icon - Filter.png';

  static const String icShopPlantLogo = 'assets/Shop Plants - Icon Main.png';

  // bottom nav items (update original definition if necessary to use active icon)
  // Re-defining for consistency:
  static const Map<String, String> bottomNavIcons = {
    'HOME': icHome,
    'MALL': icMall,
    'DISCOVER': icDiscover,
    'INBOX': icInbox,
    'ACCOUNT': icAccount,
  };

  static const Map<String, String> bottomNavActiveIcons = {
    'HOME': icHomeActive,
    'MALL': icMallActive,
    'DISCOVER': icDiscover, // Assuming no green version for others
    'INBOX': icInbox,
    'ACCOUNT': icAccount,
  };
}

// Catatan: Jika Anda tidak memindahkan icons ke folder 'assets/icons/', Anda harus menghapus '/icons/' dari path di AppAssets.dart

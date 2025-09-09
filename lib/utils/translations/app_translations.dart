import 'package:get/get.dart';

/// Application translations for English (en_US) and Indonesian (id_ID)
///
/// This class provides localized strings for the EcoWaste app.
///
/// SECTIONS INCLUDED:
/// ==================
/// • Global & Common Texts
/// • Onboarding Screens
/// • Authentication (Forms & Screen Titles)
/// • Navigation & Home
/// • Settings & Configuration
/// • Admin Panel
/// • User Profile & Account
/// • Common Actions & UI Elements
/// • Waste Management (Deposit, Collection, etc.)
/// • Shopping & Exchange
/// • Validation Messages
/// • Error Messages
/// • Network & Error Messages
///
/// USAGE:
/// ======
/// Use with GetX internationalization:
/// ```dart
/// Text('loginTitle'.tr)
/// ```
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': _englishTranslations,
    'id_ID': _indonesianTranslations,
  };

  /// English translations (en_US)
  /// Contains all English text strings used throughout the EcoWaste application
  static const Map<String, String> _englishTranslations = {
    // ═══════════════════════════════════════════════════════════════════════
    // GLOBAL & COMMON TEXTS
    // ═══════════════════════════════════════════════════════════════════════
    'and': 'and',
    'skip': 'Skip',
    'done': 'Done',
    'submit': 'Submit',
    'appName': 'GreenApps',
    'continue': 'Continue',

    // ═══════════════════════════════════════════════════════════════════════
    // ONBOARDING SCREENS
    // ═══════════════════════════════════════════════════════════════════════
    'onBoardingTitle1': 'Reduce Waste,\nSave the Planet!',
    'onBoardingTitle2': 'Recycle Smarter,\nLive Better!',
    'onBoardingTitle3': 'Earn Rewards,\nMake a Difference!',
    'onBoardingSubTitle1':
        'Join the green revolution! Every small action you take helps protect our beautiful planet for future generations.',
    'onBoardingSubTitle2':
        'Transform your waste management habits and contribute to building a cleaner, healthier community for everyone.',
    'onBoardingSubTitle3':
        'Earn exciting rewards while making an environmental impact! Turn your eco-friendly actions into valuable benefits.',

    // ═══════════════════════════════════════════════════════════════════════
    // AUTHENTICATION
    // ═══════════════════════════════════════════════════════════════════════

    // Form Fields
    'firstName': 'First Name',
    'lastName': 'Last Name',
    'email': 'Email',
    'password': 'Password',
    'newPassword': 'New Password',
    'username': 'Username',
    'phoneNo': 'Phone Number',
    'rememberMe': 'Remember Me',
    'forgetPassword': 'Forgot Password?',
    'signIn': 'Sign In',
    'createAccount': 'Create Account',
    'orSignInWith': 'or sign in with',
    'orSignUpWith': 'or sign up with',
    'iAgreeTo': 'I agree to the',
    'privacyPolicy': 'Privacy Policy',
    'termsOfUse': 'Terms of Use',
    'verificationCode': 'Verification Code',
    'resendEmail': 'Resend Email',
    'resendEmailIn': 'Resend email in',

    // Screen Titles & Descriptions
    'loginTitle': 'Welcome back!',
    'loginSubTitle': 'Turn your waste into wealth – start earning today!',
    'signupTitle': 'Let\'s get you started!',
    'forgetPasswordTitle': 'Forgot your password?',
    'forgetPasswordSubTitle':
        'No worries! It happens to the best of us. Enter your email address and we\'ll send you a secure password reset link.',
    'changeYourPasswordTitle': 'Password Reset Email Sent Successfully!',
    'changeYourPasswordSubTitle':
        'Your account security is our top priority! We\'ve sent you a secure link to reset your password and keep your account protected.',
    'confirmEmail': 'Verify your email address!',
    'confirmEmailSubTitle':
        'You\'re almost there! Verify your email to unlock exclusive eco-rewards and start making a positive environmental impact.',
    'emailNotReceivedMessage':
        'Didn\'t receive the email? Check your spam folder or tap to resend it.',
    'yourAccountCreatedTitle': 'Welcome to the EcoWaste community!',
    'yourAccountCreatedSubTitle':
        'Your account is ready! Start your eco-journey today and discover how rewarding sustainable living can be.',

    // ═══════════════════════════════════════════════════════════════════════
    // NAVIGATION & HOME
    // ═══════════════════════════════════════════════════════════════════════

    // Home Screen
    'homeAppbarTitle': 'Transform waste into wealth!',
    'homeAppbarSubTitle': 'Reynaldhi T. Graha',

    // Navigation Menu
    'home': 'Home',
    'leaderboard': 'Leaderboard',
    'news': 'News',
    'profile': 'Profile',
    'settings': 'Settings',

    // Screen Titles
    'transactionDetail': 'Transaction Detail',
    'depositDetail': 'Deposit Detail',

    // ═══════════════════════════════════════════════════════════════════════
    // SETTINGS & CONFIGURATION
    // ═══════════════════════════════════════════════════════════════════════

    // Main Settings
    'account': 'Account',
    'accountSettings': 'Account Settings',
    'appSettings': 'App Settings',
    'history': 'History',
    'confirmation': 'Confirmation',
    'address': 'Address',
    'darkMode': 'Dark Mode',
    'language': 'Language',
    'logout': 'Logout',

    // Language Settings
    'english': 'English',
    'indonesian': 'Indonesian',
    'selectLanguage': 'Select Language',
    'languageSettings': 'Language Settings',

    // Settings Descriptions
    'profileSubtitle': 'Manage your personal information',
    'historySubtitle': 'Track your eco-impact journey',
    'confirmationSubtitle': 'Review and confirm deposits',
    'addressSubtitle': 'Find convenient collection locations',
    'darkModeSubtitle': 'Optimize display for your comfort',
    'adjustDisplayAmbientLighting': 'Adjust display for ambient lighting',

    // ═══════════════════════════════════════════════════════════════════════
    // ADMIN PANEL
    // ═══════════════════════════════════════════════════════════════════════

    // Admin Navigation
    'adminPanel': 'Admin Panel',
    'userManagement': 'User Management',
    'reports': 'Reports & Analytics',
    'dashboard': 'Dashboard',

    // Dashboard Stats
    'totalUsers': 'Total Users',
    'wasteCollected': 'Waste Collected',
    'pendingConfirmation': 'Pending Confirmation',
    'pointsToday': 'Points Today',
    'quickActions': 'Quick Actions',
    'recentActivity': 'Recent Activity',
    'viewAll': 'View All',

    // Transaction Status
    'transactions': 'Transactions',
    'all': 'All',
    'confirmed': 'Confirmed',
    'pending': 'Pending',
    'cancelled': 'Cancelled',

    // Admin Actions
    'confirmDeposit': 'Confirm Deposit',
    'manageUsers': 'Manage Users',
    'viewReports': 'View Reports',
    'editRanking': 'Edit Ranking',

    // ═══════════════════════════════════════════════════════════════════════
    // USER PROFILE & ACCOUNT
    // ═══════════════════════════════════════════════════════════════════════
    'editProfile': 'Edit Profile',
    'updateProfile': 'Update Profile',
    'changeProfilePicture': 'Change Profile Picture',
    'name': 'Name',
    'fullName': 'Full Name',
    'village': 'Village',
    'district': 'District',
    'phoneNumber': 'Phone Number',

    // ═══════════════════════════════════════════════════════════════════════
    // COMMON ACTIONS & UI ELEMENTS
    // ═══════════════════════════════════════════════════════════════════════
    'cancel': 'Cancel',
    'confirm': 'Confirm',
    'save': 'Save',
    'delete': 'Delete',
    'yes': 'Yes',
    'no': 'No',
    'okay': 'Okay',
    'loading': 'Loading...',
    'success': 'Success',
    'error': 'Error',
    'warning': 'Warning',

    // ═══════════════════════════════════════════════════════════════════════
    // WASTE MANAGEMENT & DEPOSITS
    // ═══════════════════════════════════════════════════════════════════════

    // Deposit Actions
    'depositWaste': 'Deposit Waste',
    'depositWasteShort': 'Deposit\nWaste',
    'wasteCollection': 'Waste Collection',
    'collect': 'Collect',
    'collectWasteAt': 'Bring your waste to our collection centers',

    // Waste Information
    'wasteType': 'Waste Type',
    'wasteWeight': 'Waste Weight (kg)',
    'temperatureBurning': 'Burning Temperature (°C)',
    'totalPrice': 'Total Price',

    // Photo & Proof
    'depositProof': 'Deposit Proof',
    'takePhoto': 'Take Photo',
    'chooseFromGallery': 'Choose from Gallery',
    'removePhoto': 'Remove Photo',
    'changePhoto': 'Change Photo',
    'tapToUpload': 'Tap to upload photo',
    'uploadProof': 'Upload Photo Proof',
    'takePhotoProof': 'Take photo of waste proof',
    'failedToProcessImage': 'Failed to process image',

    // Transaction Types
    'transactionType': 'Transaction Type',
    'dropOff': 'Drop Off (Deliver)',
    'pickUp': 'Pick Up (Collect)',

    // Points & Rewards
    'points': 'Points',
    'exchangePoints': 'Exchange\nPoints',
    'exchangePointsAction': 'Redeem Points',

    // ═══════════════════════════════════════════════════════════════════════
    // ERROR MESSAGES & VALIDATION
    // ═══════════════════════════════════════════════════════════════════════
    'loginFailed': 'Login Unsuccessful',
    'identityError': 'Authentication Error',
    'failedToProcess': 'Processing failed',
    'failedToSelectImage': 'Image selection failed',
    'noImageSelected': 'Please select an image',
    'failedToCaptureImage': 'Camera capture failed',
    'noImageCaptured': 'No image was captured',
    'failedToLoadRanking': 'Unable to load leaderboard',
    'failedToLoadWasteTypes': 'Unable to load waste categories',
    'errorLoadingWasteTypes': 'Error loading waste categories',
    'successDepositWaste': 'Waste deposited successfully! 🌱',
    'wasteDataSubmitted': 'Great job! Your waste data has been recorded.',
    'failedDepositWaste': 'Deposit unsuccessful',
    'errorDepositingWaste': 'An error occurred during waste deposit',

    // ═══════════════════════════════════════════════════════════════════════
    // SHOPPING & REWARDS
    // ═══════════════════════════════════════════════════════════════════════

    // Cart Management
    'yourCart': 'Your Rewards Cart',
    'cartEmpty': 'Your cart is ready for rewards!',
    'addToCartMessage': 'Browse our eco-rewards and add items to continue.',
    'addToCart': 'Add to Cart',
    'removeAll': 'Clear cart',
    'totalItems': 'Total items:',
    'totalPriceCart': 'Total points:',
    'checkout': 'Redeem Now',
    'addedToCart': 'has been added to cart!',
    'alreadyInCart': 'Already in Cart',
    'isAlreadyInCart': 'is already in your cart.',
    'removedFromCart': 'Removed from Cart',
    'removedFromCartMessage': 'has been removed from cart.',
    'cartCleared': 'Cart Cleared',
    'cartClearedMessage': 'All items have been removed from your cart.',
    'isOutOfStock': 'is currently out of stock.',

    // Product Information
    'stock': 'Stock:',
    'outOfStock': 'Out of Stock',
    'productDescription':
        'Discover amazing eco-rewards! Product details, features, and benefits will be displayed here.',

    // Common UI elements
    'changeImage': 'Change Image',
    'createTransaction': 'Create Transaction',
    'selectDate': 'Select Date',
    'selectWasteTypeFirst': 'Please select waste type first',
    'selectTransactionTypeFirst': 'Please select transaction type first',
    'selectTransactionDate': 'Please select transaction date',
    'selectImage': 'Select Image',
    'noDataFound': 'No Data Found!',
    'somethingWentWrong': 'Something went wrong.',
    'locationDetail': 'Location Detail',
    'tapToSelectDate': 'Tap to select date',
    'enterLocationDetail': 'Enter location detail',
    'viewReport': 'View Report',
    'defaultViewAll': 'View all',

    // Additional validation messages
    'emailRequired': 'Email is required.',
    'invalidEmailAddress': 'Invalid email address.',
    'passwordRequired': 'Password is required.',
    'passwordMinLength': 'Password must be at least 6 characters long.',
    'passwordUppercase': 'Password must contain at least one uppercase letter.',
    'passwordNumber': 'Password must contain at least one number.',
    'passwordSpecialChar':
        'Password must contain at least one special character.',
    'phoneRequired': 'Phone number is required.',
    'invalidPhoneNumber': 'Invalid phone number format (10 digits required).',

    // ═══════════════════════════════════════════════════════════════════════
    // ADDITIONAL FEATURES
    // ═══════════════════════════════════════════════════════════════════════

    // Checkout & Implementation
    'checkoutNotImplemented': 'Checkout feature is not yet implemented.',

    // Tutorial & Onboarding
    'tutorialStep1': 'Step 1: Sort your waste like a pro!',
    'tutorialStep2': 'Step 2: Log each item in the app for maximum impact.',
    'tutorialStep3': 'Step 3: Watch your rewards balance grow!',

    // Missing hardcoded strings found in the app
    'noTransactionHistoryAvailable': 'No transaction history available',
    'yourTransactionsWillAppearHere': 'Your transactions will appear here',
    'noFilteredTransactionsFound': 'No transactions found',
    'trySelectingDifferentFilter': 'Try selecting a different filter',
    'tapToAddImage': 'Tap to add image',
    'loadNewsError': 'Failed to load news',
    'statusNotSuccessful': 'Status not successful',
    'responseNotValid': 'Response not valid',
    'loadingError': 'Loading error',
    'failedToLoadLeaderboard': 'Failed to load leaderboard',
    'failedToTakePhoto': 'Failed to take photo',
    'noPhotoTaken': 'No photo taken',
    'rejected': 'Rejected',
    'failedToLoadTransactionDetails': 'Failed to load transaction details',
    'failedToFetchTransactionDetails': 'Failed to fetch transaction details',
    'failedToLoadTransactions': 'Failed to load transactions',
    'failedToFetchTransactions': 'Failed to fetch transactions',
    'failedToCreateTransaction': 'Failed to create transaction',
    'failedToProcessTransaction': 'Failed to process transaction',
    'failedToCancelTransaction': 'Failed to cancel transaction',
    'failedToFetchUserData': 'Failed to fetch user data',
    'completed': 'Completed',

    // Profile and Settings
    // ═══════════════════════════════════════════════════════════════════════
    // USER PROFILE
    // ═══════════════════════════════════════════════════════════════════════
    'profileInformation': 'Profile Information',
    'rtRw': 'RT/RW',
    'unknown': 'Unknown',
    'kabupatenKota': 'Kabupaten/Kota',

    // ═══════════════════════════════════════════════════════════════════════
    // NETWORK & ERROR MESSAGES
    // ═══════════════════════════════════════════════════════════════════════
    'noInternetConnection': 'Connection Lost - Please Check Your Internet',

    // Camera and gallery
    'takeFromCamera': 'Capture with Camera',
    'selectFromGallery': 'Choose from Gallery',

    // Additional UI strings
    'hello': 'Hello',
    'balance': 'Balance',
    'pointsEarned': 'Points Earned',
    'actualWeight': 'Actual Weight',
    'wib': 'WIB',
    'kg': 'kg',
    'locationInformation': 'Location Information',
  };

  /// Indonesian translations (id_ID)
  /// Contains all Indonesian text strings used throughout the EcoWaste application
  static const Map<String, String> _indonesianTranslations = {
    // ═══════════════════════════════════════════════════════════════════════
    // GLOBAL & COMMON TEXTS
    // ═══════════════════════════════════════════════════════════════════════
    'and': 'dan',
    'skip': 'Lewati',
    'done': 'Selesai',
    'submit': 'Kirim',
    'appName': 'Sobat Sampah',
    'continue': 'Lanjutkan',

    // ═══════════════════════════════════════════════════════════════════════
    // ONBOARDING SCREENS
    // ═══════════════════════════════════════════════════════════════════════
    'onBoardingTitle1': 'Kurangi Sampah,\nSelamatkan Planet!',
    'onBoardingTitle2': 'Daur Ulang Lebih Pintar,\nHidup Lebih Baik!',
    'onBoardingTitle3': 'Dapatkan Hadiah,\nBuat Perbedaan!',
    'onBoardingSubTitle1':
        'Bergabunglah dalam revolusi hijau! Setiap aksi kecil Anda membantu melindungi planet indah kita untuk generasi mendatang.',
    'onBoardingSubTitle2':
        'Transformasikan kebiasaan pengelolaan sampah Anda dan berkontribusi membangun komunitas yang lebih bersih dan sehat.',
    'onBoardingSubTitle3':
        'Raih hadiah menarik sambil memberikan dampak lingkungan! Ubah aksi ramah lingkungan Anda menjadi manfaat berharga.',

    // ═══════════════════════════════════════════════════════════════════════
    // AUTHENTICATION
    // ═══════════════════════════════════════════════════════════════════════

    // Form Fields
    'firstName': 'Nama Depan',
    'lastName': 'Nama Belakang',
    'email': 'Email',
    'password': 'Kata Sandi',
    'newPassword': 'Kata Sandi Baru',
    'username': 'Nama Pengguna',
    'phoneNo': 'Nomor Telepon',
    'rememberMe': 'Ingat Saya',
    'forgetPassword': 'Lupa Kata Sandi?',
    'signIn': 'Masuk',
    'createAccount': 'Buat Akun',
    'orSignInWith': 'atau masuk dengan',
    'orSignUpWith': 'atau daftar dengan',
    'iAgreeTo': 'Saya setuju dengan',
    'privacyPolicy': 'Kebijakan Privasi',
    'termsOfUse': 'Syarat Penggunaan',
    'verificationCode': 'Kode Verifikasi',
    'resendEmail': 'Kirim Ulang Email',
    'resendEmailIn': 'Kirim ulang email dalam',

    // Authentication Headings
    'loginTitle': 'Selamat datang kembali!',
    'loginSubTitle':
        'Ubah sampah jadi cuan – mulai meraup keuntungan hari ini!',
    'signupTitle': 'Mari kita mulai!',
    'forgetPasswordTitle': 'Lupa kata sandi?',
    'forgetPasswordSubTitle':
        'Tenang saja! Ini wajar terjadi. Masukkan alamat email Anda dan kami akan mengirimkan tautan reset kata sandi yang aman.',
    'changeYourPasswordTitle': 'Email Reset Kata Sandi Berhasil Terkirim!',
    'changeYourPasswordSubTitle':
        'Keamanan akun Anda adalah prioritas utama kami! Kami telah mengirimkan tautan aman untuk mereset kata sandi dan menjaga akun Anda tetap terlindungi.',
    'confirmEmail': 'Verifikasi alamat email Anda!',
    'confirmEmailSubTitle':
        'Hampir selesai! Verifikasi email Anda untuk membuka hadiah eco-reward eksklusif dan mulai memberikan dampak positif bagi lingkungan.',
    'emailNotReceivedMessage':
        'Tidak menerima email? Periksa folder spam atau ketuk untuk mengirim ulang.',
    'yourAccountCreatedTitle': 'Selamat datang di komunitas EcoWaste!',
    'yourAccountCreatedSubTitle':
        'Akun Anda siap digunakan! Mulai perjalanan eco-journey Anda hari ini dan rasakan betapa menguntungnya hidup berkelanjutan.',

    // Home
    'homeAppbarTitle': 'Transformasi sampah jadi kekayaan!',
    'homeAppbarSubTitle': 'Reynaldhi T. Graha',

    // Navigation
    'home': 'Beranda',
    'leaderboard': 'Peringkat',
    'news': 'Berita',
    'profile': 'Profil',
    'settings': 'Pengaturan',
    'transactionDetail': 'Detail Transaksi',
    'depositDetail': 'Detail Setoran',

    // Settings
    'account': 'Akun',
    'accountSettings': 'Pengaturan Akun',
    'appSettings': 'Pengaturan Aplikasi',
    'history': 'Riwayat',
    'confirmation': 'Konfirmasi',
    'address': 'Alamat',
    'darkMode': 'Mode Gelap',
    'language': 'Bahasa',
    'logout': 'Keluar',

    // Language Settings
    'english': 'Bahasa Inggris',
    'indonesian': 'Bahasa Indonesia',
    'selectLanguage': 'Pilih Bahasa',
    'languageSettings': 'Pengaturan Bahasa',

    // Settings Descriptions
    'profileSubtitle': 'Kelola informasi pribadi Anda',
    'historySubtitle': 'Lacak perjalanan dampak eco Anda',
    'confirmationSubtitle': 'Tinjau dan konfirmasi setoran',
    'addressSubtitle': 'Temukan lokasi pengumpulan terdekat',
    'darkModeSubtitle': 'Optimalkan tampilan untuk kenyamanan Anda',

    // ═══════════════════════════════════════════════════════════════════════
    // ADMIN PANEL
    // ═══════════════════════════════════════════════════════════════════════

    // Admin Navigation
    'adminPanel': 'Panel Admin',
    'userManagement': 'Manajemen Pengguna',
    'reports': 'Laporan & Analitik',
    'dashboard': 'Dashboard',

    // Dashboard Stats
    'totalUsers': 'Total Pengguna',
    'wasteCollected': 'Sampah Terkumpul',
    'pendingConfirmation': 'Menunggu Konfirmasi',
    'pointsToday': 'Poin Hari Ini',
    'quickActions': 'Aksi Cepat',
    'recentActivity': 'Aktivitas Terbaru',
    'viewAll': 'Lihat Semua',

    // Transaction Status
    'transactions': 'Transaksi',
    'all': 'Semua',
    'confirmed': 'Dikonfirmasi',
    'pending': 'Menunggu',
    'cancelled': 'Dibatalkan',

    // Admin Actions
    'confirmDeposit': 'Konfirmasi Setoran',
    'manageUsers': 'Kelola Pengguna',
    'viewReports': 'Lihat Laporan',
    'editRanking': 'Edit Peringkat',

    // ═══════════════════════════════════════════════════════════════════════
    // USER PROFILE & ACCOUNT
    // ═══════════════════════════════════════════════════════════════════════
    'editProfile': 'Edit Profil',
    'updateProfile': 'Perbarui Profil',
    'changeProfilePicture': 'Ubah Foto Profil',
    'name': 'Nama',
    'fullName': 'Nama Lengkap',
    'village': 'Desa',
    'district': 'Kecamatan',
    'phoneNumber': 'Nomor Telepon',

    // ═══════════════════════════════════════════════════════════════════════
    // COMMON ACTIONS & UI ELEMENTS
    // ═══════════════════════════════════════════════════════════════════════
    'cancel': 'Batalkan',
    'confirm': 'Konfirmasi',
    'save': 'Simpan',
    'delete': 'Hapus',
    'yes': 'Ya',
    'no': 'Tidak',
    'okay': 'Baik',
    'loading': 'Memuat...',
    'success': 'Berhasil',
    'error': 'Kesalahan',
    'warning': 'Peringatan',

    // ═══════════════════════════════════════════════════════════════════════
    // WASTE MANAGEMENT & DEPOSITS
    // ═══════════════════════════════════════════════════════════════════════

    // Deposit Actions
    'depositWaste': 'Setor Sampah',
    'depositWasteShort': 'Setor\nSampah',
    'wasteCollection': 'Pengumpulan Sampah',
    'collect': 'Kumpulkan',
    'collectWasteAt': 'Antarkan sampah Anda ke pusat pengumpulan kami',

    // Waste Information
    'wasteType': 'Jenis Sampah',
    'wasteWeight': 'Berat Sampah (kg)',
    'temperatureBurning': 'Suhu Pembakaran (°C)',
    'totalPrice': 'Total Harga',

    // Photo & Proof
    'depositProof': 'Bukti Setor',
    'takePhoto': 'Ambil Foto',
    'chooseFromGallery': 'Pilih dari Galeri',
    'removePhoto': 'Hapus Foto',
    'changePhoto': 'Ganti Foto',
    'tapToUpload': 'Ketuk untuk unggah foto',

    // Transaction Types
    'transactionType': 'Tipe Transaksi',
    'dropOff': 'Drop Off (Antar)',
    'pickUp': 'Pick Up (Jemput)',

    // Points & Rewards
    'points': 'Poin',
    'exchangePoints': 'Tukar\nPoin',
    'exchangePointsAction': 'Tukar Poin',

    // ═══════════════════════════════════════════════════════════════════════
    // ERROR MESSAGES & VALIDATION
    // ═══════════════════════════════════════════════════════════════════════
    'loginFailed': 'Login Tidak Berhasil',
    'identityError': 'Kesalahan Autentikasi',
    'failedToProcess': 'Pemrosesan gagal',
    'failedToSelectImage': 'Pemilihan gambar gagal',
    'noImageSelected': 'Silakan pilih gambar',
    'failedToCaptureImage': 'Pengambilan gambar gagal',
    'noImageCaptured': 'Tidak ada gambar yang diambil',
    'failedToLoadRanking': 'Tidak dapat memuat leaderboard',
    'failedToLoadWasteTypes': 'Tidak dapat memuat kategori sampah',
    'errorLoadingWasteTypes': 'Kesalahan memuat kategori sampah',
    'successDepositWaste': 'Sampah berhasil disetor! 🌱',
    'wasteDataSubmitted': 'Kerja bagus! Data sampah Anda telah tercatat.',
    'failedDepositWaste': 'Setoran tidak berhasil',
    'errorDepositingWaste': 'Terjadi kesalahan saat menyetor sampah',

    // ═══════════════════════════════════════════════════════════════════════
    // SHOPPING & REWARDS
    // ═══════════════════════════════════════════════════════════════════════

    // Cart Management
    'yourCart': 'Keranjang Reward Anda',
    'cartEmpty': 'Keranjang Anda siap untuk reward!',
    'addToCartMessage':
        'Jelajahi eco-reward kami dan tambahkan item untuk melanjutkan.',
    'addToCart': 'Tambah ke Keranjang',
    'removeAll': 'Kosongkan keranjang',
    'totalItems': 'Total item:',
    'totalPriceCart': 'Total poin:',
    'checkout': 'Tukar Sekarang',
    'addedToCart': 'telah ditambahkan ke keranjang!',
    'alreadyInCart': 'Sudah di Keranjang',
    'isAlreadyInCart': 'sudah ada di keranjang Anda.',
    'removedFromCart': 'Dihapus dari Keranjang',
    'removedFromCartMessage': 'telah dihapus dari keranjang.',
    'cartCleared': 'Keranjang Dikosongkan',
    'cartClearedMessage': 'Semua item telah dihapus dari keranjang Anda.',
    'isOutOfStock': 'sedang tidak tersedia.',

    // Product Information
    'stock': 'Stok:',
    'outOfStock': 'Habis',
    'productDescription':
        'Temukan eco-reward menakjubkan! Detail produk, fitur, dan manfaat akan ditampilkan di sini.',

    // ═══════════════════════════════════════════════════════════════════════
    // VALIDATION MESSAGES
    // ═══════════════════════════════════════════════════════════════════════
    'emailRequired': 'Email wajib diisi.',
    'invalidEmailAddress': 'Alamat email tidak valid.',
    'passwordRequired': 'Kata sandi wajib diisi.',
    'passwordMinLength': 'Kata sandi harus minimal 6 karakter.',
    'passwordUppercase':
        'Kata sandi harus mengandung minimal satu huruf besar.',
    'passwordNumber': 'Kata sandi harus mengandung minimal satu angka.',
    'passwordSpecialChar':
        'Kata sandi harus mengandung minimal satu karakter khusus.',
    'phoneRequired': 'Nomor telepon wajib diisi.',
    'invalidPhoneNumber':
        'Format nomor telepon tidak valid (diperlukan 10 digit).',

    // ═══════════════════════════════════════════════════════════════════════
    // COMMON UI ELEMENTS
    // ═══════════════════════════════════════════════════════════════════════

    // Location & Date Selection
    'locationDetail': 'Detail Lokasi',
    'tapToSelectDate': 'Tap untuk pilih tanggal',
    'enterLocationDetail': 'Masukkan detail lokasi',
    'selectDate': 'Pilih Tanggal',

    // Photo & Media
    'uploadProof': 'Upload Foto Bukti',
    'takePhotoProof': 'Ambil foto bukti sampah',
    'failedToProcessImage': 'Gagal memproses gambar',
    'changeImage': 'Ganti Gambar',
    'selectImage': 'Pilih Gambar',
    'tapToAddImage': 'Ketuk untuk menambah gambar',
    'takeFromCamera': 'Ambil dengan Kamera',
    'selectFromGallery': 'Pilih dari Galeri',

    // Form Actions & UI
    'createTransaction': 'Buat Transaksi',
    'viewReport': 'Lihat Laporan',
    'defaultViewAll': 'Lihat semua',

    // Selection Prompts
    'selectWasteTypeFirst': 'Pilih jenis sampah terlebih dahulu',
    'selectTransactionTypeFirst': 'Pilih tipe transaksi terlebih dahulu',
    'selectTransactionDate': 'Pilih tanggal transaksi',
    'noDataFound': 'Tidak ada data ditemukan!',
    'somethingWentWrong': 'Terjadi kesalahan.',

    // ═══════════════════════════════════════════════════════════════════════
    // ADDITIONAL FEATURES
    // ═══════════════════════════════════════════════════════════════════════

    // Checkout & Implementation
    'checkoutNotImplemented': 'Fitur checkout belum diimplementasikan.',

    // Tutorial steps
    'tutorialStep1': 'Langkah 1: Pilah sampah seperti seorang ahli!',
    'tutorialStep2':
        'Langkah 2: Catat setiap item di aplikasi untuk dampak maksimal.',
    'tutorialStep3': 'Langkah 3: Saksikan saldo reward Anda bertumbuh!',

    // Missing hardcoded strings found in the app
    'noTransactionHistoryAvailable': 'Tidak ada riwayat transaksi tersedia',
    'yourTransactionsWillAppearHere': 'Transaksi Anda akan muncul di sini',
    'noFilteredTransactionsFound': 'Tidak ada transaksi ditemukan',
    'trySelectingDifferentFilter': 'Coba pilih filter yang berbeda',
    'loadNewsError': 'Gagal memuat berita',
    'statusNotSuccessful': 'Status tidak berhasil',
    'responseNotValid': 'Respons tidak valid',
    'loadingError': 'Kesalahan memuat',
    'failedToLoadLeaderboard': 'Gagal memuat peringkat',
    'failedToTakePhoto': 'Gagal mengambil gambar',
    'noPhotoTaken': 'Tidak ada gambar yang diambil',
    'rejected': 'Ditolak',
    'failedToLoadTransactionDetails': 'Gagal memuat detail transaksi',
    'failedToFetchTransactionDetails': 'Gagal mengambil detail transaksi',
    'failedToLoadTransactions': 'Gagal memuat transaksi',
    'failedToFetchTransactions': 'Gagal mengambil transaksi',
    'failedToCreateTransaction': 'Gagal membuat transaksi',
    'failedToProcessTransaction': 'Gagal memproses transaksi',
    'failedToCancelTransaction': 'Gagal membatalkan transaksi',
    'failedToFetchUserData': 'Gagal mengambil data pengguna',
    'completed': 'Selesai',

    // Profile and Settings
    'profileInformation': 'Informasi Profil',
    'rtRw': 'RT/RW',
    'unknown': 'Tidak Diketahui',
    'kabupatenKota': 'Kabupaten/Kota',

    // Dark mode
    'adjustDisplayAmbientLighting': 'Sesuaikan tampilan dengan cahaya sekitar',

    // Network and Error Messages
    'noInternetConnection': 'Koneksi Terputus - Silakan Periksa Internet Anda',

    // Additional UI strings
    'hello': 'Halo',
    'balance': 'Saldo',
    'pointsEarned': 'Poin Diperoleh',
    'actualWeight': 'Berat Aktual',
    'wib': 'WIB',
    'kg': 'kg',
    'locationInformation': 'Informasi Lokasi',
  };
}

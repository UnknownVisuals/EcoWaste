import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      // Global Texts
      'and': 'and',
      'skip': 'Skip',
      'done': 'Done',
      'submit': 'Submit',
      'appName': 'EcoWaste',
      'continue': 'Continue',

      // OnBoarding Texts
      'onBoardingTitle1': 'Reduce Waste,\nSave the Planet!',
      'onBoardingTitle2': 'Recycle Smarter,\nLive Better!',
      'onBoardingTitle3': 'Earn Rewards,\nMake a Difference!',
      'onBoardingSubTitle1':
          'Take action by reducing waste and protecting our earth.',
      'onBoardingSubTitle2':
          'Sort and recycle your waste for a cleaner, healthier community.',
      'onBoardingSubTitle3':
          'Collect points and redeem exciting rewards for your eco-friendly habits.',

      // Authentication Forms
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

      // Authentication Headings
      'loginTitle': 'Welcome back,',
      'loginSubTitle': 'Collect and exchange your waste for money!',
      'signupTitle': 'Let\'s create your account',
      'forgetPasswordTitle': 'Forgot password',
      'forgetPasswordSubTitle':
          'Don\'t worry, everyone forgets sometimes. Enter your email and we\'ll send you a password reset link.',
      'changeYourPasswordTitle': 'Password Reset Email Sent',
      'changeYourPasswordSubTitle':
          'Your Account Security is Our Priority! We\'ve sent a secure link to change your password and protect your account.',
      'confirmEmail': 'Verify your email address!',
      'confirmEmailSubTitle':
          'Congratulations! Your account is waiting: Verify your email to start shopping and enjoy unbeatable and personalized offers.',
      'emailNotReceivedMessage':
          'Didn\'t receive the email? Check your junk/spam folder or resend.',
      'yourAccountCreatedTitle': 'Your account has been created!',
      'yourAccountCreatedSubTitle':
          'Welcome to your ultimate shopping destination: Your account has been created, enjoy the excitement of seamless online shopping!',

      // Home
      'homeAppbarTitle': 'Your waste, your money!',
      'homeAppbarSubTitle': 'Reynaldhi T. Graha',

      // Navigation
      'home': 'Home',
      'leaderboard': 'Leaderboard',
      'news': 'News',
      'profile': 'Profile',
      'settings': 'Settings',

      // Settings
      'account': 'Account',
      'accountSettings': 'Account Settings',
      'appSettings': 'App Settings',
      'history': 'History',
      'confirmation': 'Confirmation',
      'address': 'Address',
      'darkMode': 'Dark Mode',
      'language': 'Language',
      'logout': 'Logout',
      'adminPanel': 'Admin Panel',
      'userManagement': 'User Management',
      'reports': 'Reports & Analytics',

      // Language Settings
      'english': 'English',
      'indonesian': 'Indonesian',
      'selectLanguage': 'Select Language',
      'languageSettings': 'Language Settings',

      // Admin specific
      'dashboard': 'Dashboard',
      'totalUsers': 'Total Users',
      'wasteCollected': 'Waste Collected',
      'pendingConfirmation': 'Pending Confirmation',
      'pointsToday': 'Points Today',
      'quickActions': 'Quick Actions',
      'recentActivity': 'Recent Activity',
      'viewAll': 'View All',

      // Profile related
      'editProfile': 'Edit Profile',
      'updateProfile': 'Update Profile',
      'changeProfilePicture': 'Change Profile Picture',
      'name': 'Name',
      'fullName': 'Full Name',
      'village': 'Village',
      'district': 'District',
      'phoneNumber': 'Phone Number',

      // Common actions and messages
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

      // Deposit related
      'depositWaste': 'Deposit Waste',
      'wasteType': 'Waste Type',
      'wasteWeight': 'Waste Weight (kg)',
      'temperatureBurning': 'Burning Temperature (°C)',
      'totalPrice': 'Total Price',
      'depositProof': 'Deposit Proof',
      'takePhoto': 'Take Photo',
      'chooseFromGallery': 'Choose from Gallery',
      'removePhoto': 'Remove Photo',
      'changePhoto': 'Change Photo',
      'collect': 'Collect',
      'tapToUpload': 'Tap to upload photo',

      // Home related
      'wasteCollection': 'Waste Collection',
      'points': 'Points',
      'depositWasteShort': 'Deposit\nWaste',
      'exchangePoints': 'Exchange\nPoints',
      'collectWasteAt': 'Collect your waste at',

      // Settings subtitles
      'profileSubtitle': 'Edit your profile information',
      'historySubtitle': 'View waste deposit history',
      'confirmationSubtitle': 'Confirm waste deposits',
      'addressSubtitle': 'View waste collection addresses',
      'darkModeSubtitle': 'Adjust display to ambient lighting',

      // Admin specific
      'confirmDeposit': 'Confirm Deposit',
      'manageUsers': 'Manage Users',
      'viewReports': 'View Reports',
      'editRanking': 'Edit Ranking',

      // Error messages
      'loginFailed': 'Login Failed',
      'identityError': 'Identity Error',
      'failedToProcess': 'Failed to process',
      'failedToSelectImage': 'Failed to select image',
      'noImageSelected': 'No image selected',
      'failedToCaptureImage': 'Failed to capture image',
      'noImageCaptured': 'No image captured',
      'failedToLoadRanking': 'Failed to load ranking',
      'failedToLoadWasteTypes': 'Failed to load waste types',
      'errorLoadingWasteTypes': 'Error loading waste types',
      'successDepositWaste': 'Successfully deposited waste',
      'wasteDataSubmitted': 'Waste data successfully submitted',
      'failedDepositWaste': 'Failed to deposit waste',
      'errorDepositingWaste': 'Error occurred while depositing waste',

      // Cart and exchange
      'yourCart': 'Your Cart',
      'cartEmpty': 'Your cart is empty',
      'addToCartMessage': 'Add products to cart to continue.',
      'removeAll': 'Remove all',
      'totalItems': 'Total items:',
      'totalPriceCart': 'Total price:',
      'checkout': 'Checkout',
      'addToCart': 'Add to Cart',
      'exchangePointsAction': 'Exchange Points',
      'productDescription':
          'Product description will be displayed here. This is a place to explain product details, features, and benefits.',

      // Common UI text
      'viewReport': 'View Report',
      'defaultViewAll': 'View all',
    },
    'id_ID': {
      // Global Texts
      'and': 'dan',
      'skip': 'Lewati',
      'done': 'Selesai',
      'submit': 'Kirim',
      'appName': 'Sobat Sampah',
      'continue': 'Lanjutkan',

      // OnBoarding Texts
      'onBoardingTitle1': 'Kurangi Sampah,\nSelamatkan Planet!',
      'onBoardingTitle2': 'Daur Ulang Lebih Pintar,\nHidup Lebih Baik!',
      'onBoardingTitle3': 'Dapatkan Hadiah,\nBuat Perbedaan!',
      'onBoardingSubTitle1':
          'Ambil tindakan dengan mengurangi sampah dan melindungi bumi kita.',
      'onBoardingSubTitle2':
          'Pilah dan daur ulang sampah Anda untuk komunitas yang lebih bersih dan sehat.',
      'onBoardingSubTitle3':
          'Kumpulkan poin dan tukar dengan hadiah menarik untuk kebiasaan ramah lingkungan Anda.',

      // Authentication Forms
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
      'loginTitle': 'Selamat datang kembali,',
      'loginSubTitle': 'Kumpulkan dan tukar sampah Anda dengan uang!',
      'signupTitle': 'Mari buat akun Anda',
      'forgetPasswordTitle': 'Lupa kata sandi',
      'forgetPasswordSubTitle':
          'Jangan khawatir, semua orang terkadang lupa. Masukkan email Anda dan kami akan mengirimkan tautan reset kata sandi.',
      'changeYourPasswordTitle': 'Email Reset Kata Sandi Terkirim',
      'changeYourPasswordSubTitle':
          'Keamanan Akun Anda adalah Prioritas Kami! Kami telah mengirimkan tautan aman untuk mengubah kata sandi dan melindungi akun Anda.',
      'confirmEmail': 'Verifikasi alamat email Anda!',
      'confirmEmailSubTitle':
          'Selamat! Akun Anda menunggu: Verifikasi email Anda untuk mulai berbelanja dan nikmati penawaran yang tak tertandingi dan personal.',
      'emailNotReceivedMessage':
          'Tidak menerima email? Periksa folder spam Anda atau kirim ulang.',
      'yourAccountCreatedTitle': 'Akun Anda telah dibuat!',
      'yourAccountCreatedSubTitle':
          'Selamat datang di destinasi belanja utama Anda: Akun Anda telah dibuat, nikmati kegembiraan belanja online yang mulus!',

      // Home
      'homeAppbarTitle': 'Sampah Anda, uang Anda!',
      'homeAppbarSubTitle': 'Reynaldhi T. Graha',

      // Navigation
      'home': 'Beranda',
      'leaderboard': 'Peringkat',
      'news': 'Berita',
      'profile': 'Profil',
      'settings': 'Pengaturan',

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
      'adminPanel': 'Panel Admin',
      'userManagement': 'Manajemen Pengguna',
      'reports': 'Laporan & Analitik',

      // Language Settings
      'english': 'Bahasa Inggris',
      'indonesian': 'Bahasa Indonesia',
      'selectLanguage': 'Pilih Bahasa',
      'languageSettings': 'Pengaturan Bahasa',

      // Admin specific
      'dashboard': 'Dashboard',
      'totalUsers': 'Total Pengguna',
      'wasteCollected': 'Sampah Terkumpul',
      'pendingConfirmation': 'Menunggu Konfirmasi',
      'pointsToday': 'Poin Hari Ini',
      'quickActions': 'Aksi Cepat',
      'recentActivity': 'Aktivitas Terbaru',
      'viewAll': 'Lihat Semua',

      // Profile related
      'editProfile': 'Edit Profil',
      'updateProfile': 'Perbarui Profil',
      'changeProfilePicture': 'Ubah Foto Profil',
      'name': 'Nama',
      'fullName': 'Nama Lengkap',
      'village': 'Desa',
      'district': 'Kecamatan',
      'phoneNumber': 'Nomor Telepon',

      // Common actions and messages
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

      // Deposit related
      'depositWaste': 'Setor Sampah',
      'wasteType': 'Jenis Sampah',
      'wasteWeight': 'Berat Sampah (kg)',
      'temperatureBurning': 'Suhu Pembakaran (°C)',
      'totalPrice': 'Total Harga',
      'depositProof': 'Bukti Setor',
      'takePhoto': 'Ambil Foto',
      'chooseFromGallery': 'Pilih dari Galeri',
      'removePhoto': 'Hapus Foto',
      'changePhoto': 'Ganti Foto',
      'collect': 'Kumpulkan',
      'tapToUpload': 'Ketuk untuk unggah foto',

      // Home related
      'wasteCollection': 'Pengumpulan Sampah',
      'points': 'Poin',
      'depositWasteShort': 'Setor\nSampah',
      'exchangePoints': 'Tukar\nPoin',
      'collectWasteAt': 'Kumpulkan sampah Anda di',

      // Settings subtitles
      'profileSubtitle': 'Edit informasi profil Anda',
      'historySubtitle': 'Lihat riwayat setor sampah',
      'confirmationSubtitle': 'Konfirmasi setor sampah',
      'addressSubtitle': 'Lihat alamat tempat setor sampah',
      'darkModeSubtitle': 'Sesuaikan tampilan dengan cahaya sekitar',

      // Admin specific
      'confirmDeposit': 'Konfirmasi Setoran',
      'manageUsers': 'Kelola Pengguna',
      'viewReports': 'Lihat Laporan',
      'editRanking': 'Edit Peringkat',

      // Error messages
      'loginFailed': 'Login Gagal',
      'identityError': 'Kesalahan Identitas',
      'failedToProcess': 'Gagal memproses',
      'failedToSelectImage': 'Gagal memilih gambar',
      'noImageSelected': 'Tidak ada gambar yang dipilih',
      'failedToCaptureImage': 'Gagal mengambil gambar',
      'noImageCaptured': 'Tidak ada gambar yang diambil',
      'failedToLoadRanking': 'Gagal memuat peringkat',
      'failedToLoadWasteTypes': 'Gagal memuat jenis sampah',
      'errorLoadingWasteTypes': 'Kesalahan memuat jenis sampah',
      'successDepositWaste': 'Berhasil menyetor sampah',
      'wasteDataSubmitted': 'Data sampah berhasil dikirim',
      'failedDepositWaste': 'Gagal menyetor sampah',
      'errorDepositingWaste': 'Terjadi kesalahan saat menyetor sampah',

      // Cart and exchange
      'yourCart': 'Keranjang Anda',
      'cartEmpty': 'Keranjang Anda kosong',
      'addToCartMessage': 'Tambahkan produk ke keranjang untuk melanjutkan.',
      'removeAll': 'Hapus semua',
      'totalItems': 'Total item:',
      'totalPriceCart': 'Total harga:',
      'checkout': 'Bayar',
      'addToCart': 'Tambah ke Keranjang',
      'exchangePointsAction': 'Tukar Poin',
      'productDescription':
          'Deskripsi produk akan ditampilkan di sini. Ini adalah tempat untuk menjelaskan detail produk, fitur, dan manfaat.',

      // Common UI text
      'viewReport': 'Lihat Laporan',
      'defaultViewAll': 'Lihat semua',
    },
  };
}

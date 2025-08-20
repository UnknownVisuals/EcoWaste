# Authentication Feature - API Integration Documentation

## Overview

Semua fungsi pada fitur Authentication telah diperbaiki dan disesuaikan dengan dokumentasi API Platform Manajemen Sampah yang diberikan.

## Perubahan yang Dilakukan

### 1. Model Updates

#### UserModel (`user_model.dart`)

- Diperbarui sesuai dengan struktur response API dokumentasi
- Menambahkan field `tps3rId`, `createdAt`
- Mengganti `locationId` dengan struktur yang sesuai API
- Mengubah field `points` menjadi `points` (sesuai dokumentasi)

#### LoginModel (`login_model.dart`)

- Tetap sama, sudah sesuai dengan API requirement

#### SignupModel (`signup_model.dart`) - BARU

- Model baru untuk registrasi sesuai dengan endpoint `POST /users`
- Mendukung field: `name`, `email`, `password`, `role`, `tps3rId`

### 2. HTTP Client Updates (`http_client.dart`)

#### Perubahan Utama:

- Menambahkan dukungan untuk session cookie management
- Menghapus header `x-user-role` yang tidak sesuai dengan dokumentasi API
- Menambahkan method `clearSession()` untuk logout
- Memperbaiki header management dengan `_getHeaders()`

#### Session Management:

- Menyimpan session cookie dari response `Set-Cookie`
- Mengirim cookie pada setiap request berikutnya
- Membersihkan session saat logout

### 3. Controller Updates

#### UserController (`user_controller.dart`)

- Menambahkan method `getCurrentUser()` untuk endpoint `GET /auth/me`
- Menambahkan method `logout()` untuk endpoint `POST /auth/logout`
- Memperbaiki `updateUserModel()` untuk menerima response API yang sesuai
- Menambahkan `loadUserFromStorage()` dan `refreshUserData()`

#### LoginController (`login_controller.dart`)

- Memperbaiki flow login sesuai dengan dokumentasi API
- Menambahkan validasi form yang lebih baik
- Memperbaiki handling response API dengan status `success/error`
- Menambahkan support untuk session cookie
- Memperbaiki error handling dengan status code yang sesuai (400, 401, dll)

#### SignupController (`signup_controller.dart`)

- Menambahkan method `signup()` untuk endpoint `POST /users`
- Menambahkan validasi form lengkap
- Memperbaiki error handling untuk response API

### 4. New Controllers

#### AuthController (`auth_controller.dart`) - BARU

- Controller utama untuk mengelola semua fungsi authentication
- Method `checkAuthenticationStatus()` untuk cek status login
- Method `getCurrentUser()` untuk get user data
- Method `logout()` untuk logout dengan API call
- Properties `isAuthenticated`, `isAdmin`, `isPartner`, `isUser`

#### PasswordController (`password_controller.dart`) - BARU

- Mengelola forgot password, reset password, change password
- Endpoints (belum dikonfirmasi dengan backend):
  - `POST /auth/forgot-password`
  - `POST /auth/reset-password`
  - `PUT /auth/change-password`

### 5. Services

#### AuthService (`auth_service.dart`) - BARU

- Service layer untuk authentication
- Middleware untuk route protection:
  - `AuthMiddleware` - Proteksi route yang memerlukan login
  - `GuestMiddleware` - Route untuk guest only (login/register)
  - `AdminMiddleware` - Route khusus admin
  - `PartnerMiddleware` - Route khusus partner

### 6. Utilities

#### AuthConstants (`auth_constants.dart`) - BARU

- Konstanta untuk endpoints, error messages, success messages
- Konfigurasi validasi (min password length, dll)
- Route names

#### AuthValidators (`auth_validators.dart`) - BARU

- Utility untuk validasi form
- Validasi email, password, name, terms & conditions
- Comprehensive form validation methods

#### ApiResponseHandler (`api_response_handler.dart`) - BARU

- Handler untuk response API sesuai dokumentasi
- Model `ApiResponse<T>` dan `ApiError`
- Utility methods untuk extract error messages
- Status code handling

## Endpoints API yang Digunakan

### ✅ Implemented dan Sesuai Dokumentasi:

1. `POST /auth/login` - Login user
2. `GET /auth/me` - Get current user data
3. `POST /auth/logout` - Logout user
4. `POST /users` - Register new user

### ⚠️ Belum Dikonfirmasi dengan Backend:

1. `POST /auth/forgot-password` - Forgot password
2. `POST /auth/reset-password` - Reset password
3. `PUT /auth/change-password` - Change password

## Struktur Response API

Semua controller mengikuti struktur response sesuai dokumentasi:

### Success Response:

```json
{
  "status": "success",
  "data": {
    /* data object */
  },
  "message": "Success message"
}
```

### Error Response:

```json
{
  "status": "error",
  "message": "Error message",
  "errors": [
    {
      "field": "field_name",
      "message": "Field specific error"
    }
  ]
}
```

## Status Codes yang Dihandle:

- `200` - OK
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `500` - Internal Server Error

## Authentication Flow

### Login Flow:

1. User input email & password
2. Validasi form
3. POST request ke `/auth/login`
4. Simpan session cookie dari response
5. Update user model dari response data
6. Navigate sesuai role (USER/ADMIN)

### Session Management:

1. Session cookie disimpan otomatis dari response login
2. Cookie dikirim pada setiap request berikutnya
3. Saat logout, cookie dihapus dari storage
4. Auto-login jika remember me enabled

### Registration Flow:

1. User input registration data
2. Validasi form (termasuk terms & conditions)
3. POST request ke `/users`
4. Navigate ke login screen setelah sukses

## Usage Examples

### Login:

```dart
final loginController = Get.put(LoginController());
await loginController.login(
  email: 'user@example.com',
  password: 'password123'
);
```

### Register:

```dart
final signupController = Get.put(SignupController());
await signupController.signup(
  name: 'John Doe',
  email: 'john@example.com',
  password: 'password123'
);
```

### Check Authentication:

```dart
final authController = Get.put(AuthController());
if (authController.isAuthenticated.value) {
  // User is logged in
}
```

### Logout:

```dart
final authController = Get.put(AuthController());
await authController.logout();
```

## Next Steps

1. ✅ Testing semua endpoints dengan backend
2. ✅ Konfirmasi endpoint password management
3. ✅ Update UI components untuk menggunakan controller baru
4. ✅ Implementasi route guards dengan middleware
5. ✅ Testing session management

## Notes

- Semua controller menggunakan proper error handling
- Response API parsing sesuai dokumentasi
- Session cookie management implemented
- Form validation comprehensive
- Role-based navigation supported
- Middleware untuk route protection ready

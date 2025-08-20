import 'package:eco_waste/features/authentication/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get instance => Get.find();

  late final AuthController _authController;

  /// Initialize authentication service
  Future<AuthService> init() async {
    _authController = Get.put(AuthController());
    await _authController.checkAuthenticationStatus();
    return this;
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _authController.isAuthenticated.value;

  /// Get current user
  get currentUser {
    try {
      return _authController.userController.userModel.value;
    } catch (e) {
      // Return a default user model if there's an error
      return _authController.userController.userModel.value;
    }
  }

  /// Check if user has specific role
  bool hasRole(String role) => _authController.hasRole(role);

  /// Check if user is admin
  bool get isAdmin => _authController.isAdmin;

  /// Check if user is partner
  bool get isPartner => _authController.isPartner;

  /// Check if user is regular user
  bool get isUser => _authController.isUser;

  /// Logout current user
  Future<void> logout() async {
    await _authController.logout();
  }

  /// Refresh user data
  Future<void> refreshUserData() async {
    await _authController.refreshUserData();
  }
}

/// Middleware for route protection
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!AuthService.instance.isAuthenticated) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}

/// Middleware for guest-only routes (login, register)
class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AuthService.instance.isAuthenticated) {
      if (AuthService.instance.isAdmin) {
        return const RouteSettings(name: '/admin/dashboard');
      } else {
        return const RouteSettings(name: '/user/home');
      }
    }
    return null;
  }
}

/// Middleware for admin-only routes
class AdminMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!AuthService.instance.isAuthenticated) {
      return const RouteSettings(name: '/login');
    }

    if (!AuthService.instance.isAdmin) {
      return const RouteSettings(name: '/unauthorized');
    }

    return null;
  }
}

/// Middleware for partner-only routes
class PartnerMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!AuthService.instance.isAuthenticated) {
      return const RouteSettings(name: '/login');
    }

    if (!AuthService.instance.isPartner) {
      return const RouteSettings(name: '/unauthorized');
    }

    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';

/// Widget untuk menampilkan error message dengan styling yang konsisten
class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
    required this.message,
    this.isVisible = true,
  });

  final String message;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible || message.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(REYSizes.sm),
      margin: const EdgeInsets.only(top: REYSizes.xs),
      decoration: BoxDecoration(
        color: REYColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(REYSizes.xs),
        border: Border.all(color: REYColors.error.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: REYColors.error, size: 16),
          const SizedBox(width: REYSizes.xs),
          Expanded(
            child: Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: REYColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget untuk menampilkan success message
class SuccessMessageWidget extends StatelessWidget {
  const SuccessMessageWidget({
    super.key,
    required this.message,
    this.isVisible = true,
  });

  final String message;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible || message.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(REYSizes.sm),
      margin: const EdgeInsets.only(top: REYSizes.xs),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(REYSizes.xs),
        border: Border.all(color: Colors.green.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 16),
          const SizedBox(width: REYSizes.xs),
          Expanded(
            child: Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget untuk loading state dengan message
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.message = 'Loading...', this.size = 20});

  final String message;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: REYSizes.sm),
        Text(message, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

/// Custom TextFormField dengan error handling yang lebih baik
class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.errorMessage,
    this.isEnabled = true,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final AutovalidateMode autovalidateMode;
  final String? errorMessage;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          enabled: isEnabled,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(prefixIcon),
            suffixIcon: suffixIcon,
            errorMaxLines: 2,
          ),
          validator: validator,
          autovalidateMode: autovalidateMode,
        ),
        if (errorMessage != null && errorMessage!.isNotEmpty)
          ErrorMessageWidget(message: errorMessage!),
      ],
    );
  }
}

/// Widget untuk form section dengan title
class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        if (subtitle != null) ...[
          const SizedBox(height: REYSizes.xs),
          Text(
            subtitle!,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
        const SizedBox(height: REYSizes.spaceBtwInputFields),
        ...children,
      ],
    );
  }
}

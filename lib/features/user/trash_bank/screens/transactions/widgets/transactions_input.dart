import 'dart:convert';
import 'package:eco_waste/features/user/trash_bank/controllers/waste_category_controller.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/transactions_controller.dart';
import 'package:eco_waste/controllers/camera_controller.dart';
import 'package:eco_waste/features/user/trash_bank/models/transaction_model.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsInput extends StatelessWidget {
  const TransactionsInput({
    super.key,
    required this.userId,
    required this.locationId,
  });

  final String userId, locationId;

  @override
  Widget build(BuildContext context) {
    final WasteCategoryController wasteCategoryController = Get.put(
      WasteCategoryController(),
    );
    final CameraController cameraController = Get.put(CameraController());
    final TransactionController transactionController = Get.put(
      TransactionController(),
    );

    // Selected waste category
    final RxString selectedWasteCategory = ''.obs;

    // Selected transaction type
    final RxString selectedTransactionType = ''.obs;

    // Selected date
    final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

    // Location controller
    final TextEditingController locationController = TextEditingController();

    // Fetch waste categories when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (wasteCategoryController.wasteCategories.isEmpty) {
        wasteCategoryController.fetchWasteCategories();
      }
    });

    return Column(
      children: [
        // Jenis Sampah
        Obx(
          () => DropdownButtonFormField<String>(
            value: selectedWasteCategory.value.isEmpty
                ? null
                : selectedWasteCategory.value,
            items: wasteCategoryController.wasteCategories.map((wasteCategory) {
              return DropdownMenuItem<String>(
                value: wasteCategory.id,
                alignment: AlignmentDirectional.center,
                child: Text(
                  wasteCategory.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              selectedWasteCategory.value = newValue ?? '';
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.delete_outline),
              labelText: 'wasteType'.tr,
            ),
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwInputFields),

        // Transaction Type
        Obx(
          () => DropdownButtonFormField<String>(
            value: selectedTransactionType.value.isEmpty
                ? null
                : selectedTransactionType.value,
            items: const [
              DropdownMenuItem<String>(
                value: 'DROPOFF',
                alignment: AlignmentDirectional.center,
                child: Text('Drop Off (Antar)'),
              ),
              DropdownMenuItem<String>(
                value: 'PICKUP',
                alignment: AlignmentDirectional.center,
                child: Text('Pick Up (Jemput)'),
              ),
            ],
            onChanged: (newValue) {
              selectedTransactionType.value = newValue ?? '';
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.swap_horiz),
              labelText: 'Tipe Transaksi',
            ),
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwInputFields),

        // Weight Input
        // TextFormField(
        //   controller: weightController,
        //   keyboardType: const TextInputType.numberWithOptions(decimal: true),
        //   inputFormatters: [
        //     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        //   ],
        //   decoration: InputDecoration(
        //     prefixIcon: const Icon(Icons.scale),
        //     labelText: 'Berat Sampah (kg)',
        //     hintText: 'Masukkan berat dalam kg (contoh: 2.5)',
        //   ),
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Berat sampah harus diisi';
        //     }
        //     final weight = double.tryParse(value);
        //     if (weight == null || weight <= 0) {
        //       return 'Berat harus berupa angka positif';
        //     }
        //     return null;
        //   },
        // ),
        const SizedBox(height: REYSizes.spaceBtwInputFields),

        // Location Detail
        TextFormField(
          controller: locationController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.location_on_outlined),
            labelText: 'Detail Lokasi',
            alignLabelWithHint: true,
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwInputFields),

        // Jadwal
        Obx(
          () => TextFormField(
            readOnly: true,
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate.value ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (pickedDate != null) {
                selectedDate.value = pickedDate;
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.calendar_today),
              labelText: 'Pilih Tanggal',
              hintText: selectedDate.value != null
                  ? '${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}'
                  : 'Tap untuk pilih tanggal',
            ),
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwInputFields),

        // Upload Picture Section
        REYSectionHeading(
          title: 'Upload Foto Bukti',
          showActionButton: cameraController.selectedImage.value != null,
          buttonTitle: 'Hapus Foto',
          onPressed: () {
            cameraController.selectedImage.value = null;
          },
        ),

        const SizedBox(height: REYSizes.spaceBtwItems),

        // Image Preview
        Obx(
          () => GestureDetector(
            onTap: () => _showImagePickerBottomSheet(context, cameraController),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.grey.shade50,
              ),
              child: cameraController.selectedImage.value != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        cameraController.selectedImage.value!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap untuk menambah gambar',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwItems),

        // Action Buttons
        Obx(
          () => Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: cameraController.selectedImage.value != null
                      ? () => _showImagePickerBottomSheet(
                          context,
                          cameraController,
                        )
                      : null,
                  child: const Text('Ganti Gambar'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: transactionController.isLoading.value
                      ? null
                      : () => _submitTransaction(
                          context,
                          transactionController,
                          selectedWasteCategory,
                          selectedTransactionType,
                          locationController,
                          selectedDate,
                          cameraController,
                        ),
                  child: transactionController.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Buat Transaksi'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showImagePickerBottomSheet(
    BuildContext context,
    CameraController cameraController,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(REYSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title
              Text(
                'Pilih Gambar',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              // Camera Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    cameraController.captureImageWithCamera();
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Ambil dari Kamera'),
                ),
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              // Gallery Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    cameraController.pickImageFromGallery();
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Pilih dari Galeri'),
                ),
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submitTransaction(
    BuildContext context,
    TransactionController transactionController,
    RxString selectedWasteCategory,
    RxString selectedTransactionType,
    TextEditingController locationController,
    Rx<DateTime?> selectedDate,
    CameraController cameraController,
  ) async {
    // Validation
    if (selectedWasteCategory.value.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Pilih jenis sampah terlebih dahulu',
      );
      return;
    }

    if (selectedTransactionType.value.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Pilih tipe transaksi terlebih dahulu',
      );
      return;
    }

    if (locationController.text.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Masukkan detail lokasi',
      );
      return;
    }

    if (selectedDate.value == null) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Pilih tanggal transaksi',
      );
      return;
    }

    if (cameraController.selectedImage.value == null) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Ambil foto bukti sampah',
      );
      return;
    }

    // Convert image to base64 for API
    String base64Image = '';
    try {
      final bytes = await cameraController.selectedImage.value!.readAsBytes();
      base64Image = 'data:image/jpeg;base64,${base64Encode(bytes)}';
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Gagal memproses gambar: ${e.toString()}',
      );
      return;
    }

    // Create transaction model
    final transaction = TransactionModel(
      id: '', // Will be generated by server
      userId: userId,
      wasteCategoryId: selectedWasteCategory.value,
      type: selectedTransactionType.value,
      status: 'PENDING', // Default status for new transactions
      locationDetail: locationController.text,
      scheduledDate: selectedDate.value!,
      photos: [base64Image],
      locationId: locationId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Create transaction
    final success = await transactionController.createTransaction(transaction);

    if (success) {
      // Clear form after successful submission
      selectedWasteCategory.value = '';
      selectedTransactionType.value = '';
      locationController.clear();
      selectedDate.value = null;
      cameraController.selectedImage.value = null;

      // Navigate back or show success message
      Get.back();
    }
  }
}

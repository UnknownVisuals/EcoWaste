import 'dart:convert';
import 'package:eco_waste/features/trash_bank/controllers/waste_category_controller.dart';
import 'package:eco_waste/features/trash_bank/controllers/transactions_controller.dart';
import 'package:eco_waste/controllers/camera_controller.dart';
import 'package:eco_waste/features/trash_bank/models/transactions_model.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/common/widgets/image_picker_bottom_sheet.dart';
import 'package:eco_waste/common/widgets/image_preview_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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

    // Selected Input Values
    final RxString selectedWasteCategory = ''.obs;
    final RxString selectedTransactionType = ''.obs;
    final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
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
            initialValue: selectedWasteCategory.value.isEmpty
                ? null
                : selectedWasteCategory.value,
            items: wasteCategoryController.wasteCategories.map((wasteCategory) {
              return DropdownMenuItem<String>(
                value: wasteCategory.id,
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wasteCategory.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      wasteCategory.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Divider(),
                  ],
                ),
              );
            }).toList(),
            selectedItemBuilder: (BuildContext context) {
              return wasteCategoryController.wasteCategories.map((
                wasteCategory,
              ) {
                return Text(
                  wasteCategory.name,
                  style: Theme.of(context).textTheme.titleMedium,
                );
              }).toList();
            },
            onChanged: (newValue) {
              selectedWasteCategory.value = newValue ?? '';
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.trash),
              labelText: 'wasteType'.tr,
            ),
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwInputFields),

        // Transaction Type
        Obx(
          () => DropdownButtonFormField<String>(
            initialValue: selectedTransactionType.value.isEmpty
                ? null
                : selectedTransactionType.value,
            items: [
              DropdownMenuItem<String>(
                value: 'DROPOFF',
                alignment: AlignmentDirectional.center,
                child: Text('dropOff'.tr),
              ),
              DropdownMenuItem<String>(
                value: 'PICKUP',
                alignment: AlignmentDirectional.center,
                child: Text('pickUp'.tr),
              ),
            ],
            onChanged: (newValue) {
              selectedTransactionType.value = newValue ?? '';
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.arrow_swap_horizontal),
              labelText: 'transactionType'.tr,
            ),
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwInputFields),

        // Location Detail
        TextFormField(
          controller: locationController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Iconsax.location),
            labelText: 'locationDetail'.tr,
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
                firstDate: DateTime.now().subtract(const Duration(days: 7)),
                lastDate: DateTime.now().add(const Duration(days: 30)),
              );
              if (pickedDate != null) {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(
                    selectedDate.value ?? DateTime.now(),
                  ),
                );
                if (pickedTime != null) {
                  selectedDate.value = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                }
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.calendar_1),
              labelText: 'selectDate'.tr,
              hintText: selectedDate.value != null
                  ? '${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year} ${selectedDate.value!.hour.toString().padLeft(2, '0')}:${selectedDate.value!.minute.toString().padLeft(2, '0')}'
                  : 'tapToSelectDate'.tr,
            ),
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwSections),

        // Upload Picture Section
        Obx(
          () => REYSectionHeading(
            title: 'uploadProof'.tr,
            showActionButton: cameraController.selectedImage.value != null,
            buttonTitle: 'removePhoto'.tr,
            onPressed: () {
              cameraController.selectedImage.value = null;
            },
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwItems),

        // Image Preview
        Obx(
          () => GestureDetector(
            onTap: () {
              if (cameraController.selectedImage.value == null) {
                REYImagePickerBottomSheet.show(context: context);
              } else {
                REYImagePreviewDialog.showFile(
                  context: context,
                  imageFile: cameraController.selectedImage.value!,
                );
              }
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(REYSizes.borderRadiusMd),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.grey.shade50,
                ),
                child: cameraController.selectedImage.value != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                          REYSizes.borderRadiusMd,
                        ),
                        child: Image.file(
                          cameraController.selectedImage.value!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.image,
                            size: REYSizes.iconLg * 1.5,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: REYSizes.sm),
                          Text(
                            'tapToAddImage'.tr,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: REYSizes.fontSizeSm,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwSections),

        // Action Buttons
        Obx(
          () => Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: cameraController.selectedImage.value != null
                      ? () => REYImagePickerBottomSheet.show(context: context)
                      : null,
                  child: Text('changeImage'.tr),
                ),
              ),
              const SizedBox(width: REYSizes.spaceBtwItems),
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
                          height: REYSizes.md + 4,
                          width: REYSizes.md + 4,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text('submit'.tr),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: REYSizes.spaceBtwSections),
      ],
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
        title: 'error'.tr,
        message: 'selectWasteTypeFirst'.tr,
      );
      return;
    }

    if (selectedTransactionType.value.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'error'.tr,
        message: 'selectTransactionTypeFirst'.tr,
      );
      return;
    }

    if (locationController.text.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'error'.tr,
        message: 'enterLocationDetail'.tr,
      );
      return;
    }

    if (selectedDate.value == null) {
      REYLoaders.errorSnackBar(
        title: 'error'.tr,
        message: 'selectTransactionDate'.tr,
      );
      return;
    }

    if (cameraController.selectedImage.value == null) {
      REYLoaders.errorSnackBar(title: 'error'.tr, message: 'takePhotoProof'.tr);
      return;
    }

    // Convert image to base64 for API
    String base64Image = '';
    try {
      final bytes = await cameraController.selectedImage.value!.readAsBytes();
      base64Image = 'data:image/jpeg;base64,${base64Encode(bytes)}';
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'error'.tr,
        message: 'failedToProcessImage'.tr,
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

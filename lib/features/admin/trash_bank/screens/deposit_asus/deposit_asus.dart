import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/user/leaderboard/models/leaderboard_model.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/deposit_asus_controller.dart';
import 'package:eco_waste/features/user/trash_bank/models/deposit_asus_model.dart';
import 'package:eco_waste/features/user/trash_bank/screens/deposit/widgets/deposit_image_proof.dart';
import 'package:eco_waste/features/user/trash_bank/screens/deposit/widgets/deposit_tutorial_carousel.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class DepositAsusScreen extends StatelessWidget {
  const DepositAsusScreen({
    super.key,
    required this.username,
    required this.userId,
    required this.desaId,
  });

  final String username, userId, desaId;

  @override
  Widget build(BuildContext context) {
    RxString jenisSampah = ''.obs;
    RxString beratSampah = ''.obs;
    RxString suhuPembakaran = ''.obs;

    final DepositAsusController depositAsusController = Get.put(
      DepositAsusController(),
    );

    // depositAsusController.getWasteType();

    final dark = REYHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'depositWaste'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          children: [
            // Tutorial Carousel
            const DepositTutorialCarousel(),
            const SizedBox(height: REYSizes.spaceBtwSections),

            // Deposit List
            REYSectionHeading(title: 'depositWaste'.tr),
            const SizedBox(height: REYSizes.spaceBtwItems),

            Obx(() {
              if (depositAsusController.isLoading.value) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(REYColors.primary),
                );
              }

              return Form(
                child: Column(
                  children: [
                    // Jenis Sampah
                    DropdownButtonFormField<String>(
                      value: jenisSampah.value.isEmpty
                          ? null
                          : jenisSampah.value,
                      items: depositAsusController.mockWasteTypes.map((
                        wasteType,
                      ) {
                        return DropdownMenuItem<String>(
                          value: wasteType.name,
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            wasteType.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        jenisSampah.value = newValue!;
                        depositAsusController.update();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.trash),
                        labelText: 'wasteType'.tr,
                      ),
                    ),

                    const SizedBox(height: REYSizes.spaceBtwInputFields),

                    // Berat Sampah
                    TextFormField(
                      initialValue: beratSampah.value,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.weight),
                        labelText: 'wasteWeight'.tr,
                      ),
                      onChanged: (value) {
                        beratSampah.value = value;
                        depositAsusController.update();
                      },
                    ),

                    const SizedBox(height: REYSizes.spaceBtwInputFields),

                    // Suhu Pembakaran
                    TextFormField(
                      initialValue: suhuPembakaran.value,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.sun_1),
                        labelText: 'temperatureBurning'.tr,
                      ),
                      onChanged: (value) {
                        suhuPembakaran.value = (value);
                        depositAsusController.update();
                      },
                    ),

                    const SizedBox(height: REYSizes.spaceBtwInputFields),

                    // Price Calculation
                    const Divider(),
                    Obx(() {
                      if (jenisSampah.value.isEmpty ||
                          beratSampah.value.isEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '    ${'totalPrice'.tr}:',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '-    ',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        );
                      }

                      final selectedOption = depositAsusController
                          .mockWasteTypes
                          .firstWhere(
                            (option) => option.name == jenisSampah.value,
                          );
                      final berat = double.tryParse(beratSampah.value) ?? 0;
                      final harga = selectedOption.pointsPerKg * berat;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '    ${'totalPrice'.tr}:',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp',
                              decimalDigits: 2,
                            ).format(harga),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      );
                    }),
                    const Divider(),

                    const SizedBox(height: REYSizes.spaceBtwInputFields),

                    // Bukti Setor Gambar
                    REYSectionHeading(
                      title: 'depositProof'.tr,
                      showActionButton: true,
                      buttonTitle: 'removePhoto'.tr,
                      onPressed: () {
                        depositAsusController.selectedImage.value = null;
                      },
                    ),

                    const SizedBox(height: REYSizes.spaceBtwItems / 2),

                    Obx(() {
                      final image = depositAsusController.selectedImage.value;

                      return AspectRatio(
                        aspectRatio: 16 / 9,
                        child: GestureDetector(
                          onTap: image == null
                              ? () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return DepositImageBottomSheet(
                                      depositAsusController:
                                          depositAsusController,
                                    );
                                  },
                                )
                              : null,
                          child: image == null
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: dark
                                        ? REYColors.dark
                                        : REYColors.lightGrey,
                                    borderRadius: BorderRadius.circular(
                                      REYSizes.inputFieldRadius,
                                    ),
                                    border: Border.all(
                                      color: dark
                                          ? REYColors.darkerGrey
                                          : REYColors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.image,
                                          size: 48,
                                          color: dark
                                              ? REYColors.grey
                                              : REYColors.darkGrey,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Tap untuk upload foto',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    REYSizes.inputFieldRadius,
                                  ),
                                  child: Image.file(
                                    image,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      );
                    }),

                    const SizedBox(height: REYSizes.spaceBtwSections),

                    // Tombol Ganti Foto dan Kumpulkan
                    Row(
                      children: [
                        // Change Photo Button
                        Expanded(
                          child: Obx(() {
                            final image =
                                depositAsusController.selectedImage.value;

                            return OutlinedButton(
                              onPressed: image == null
                                  ? null
                                  : () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return DepositImageBottomSheet(
                                            depositAsusController:
                                                depositAsusController,
                                          );
                                        },
                                      );
                                    },
                              child: const Text("Ganti Foto"),
                            );
                          }),
                        ),

                        const SizedBox(width: REYSizes.spaceBtwItems),

                        // Submit Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              final selectedOption = depositAsusController
                                  .mockWasteTypes
                                  .firstWhere(
                                    (option) =>
                                        option.name == jenisSampah.value,
                                  );
                              final berat =
                                  double.tryParse(beratSampah.value) ?? 0;
                              final harga = selectedOption.pointsPerKg * berat;

                              final depositAsusModel = DepositAsusModel(
                                username: username,
                                desaId: desaId,
                                berat: berat,
                                jenisSampah: jenisSampah.value,
                                poin: harga,
                                waktu: DateTime.now(),
                                rt: '00',
                                rw: '00',
                                userId: userId,
                                available: true,
                                wasteTypeId: selectedOption.id,
                              );

                              final leaderboardModel = LeaderboardModel(
                                id: '',
                                name: username,
                                points: harga.toInt(),
                                avatar: null,
                                locationId:
                                    '', // You may need to get this from user data
                                rank: 0, // Will be calculated by the API
                                userId: userId,
                              );

                              depositAsusController.postDeposit(
                                depositAsusModel,
                                leaderboardModel,
                              );
                            },
                            child: Text('collect'.tr),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: REYSizes.spaceBtwSections),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
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

    depositAsusController.getWasteType();

    final dark = REYHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'Setor Sampah',
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
            const REYSectionHeading(title: 'Setor Sampah'),
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
                      items: depositAsusController.wasteType.map((wasteType) {
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
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.trash),
                        labelText: 'Jenis Sampah',
                      ),
                    ),

                    const SizedBox(height: REYSizes.spaceBtwInputFields),

                    // Berat Sampah
                    TextFormField(
                      initialValue: beratSampah.value,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.weight),
                        labelText: 'Berat Sampah (kg)',
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
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.sun_1),
                        labelText: 'Suhu Pembakaran (\u00B0C)',
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
                              '    Total harga:',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '-    ',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        );
                      }

                      final selectedOption = depositAsusController.wasteType
                          .firstWhere(
                            (option) => option.name == jenisSampah.value,
                          );
                      final berat = double.tryParse(beratSampah.value) ?? 0;
                      final harga = selectedOption.pricePerKg * berat;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '    Total harga:',
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
                      title: 'Bukti Setor',
                      showActionButton: true,
                      buttonTitle: "Hapus Foto",
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
                                  .wasteType
                                  .firstWhere(
                                    (option) =>
                                        option.name == jenisSampah.value,
                                  );
                              final berat =
                                  double.tryParse(beratSampah.value) ?? 0;
                              final harga = selectedOption.pricePerKg * berat;

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

                              depositAsusController.postDeposit(
                                depositAsusModel,
                              );
                            },
                            child: const Text('Kumpulkan'),
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

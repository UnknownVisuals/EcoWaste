import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/deposit_asus_controller.dart';
import 'package:eco_waste/features/user/trash_bank/models/deposit_asus_model.dart';
import 'package:eco_waste/features/user/trash_bank/screens/deposit/widgets/deposit_tutorial_carousel.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
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
    RxString jenisSampahController = ''.obs;
    RxString beratSampahController = ''.obs;

    final DepositAsusController depositAsusController = Get.put(
      DepositAsusController(),
    );

    depositAsusController.getWasteType();

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
                      value: jenisSampahController.value.isEmpty
                          ? null
                          : jenisSampahController.value,
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
                        jenisSampahController.value = newValue!;
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
                      initialValue: beratSampahController.value,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.weight),
                        labelText: 'Berat Sampah (kg)',
                      ),
                      onChanged: (value) {
                        beratSampahController.value = value;
                        depositAsusController.update();
                      },
                    ),

                    // const SizedBox(height: REYSizes.spaceBtwInputFields),

                    // // TPS
                    // TextFormField(
                    //   initialValue: tpsRTController.value,
                    //   decoration: const InputDecoration(
                    //     prefixIcon: Icon(Iconsax.box),
                    //     labelText: 'TPS',
                    //   ),
                    //   onChanged: (value) {
                    //     tpsRTController.value = value;
                    //     depositAsusController.update();
                    //   },
                    // ),

                    // const SizedBox(height: REYSizes.spaceBtwInputFields),

                    // // Lokasi
                    // TextFormField(
                    //   initialValue: lokasiRWController.value,
                    //   decoration: const InputDecoration(
                    //     prefixIcon: Icon(Iconsax.location),
                    //     labelText: 'Lokasi',
                    //   ),
                    //   onChanged: (value) {
                    //     lokasiRWController.value = value;
                    //     depositAsusController.update();
                    //   },
                    // ),
                    const SizedBox(height: REYSizes.spaceBtwItems),
                    const Divider(),

                    // Price Calculation
                    Obx(() {
                      if (jenisSampahController.value.isEmpty ||
                          beratSampahController.value.isEmpty) {
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
                            (option) =>
                                option.name == jenisSampahController.value,
                          );
                      final berat =
                          double.tryParse(beratSampahController.value) ?? 0;
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
                    const SizedBox(height: REYSizes.spaceBtwItems),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final selectedOption = depositAsusController.wasteType
                              .firstWhere(
                                (option) =>
                                    option.name == jenisSampahController.value,
                              );
                          final berat =
                              double.tryParse(beratSampahController.value) ?? 0;
                          final harga = selectedOption.pricePerKg * berat;

                          final depositAsusModel = DepositAsusModel(
                            username: username,
                            desaId: desaId,
                            berat: berat,
                            jenisSampah: jenisSampahController.value,
                            poin: harga,
                            waktu: DateTime.now(),
                            rt: '00',
                            rw: '00',
                            userId: userId,
                            available: true,
                            wasteTypeId: selectedOption.id,
                          );

                          depositAsusController.postDeposit(depositAsusModel);
                        },
                        child: const Text('Kumpulkan'),
                      ),
                    ),
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

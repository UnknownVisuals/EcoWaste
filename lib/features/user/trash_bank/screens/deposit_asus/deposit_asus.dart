import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/deposit_asus_controller.dart';
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
    final DepositAsusController depositAsusController = Get.put(
      DepositAsusController(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (depositAsusController.wasteType.isEmpty) {
        depositAsusController.getWasteType();
      }
    });

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
                      value:
                          depositAsusController.selectedWasteType.value.isEmpty
                          ? null
                          : depositAsusController.selectedWasteType.value,
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
                        depositAsusController.setWasteType(newValue!);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.trash),
                        labelText: 'Jenis Sampah',
                      ),
                    ),
                    const SizedBox(height: REYSizes.spaceBtwInputFields),

                    // Berat Sampah
                    TextFormField(
                      initialValue: depositAsusController.beratSampah.value,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.weight),
                        labelText: 'Berat Sampah (kg)',
                      ),
                      onChanged: (value) {
                        depositAsusController.setBeratSampah(value);
                      },
                    ),
                    const SizedBox(height: REYSizes.spaceBtwInputFields),

                    // Kalkulasi Total Harga
                    const Divider(),
                    Obx(() {
                      if (depositAsusController
                              .selectedWasteType
                              .value
                              .isEmpty ||
                          depositAsusController.beratSampah.value.isEmpty) {
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
                                option.name ==
                                depositAsusController.selectedWasteType.value,
                          );
                      final berat =
                          double.tryParse(
                            depositAsusController.beratSampah.value,
                          ) ??
                          0;
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
                              ? () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SafeArea(
                                        child: Wrap(
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Iconsax.image,
                                              ),
                                              title: Text(
                                                'Pilih dari Galeri',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium,
                                              ),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                await depositAsusController
                                                    .pickImageFromGallery();
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                Iconsax.camera,
                                              ),
                                              title: Text(
                                                'Ambil dari Kamera',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium,
                                              ),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                await depositAsusController
                                                    .captureImageWithCamera();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              : null,
                          child: image == null
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: REYColors.lightGrey,
                                    borderRadius: BorderRadius.circular(
                                      REYSizes.inputFieldRadius,
                                    ),
                                    border: Border.all(
                                      color: REYColors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.image,
                                          size: 48,
                                          color: REYColors.darkerGrey,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Tap untuk upload foto',
                                          style: TextStyle(
                                            color: REYColors.darkerGrey,
                                          ),
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
                    const SizedBox(height: REYSizes.spaceBtwInputFields),

                    // Tombol Ganti Foto dan Kumpulkan
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            final image =
                                depositAsusController.selectedImage.value;

                            // Button to change photo
                            return OutlinedButton(
                              onPressed: image == null
                                  ? null
                                  : () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return SafeArea(
                                            child: Wrap(
                                              children: [
                                                ListTile(
                                                  leading: const Icon(
                                                    Iconsax.image,
                                                  ),
                                                  title: Text(
                                                    'Pilih dari Galeri',
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.bodyMedium,
                                                  ),
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                    await depositAsusController
                                                        .pickImageFromGallery();
                                                  },
                                                ),
                                                ListTile(
                                                  leading: const Icon(
                                                    Iconsax.camera,
                                                  ),
                                                  title: Text(
                                                    'Ambil dari Kamera',
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.bodyMedium,
                                                  ),
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                    await depositAsusController
                                                        .captureImageWithCamera();
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                              child: const Text("Ganti Foto"),
                            );
                          }),
                        ),
                        const SizedBox(width: REYSizes.spaceBtwItems),

                        // Button to submit deposit
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              depositAsusController.submitDeposit(
                                username: username,
                                userId: userId,
                                desaId: desaId,
                              );
                            },
                            child: const Text('Kumpulkan'),
                          ),
                        ),
                      ],
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

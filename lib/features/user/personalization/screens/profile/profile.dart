import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/circular_image.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/user/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/schedule_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.username,
    required this.email,
    required this.desaId,
  });

  final String username, email, desaId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleController());
    final schedule = controller.schedule.firstWhere(
      (schedule) => schedule.desaId == desaId,
    );

    return Scaffold(
      appBar: const REYAppBar(showBackArrow: true, title: Text('Profil')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(REYSizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const REYCircularImage(
                      image: REYImages.user,
                      width: 100,
                      height: 100,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Ubah gambar profil',
                        style: TextStyle(color: REYColors.primary),
                      ),
                    ),
                  ],
                ),
              ),

              // Divider
              const SizedBox(height: REYSizes.spaceBtwSections / 2),
              const Divider(),
              const SizedBox(height: REYSizes.spaceBtwSections),

              // Profile Info
              const REYSectionHeading(title: 'Informasi profil'),
              const SizedBox(height: REYSizes.spaceBtwItems),

              ProfileMenu(title: 'Nama', value: username, onPressed: () {}),
              ProfileMenu(title: 'Email', value: email, onPressed: () {}),
              ProfileMenu(
                title: 'Desa',
                value: schedule.desa.nama,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Kecamatan',
                value: schedule.desa.kecamatan,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Kabupaten/Kota',
                value: schedule.desa.kabupaten,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Provinsi',
                value: schedule.desa.provinsi,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

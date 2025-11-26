import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/bloc/bottom_nav_cubit.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_assets.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, index) {
        return BottomNavigationBar(
          currentIndex: index,
          onTap: (i) => context.read<BottomNavCubit>().changeTab(i),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: AppColors.grey,
          backgroundColor: AppColors.white,
          showUnselectedLabels: true,
          items: [
            _item(
              isActive: index == 0,
              activeAsset: AppAssets.icHomeActive,
              inactiveAsset: AppAssets.icHome,
              label: 'HOME',
            ),
            _item(
              isActive: index == 1,
              activeAsset: AppAssets.icMallActive,
              inactiveAsset: AppAssets.icMall,
              label: 'MALL',
            ),
            _item(
              isActive: index == 2,
              activeAsset: AppAssets
                  .icDiscover, // Assuming icDiscover is the active state icon
              inactiveAsset: AppAssets.icDiscover,
              label: 'DISCOVER',
            ),
            _item(
              isActive: index == 3,
              activeAsset: AppAssets
                  .icInbox, // Assuming icInbox is the active state icon
              inactiveAsset: AppAssets.icInbox,
              label: 'INBOX',
            ),
            _item(
              isActive: index == 4,
              activeAsset: AppAssets
                  .icAccount, // Assuming icAccount is the active state icon
              inactiveAsset: AppAssets.icAccount,
              label: 'ACCOUNT',
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _item({
    required bool isActive,
    required String activeAsset,
    required String inactiveAsset,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(inactiveAsset, width: 22, height: 22),
      activeIcon: Image.asset(activeAsset, width: 22, height: 22),
      label: label,
    );
  }
}

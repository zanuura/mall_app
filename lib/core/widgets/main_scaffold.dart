import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_mobile_test/common/bloc/bottom_nav_cubit.dart';
import 'package:mall_mobile_test/core/widgets/navigations/bottom_nav_bar.dart';
import 'package:mall_mobile_test/features/home/presentation/pages/home_page.dart'; // Akan dibuat
import 'package:mall_mobile_test/features/mall/presentation/pages/mall_page.dart';
// Import pages lainnya di sini

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, index) {
        return Scaffold(
          body: IndexedStack(
            index: index,
            children: const [
              // Pages yang sesuai dengan urutan di BottomNav
              HomePage(), // Index 0
              MallPage(), // Index 1
              Center(child: Text('DISCOVER PAGE')), // Index 2
              Center(child: Text('INBOX PAGE')), // Index 3
              Center(child: Text('ACCOUNT PAGE')), // Index 4
            ],
          ),
          bottomNavigationBar: const AppBottomNavBar(),
        );
      },
    );
  }
}

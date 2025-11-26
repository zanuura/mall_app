import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_mobile_test/common/bloc/bottom_nav_cubit.dart';
import 'package:mall_mobile_test/core/widgets/main_scaffold.dart';
import 'package:mall_mobile_test/features/home/presentation/bloc/home_bloc.dart'; // Import HomeBloc
import 'package:mall_mobile_test/features/home/presentation/bloc/home_event.dart';
import 'package:mall_mobile_test/features/mall/presentation/bloc/mall_bloc.dart';
import 'package:mall_mobile_test/features/mall/presentation/bloc/mall_event.dart'; // Import MallBloc

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider(
          create: (_) => HomeBloc()..add(const LoadHomeData()),
        ), // Load data saat startup
        BlocProvider(
          create: (_) => MallBloc()..add(const LoadMallProducts()),
        ), // Load data saat startup
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: const Color(0xFF386641)),
        home: const MainScaffold(),
      ),
    );
  }
}

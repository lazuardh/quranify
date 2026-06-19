import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LastReadCubit>()),
        BlocProvider(create: (_) => getIt<GetQuranCubit>()),
        BlocProvider(create: (_) => getIt<GetDataCubit>()),
        BlocProvider(create: (_) => getIt<GetAudioCubit>()),
        BlocProvider(create: (_) => getIt<AudioPlayerCubit>()),
        BlocProvider(create: (_) => getIt<HomeCubit>()),
        BlocProvider(create: (_) => getIt<BookmarkCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: QuranifyTheme().of(context),
        home: SplashScreen(),
      ),
    );
  }
}

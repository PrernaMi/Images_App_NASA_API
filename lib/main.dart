import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_images/bloc/mars_bloc.dart';
import 'package:mars_images/data/remote/api_helper.dart';
import 'package:mars_images/data/remote/app_repo.dart';
import 'package:mars_images/providers/theme_provider.dart';
import 'package:mars_images/screens/home_screen.dart';
import 'package:mars_images/screens/search_flight.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiBlocProvider(providers: [
        BlocProvider(create: (context){
          return MarsBloc(appRepo: AppRepo(apiHelper: ApiHelper()));
        }),
        ChangeNotifierProvider(create: (context){
          return ThemeProvider();
        })
      ], child: MyApp())
      );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    context.read<ThemeProvider>().getDefaultTheme();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: context.watch<ThemeProvider>().getTheme()
          ? ThemeMode.dark
          : ThemeMode.light,
      home: HomePage(),
    );
  }
}

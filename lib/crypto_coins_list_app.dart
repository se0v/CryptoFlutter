import 'package:fluttapp/router/router.dart';
import 'package:fluttapp/theme/theme.dart';
import 'package:flutter/material.dart';

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoCurrenciesList',
      theme: darkTheme,
      routes: routes,
      //initialRoute: '/coins-list',//instead of "/" in routes for default
      //home: const CryptoListScreen(title: 'CryptoCurrenciesList'), //instead of routes
    );
  }
}
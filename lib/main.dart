import 'package:dio/dio.dart';
import 'package:fluttapp/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:fluttapp/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'crypto_coins_list_app.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(() => CryptoCoinsRepository(dio: Dio()));//LazySingleton like lateinit
  runApp(const CryptoCurrenciesListApp());
}
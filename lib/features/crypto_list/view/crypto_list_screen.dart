import 'package:fluttapp/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../repositories/crypto_coins/models/crypto_coin.dart';
import '../widgets/crypto_coin_tile.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});
  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  /*int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }*/
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: (_cryptoCoinsList == null)
          ? const Center(child: CircularProgressIndicator())
      : ListView.separated(
        padding: const EdgeInsets.only(top:16),
        itemCount: _cryptoCoinsList!.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          final coin = _cryptoCoinsList![i];
          return CryptoCoinTile(coin: coin);
        },
      ),
      /*floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.download),
          onPressed: () async {
            await _loadCryptoCoins();
    }),*/
    );
  }
  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await GetIt.I<AbstractCoinsRepository>().getCoinsList();
    setState(() {});
  }
}


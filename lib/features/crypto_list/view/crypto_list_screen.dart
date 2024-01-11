import 'dart:async';

import 'package:fluttapp/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:fluttapp/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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

  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
          },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded){
            return ListView.separated(
            padding: const EdgeInsets.only(top:16),
            itemCount: state.coinsList.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, i) {
            final coin = state.coinsList[i];
            return CryptoCoinTile(coin: coin);
            },
            );
            }
            if (state is CryptoListLoadingFailure){
              return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Something went wrong',
                      ),
                      Text(
                        'Please try again later'
                      ),
                    ],
                  ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),

      /*(_cryptoCoinsList == null)
          ? const Center(child: CircularProgressIndicator())
      */
      /*floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.download),
          onPressed: () async {
            await _loadCryptoCoins();
    }),*/
    );
  }
  /*Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await GetIt.I<AbstractCoinsRepository>().getCoinsList();
    setState(() {});
  }*/
}


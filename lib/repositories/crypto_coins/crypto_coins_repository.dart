import 'package:dio/dio.dart';
import 'package:fluttapp/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:fluttapp/repositories/crypto_coins/models/crypto_coin.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX,TONCOIN,CAG,DOV&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries
        .map((e) {
          final usdData = (e.value as Map<String, dynamic>) ['USD'] as Map<String, dynamic>;
          final price = usdData['PRICE'];
          final imageUrl = usdData['IMAGEURL'];

          return CryptoCoin(
              name: e.key,
              priceInUSD: price,
              imageUrl: 'https://www.cryptocompare.com/$imageUrl',
            );
        })
        .toList();
    return cryptoCoinsList;
  }
}
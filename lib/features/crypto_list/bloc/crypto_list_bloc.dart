import 'package:fluttapp/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/crypto_coins/models/crypto_coin.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        final coinsList = await coinsRepository.getCoinsList();
        emit(CryptoListLoaded(coinsList: coinsList));
      } catch (e) {
        emit(CryptoListLoadingFailure(exception: e));
      }
    });
  }
  final AbstractCoinsRepository coinsRepository;
}

//crypto_list_state.dart
class CryptoListState {

}

class CryptoListInitial extends CryptoListState {

}

class CryptoListLoading extends CryptoListState{

}

class CryptoListLoaded extends CryptoListState{
  CryptoListLoaded({
    required this.coinsList
  });

  final List<CryptoCoin> coinsList;

}

class CryptoListLoadingFailure extends CryptoListState{
  CryptoListLoadingFailure({
    this.exception
  });

  final Object? exception;
}

//crypto_list_event.dart
class CryptoListEvent {

}

class LoadCryptoList extends CryptoListEvent {

}


import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fluttapp/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/crypto_coins/models/crypto_coin.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        if (state is! CryptoListLoaded){
          emit(CryptoListLoading());
        }
        final coinsList = await coinsRepository.getCoinsList();
        emit(CryptoListLoaded(coinsList: coinsList));
      } catch (e) {
        emit(CryptoListLoadingFailure(exception: e));
      }
      finally {
        event.completer?.complete();
      }
    });
  }
  final AbstractCoinsRepository coinsRepository;
}

//crypto_list_state.dart
abstract class CryptoListState extends Equatable{

}

class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];

}

class CryptoListLoading extends CryptoListState{
  @override
  List<Object?> get props => [];

}

class CryptoListLoaded extends CryptoListState{
  CryptoListLoaded({
    required this.coinsList
  });

  final List<CryptoCoin> coinsList;

  @override
  List<Object?> get props => [coinsList];

}

class CryptoListLoadingFailure extends CryptoListState{
  CryptoListLoadingFailure({
    this.exception
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}

//crypto_list_event.dart
abstract class CryptoListEvent extends Equatable {

}

class LoadCryptoList extends CryptoListEvent {
  LoadCryptoList({
      this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}


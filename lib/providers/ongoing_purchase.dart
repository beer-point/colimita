import 'package:colimita/pages/payments/card_model.dart';
import 'package:colimita/pages/payments/card_verification_model.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'ongoing_purchase.freezed.dart';

@freezed
class OngoingPurchase with _$OngoingPurchase {
  factory OngoingPurchase({
    required num amount,
    required AsyncValue<bool> purchase,
    required bool saveCard,
    Either<CardModel, CardVerificationModel>? eitherCardOrVerification,
  }) = _OngoingPurchase;
}

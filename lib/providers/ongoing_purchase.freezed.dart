// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ongoing_purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OngoingPurchaseTearOff {
  const _$OngoingPurchaseTearOff();

  _OngoingPurchase call(
      {required num amount,
      required AsyncValue<bool> purchase,
      required bool saveCard,
      Either<CardModel, CardVerificationModel>? eitherCardOrVerification}) {
    return _OngoingPurchase(
      amount: amount,
      purchase: purchase,
      saveCard: saveCard,
      eitherCardOrVerification: eitherCardOrVerification,
    );
  }
}

/// @nodoc
const $OngoingPurchase = _$OngoingPurchaseTearOff();

/// @nodoc
mixin _$OngoingPurchase {
  num get amount => throw _privateConstructorUsedError;
  AsyncValue<bool> get purchase => throw _privateConstructorUsedError;
  bool get saveCard => throw _privateConstructorUsedError;
  Either<CardModel, CardVerificationModel>? get eitherCardOrVerification =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OngoingPurchaseCopyWith<OngoingPurchase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OngoingPurchaseCopyWith<$Res> {
  factory $OngoingPurchaseCopyWith(
          OngoingPurchase value, $Res Function(OngoingPurchase) then) =
      _$OngoingPurchaseCopyWithImpl<$Res>;
  $Res call(
      {num amount,
      AsyncValue<bool> purchase,
      bool saveCard,
      Either<CardModel, CardVerificationModel>? eitherCardOrVerification});
}

/// @nodoc
class _$OngoingPurchaseCopyWithImpl<$Res>
    implements $OngoingPurchaseCopyWith<$Res> {
  _$OngoingPurchaseCopyWithImpl(this._value, this._then);

  final OngoingPurchase _value;
  // ignore: unused_field
  final $Res Function(OngoingPurchase) _then;

  @override
  $Res call({
    Object? amount = freezed,
    Object? purchase = freezed,
    Object? saveCard = freezed,
    Object? eitherCardOrVerification = freezed,
  }) {
    return _then(_value.copyWith(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      purchase: purchase == freezed
          ? _value.purchase
          : purchase // ignore: cast_nullable_to_non_nullable
              as AsyncValue<bool>,
      saveCard: saveCard == freezed
          ? _value.saveCard
          : saveCard // ignore: cast_nullable_to_non_nullable
              as bool,
      eitherCardOrVerification: eitherCardOrVerification == freezed
          ? _value.eitherCardOrVerification
          : eitherCardOrVerification // ignore: cast_nullable_to_non_nullable
              as Either<CardModel, CardVerificationModel>?,
    ));
  }
}

/// @nodoc
abstract class _$OngoingPurchaseCopyWith<$Res>
    implements $OngoingPurchaseCopyWith<$Res> {
  factory _$OngoingPurchaseCopyWith(
          _OngoingPurchase value, $Res Function(_OngoingPurchase) then) =
      __$OngoingPurchaseCopyWithImpl<$Res>;
  @override
  $Res call(
      {num amount,
      AsyncValue<bool> purchase,
      bool saveCard,
      Either<CardModel, CardVerificationModel>? eitherCardOrVerification});
}

/// @nodoc
class __$OngoingPurchaseCopyWithImpl<$Res>
    extends _$OngoingPurchaseCopyWithImpl<$Res>
    implements _$OngoingPurchaseCopyWith<$Res> {
  __$OngoingPurchaseCopyWithImpl(
      _OngoingPurchase _value, $Res Function(_OngoingPurchase) _then)
      : super(_value, (v) => _then(v as _OngoingPurchase));

  @override
  _OngoingPurchase get _value => super._value as _OngoingPurchase;

  @override
  $Res call({
    Object? amount = freezed,
    Object? purchase = freezed,
    Object? saveCard = freezed,
    Object? eitherCardOrVerification = freezed,
  }) {
    return _then(_OngoingPurchase(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      purchase: purchase == freezed
          ? _value.purchase
          : purchase // ignore: cast_nullable_to_non_nullable
              as AsyncValue<bool>,
      saveCard: saveCard == freezed
          ? _value.saveCard
          : saveCard // ignore: cast_nullable_to_non_nullable
              as bool,
      eitherCardOrVerification: eitherCardOrVerification == freezed
          ? _value.eitherCardOrVerification
          : eitherCardOrVerification // ignore: cast_nullable_to_non_nullable
              as Either<CardModel, CardVerificationModel>?,
    ));
  }
}

/// @nodoc

class _$_OngoingPurchase implements _OngoingPurchase {
  _$_OngoingPurchase(
      {required this.amount,
      required this.purchase,
      required this.saveCard,
      this.eitherCardOrVerification});

  @override
  final num amount;
  @override
  final AsyncValue<bool> purchase;
  @override
  final bool saveCard;
  @override
  final Either<CardModel, CardVerificationModel>? eitherCardOrVerification;

  @override
  String toString() {
    return 'OngoingPurchase(amount: $amount, purchase: $purchase, saveCard: $saveCard, eitherCardOrVerification: $eitherCardOrVerification)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _OngoingPurchase &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.purchase, purchase) ||
                const DeepCollectionEquality()
                    .equals(other.purchase, purchase)) &&
            (identical(other.saveCard, saveCard) ||
                const DeepCollectionEquality()
                    .equals(other.saveCard, saveCard)) &&
            (identical(
                    other.eitherCardOrVerification, eitherCardOrVerification) ||
                const DeepCollectionEquality().equals(
                    other.eitherCardOrVerification, eitherCardOrVerification)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(purchase) ^
      const DeepCollectionEquality().hash(saveCard) ^
      const DeepCollectionEquality().hash(eitherCardOrVerification);

  @JsonKey(ignore: true)
  @override
  _$OngoingPurchaseCopyWith<_OngoingPurchase> get copyWith =>
      __$OngoingPurchaseCopyWithImpl<_OngoingPurchase>(this, _$identity);
}

abstract class _OngoingPurchase implements OngoingPurchase {
  factory _OngoingPurchase(
          {required num amount,
          required AsyncValue<bool> purchase,
          required bool saveCard,
          Either<CardModel, CardVerificationModel>? eitherCardOrVerification}) =
      _$_OngoingPurchase;

  @override
  num get amount => throw _privateConstructorUsedError;
  @override
  AsyncValue<bool> get purchase => throw _privateConstructorUsedError;
  @override
  bool get saveCard => throw _privateConstructorUsedError;
  @override
  Either<CardModel, CardVerificationModel>? get eitherCardOrVerification =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OngoingPurchaseCopyWith<_OngoingPurchase> get copyWith =>
      throw _privateConstructorUsedError;
}

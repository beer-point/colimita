class PaymentCard {
  final String id;
  final String lastFourDigits;
  final num expirationMonth;
  final num expirationYear;
  final String method;
  final String methodThumbnail;

  PaymentCard(
      {required this.id,
      required this.lastFourDigits,
      required this.expirationMonth,
      required this.expirationYear,
      required this.method,
      required this.methodThumbnail});

  static PaymentCard? fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      return PaymentCard(
          id: map['id'] ?? '',
          lastFourDigits: map['last_four_digits'],
          expirationMonth: map['expiration_month'],
          expirationYear: map['expiration_year'],
          method: map['issuer']['name'],
          methodThumbnail: map['payment_method']['secure_thumbnail']);
    }
  }

  get number {
    return '**** **** **** $lastFourDigits';
  }
}

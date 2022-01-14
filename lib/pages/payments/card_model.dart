import 'package:colimita/utils/datetime.dart';

class CardModel {
  String cardNumber;
  String cardholderName;
  String expDate;
  String securityCode;

  CardModel({
    required this.cardNumber,
    required this.cardholderName,
    required this.expDate,
    required this.securityCode,
  });

  get expMonth {
    return leadingZeros(int.parse(expDate.split('/')[0]));
  }

  get expYear {
    return '20' + expDate.split('/')[1];
  }
}

import 'package:colimita/domain/brewer.dart';

class Beer {
  final String name;
  final String type;
  final String description;
  final int costPerLt;
  final num alcoholPercent;
  final String photoUrl;
  final Brewer brewer;

  Beer({
    required this.name,
    required this.type,
    required this.description,
    required this.costPerLt,
    required this.alcoholPercent,
    required this.photoUrl,
    required this.brewer,
  });

  static Beer? fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      return Beer(
        name: map['name'],
        type: map['type'],
        description: map['description'],
        costPerLt: (map['costPerLt'] as num).toInt(),
        alcoholPercent: map['alcoholPercent'],
        photoUrl: map['photoUrl'],
        brewer: map['brewer'],
      );
    }
  }
}

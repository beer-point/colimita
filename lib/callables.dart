import 'package:cloud_functions/cloud_functions.dart';

HttpsCallable syncWithStation =
    FirebaseFunctions.instanceFor(region: 'southamerica-east1')
        .httpsCallable('syncWithStation');

HttpsCallable recharge =
    FirebaseFunctions.instanceFor(region: 'southamerica-east1')
        .httpsCallable('recharge');

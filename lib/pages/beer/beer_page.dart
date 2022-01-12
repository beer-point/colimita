import 'package:colimita/domain/beer.dart';
import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';

class BeerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Beer beer = ModalRoute.of(context)?.settings.arguments as Beer;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: const [BackButton()],
            ),
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(beer.photoUrl,
                      headers: {'Cache-Control': 'max-age=200'}),
                ),
              ),
            ),
            AppTypography.subtitle(beer.name),
            AppTypography.body(beer.brewer.name),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppTypography.body('ABV ${beer.alcoholPercent} %'),
                  AppTypography.body('\$ ${beer.costPerLt}'),
                ],
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Center(child: AppTypography.body(beer.description))),
          ],
        ),
      ),
    );
  }
}

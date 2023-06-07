import 'package:farma_compara_flutter/core/constants/app_margin_and_sizes.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    this.msg = "Cargando...",
    Key? key,
  }) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(generalPadding),
              child: SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator()),
            ),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}

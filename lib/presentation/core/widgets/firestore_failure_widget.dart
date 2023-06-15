import 'package:farma_compara_flutter/domain/core/firestore_failure.dart';
import 'package:flutter/material.dart';

import 'format_widgets/error_text_with_image.dart';

class FirestoreFailureWidget extends StatelessWidget {
  final FirestoreFailure failure;

  const FirestoreFailureWidget({
    required this.failure,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (failure is FirestoreFailureUnexpected) {
      return const ErrorTextWithImage(
        msg: "Error inesperado, reporte bug en github",
        image: "assets/images/undraw_fixing_bugs_w7gi.svg",
      );
    }
    else if(failure is FirestoreFailureInsufficientPermissions){
      return const ErrorTextWithImage(
        msg: "No tienes permisos para realizar esta acción",
        image: "assets/images/undraw_access_denied_re_awnf.svg",
      );
    }
    else if(failure is FirestoreFailureNotFound){
      return const ErrorTextWithImage(
        msg: "No se encontró ningun elemento para la busqueda",
        image: "assets/images/undraw_not_found_re_bh2e.svg",
      );
    }

    else {
      return const ErrorTextWithImage(
        msg: "Excepción inesperada, esto no debería de haber sucedido",
        image: "assets/images/undraw_fixing_bugs_w7gi.svg",
      );
    }
  }
}

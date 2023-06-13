import 'package:farma_compara_flutter/domain/delivery/delivery_fee.dart';
import 'package:farma_compara_flutter/domain/delivery/price_range.dart';

class TestFixtures {
  static DeliveryFee farmaciaEnCasa = DeliveryFee(
    locations: {
      "spain": [
        PriceRange(
          price: 3.99,
          min: 1,
          max: 29.99,
        ),
        PriceRange(price: 2.99, min: 30, max: 59.99),
        PriceRange(price: 0.0, min: 60, max: 0)
      ],
      "portugal": [
        PriceRange(
          price: 4.95,
          min: 1,
          max: 29.99,
        ),
        PriceRange(price: 3.95, min: 30, max: 59.99),
        PriceRange(price: 0.0, min: 60, max: 0)
      ],
      "balearic": [
        PriceRange(
          price: 5.99,
          min: 1,
          max: 49.99,
        ),
        PriceRange(price: 4.99, min: 50, max: 99.99),
        PriceRange(price: 0.0, min: 100, max: 0)
      ],
      "formentera": [
        PriceRange(
          price: 9.69,
          min: 1,
          max: 49.99,
        ),
        PriceRange(price: 6.69, min: 50, max: 99.99),
        PriceRange(price: 0.0, min: 100, max: 0)
      ]
    },
    url: "https://www.farmaciaencasaonline.es/farmacia-en-casa-online-tarifas-y-condiciones-de-envio",
  );
}

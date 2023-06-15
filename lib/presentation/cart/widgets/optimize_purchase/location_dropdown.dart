import 'package:farma_compara/application/cart/cart_notifier.dart';
import 'package:farma_compara/domain/locations/locations_hierarchy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationDropdown extends ConsumerStatefulWidget {
  const LocationDropdown({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<LocationDropdown> createState() => _LocationDropdown();
}

class _LocationDropdown extends ConsumerState<LocationDropdown> {
  String newLocation = "spain";

  static Map<String, String> locations = LocationsHierarchy.specificLocations;

  @override
  void initState() {
    super.initState();
    newLocation = ref.read(cartNotifierProvider).location;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(5.0))),
      child: DropdownButton<String>(
        value: newLocation,
        isExpanded: true,
        alignment: Alignment.centerLeft,
        icon: const Icon(Icons.arrow_drop_down),
        underline: Container(),
        onChanged: (String? newOrder) {
          setState(() {
            newLocation = newOrder!;
          });
          ref.read(cartNotifierProvider.notifier).updateLocation(newLocation);
        },
        dropdownColor: Colors.grey[200],
        items: locations.keys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                locations[value]!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

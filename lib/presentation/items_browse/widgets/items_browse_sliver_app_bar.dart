import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../application/browser/browser_notifier.dart';
import '../../../application/browser/browser_state.dart';
import '../../../domain/items/i_items_browse_query.dart';
import '../../core/shared/cart_button.dart';
import '../../core/widgets/format_widgets/outlined_text_field.dart';

class ItemsBrowseSliverAppBar extends ConsumerStatefulWidget {
  const ItemsBrowseSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ItemsBrowseSliverAppBar> createState() => _ItemsBrowseSliverAppBarState();
}

class _ItemsBrowseSliverAppBarState extends ConsumerState<ItemsBrowseSliverAppBar> {
  late final TextEditingController textController;
  late FocusNode controllerFocus;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    controllerFocus = FocusNode();
  }

  @override
  void dispose() {
    textController.dispose();
    controllerFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isSearching ? _searchingAppBar() : _defaultSearchBar(context);
  }

  SliverAppBar _defaultSearchBar(BuildContext context) {
    return SliverAppBar(
      title: GestureDetector(
        onTap: () {
          _changeIsSearchingState(true);
        },
        child: Text(textController.text.isEmpty ? "Búsqueda" : textController.text),
      ),

      floating: true,
      actions: [
        IconButton(
          onPressed: () {
            ref.read(browserNotifierProvider.notifier).clear();
          },
          icon: const Icon(
            Icons.refresh,
          ),
          tooltip: "Recargar productos",
        ),
        IconButton(
          onPressed: () {
            Routemaster.of(context).push("filters");
          },
          icon: const Icon(
            Icons.filter_alt,
          ),
          tooltip: "Filtrar",
        ),
        IconButton(
          onPressed: () {
            _changeIsSearchingState(true);
          },
          icon: const Icon(
            Icons.search,
          ),
          tooltip: "Buscar por nombre",
        ),
        const CartButton(),
      ],
    );
  }

  SliverAppBar _searchingAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      floating: true,
      iconTheme: const IconThemeData(color: Colors.black),
      leading: IconButton(
        onPressed: () {
          _changeIsSearchingState(false);
        },
        icon: const Icon(
          Icons.arrow_back,
          semanticLabel: "Volver a barra normal",
        ),
      ),
      title: Semantics(
        label: textController.text.isEmpty
            ? "Campo de texto de búsqueda vacío"
            : "Campo de texto de búsqueda por el nombre ${textController.text}",
        child: OutlinedTextField(
          autocorrect: false,
          textInputAction: TextInputAction.search,
          controller: textController,
          onSubmit: _onSubmit,
          focusNode: controllerFocus,
        ),
      ),
    );
  }

  void _changeIsSearchingState(bool isSearching) {
    if (isSearching) {
      controllerFocus.requestFocus();
    } else {
      controllerFocus.unfocus();
    }

    setState(() {
      this.isSearching = isSearching;
    });
  }

  void _onSubmit(String text) {
    final BrowserState broswerState = ref.read(browserNotifierProvider);
    final IItemsBrowseQuery query = broswerState.query;

    if (text.isEmpty) {
      _updateQueryOnUrlComposer(query, "");
      return;
    }

    _updateQueryOnUrlComposer(query, text);
  }

  void _updateQueryOnUrlComposer(IItemsBrowseQuery query, String? text) {
    final BrowserNotifier broswerNotifier = ref.read(browserNotifierProvider.notifier);
    broswerNotifier.changeFilters(query.copyWith(
      filter: text,
    ));
  }
}

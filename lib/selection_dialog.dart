import 'package:flutter/material.dart';
import 'package:phone_country_picker/country_code.dart';

/// selection dialog used for selection of the country code
class SelectionDialog extends StatefulWidget {
  final List<CountryCode> elements;
  final bool showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final TextStyle textStyle;
  final BoxDecoration boxDecoration;
  final WidgetBuilder emptySearchBuilder;
  final bool showFlag;
  final double flagWidth;
  final Decoration flagDecoration;
  final Size size;
  final bool hideSearch;
  final Icon closeIcon;

  /// Background color of SelectionDialog
  final Color backgroundColor;

  /// Boxshaow color of SelectionDialog that matches CountryCodePicker barrier color
  final Color barrierColor;

  /// elements passed as favorite
  final List<CountryCode> favoriteElements;

  /// scroll bar thickness
  final double thickness;

  /// scroll bar radius
  final Radius radius;

  SelectionDialog(
    this.elements,
    this.favoriteElements, {
    Key key,
    this.showCountryOnly,
    this.emptySearchBuilder,
    InputDecoration searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.textStyle,
    this.boxDecoration,
    this.showFlag,
    this.flagWidth = 32,
    this.flagDecoration,
    this.size,
    this.backgroundColor,
    this.barrierColor,
    this.hideSearch = false,
    this.closeIcon,
    this.thickness = 5,
    this.radius = const Radius.circular(20),
  })  : assert(searchDecoration != null, 'searchDecoration must not be null!'),
        this.searchDecoration = searchDecoration.prefixIcon == null
            ? searchDecoration.copyWith(prefixIcon: Icon(Icons.search))
            : searchDecoration,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> with SingleTickerProviderStateMixin {
  /// this is useful for filtering purpose
  List<CountryCode> filteredElements;

  AnimationController rotationController;

  @override
  void initState() {
    filteredElements = widget.elements;
    rotationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    rotationController.forward(from: 0.0); // it starts the animation
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          clipBehavior: Clip.hardEdge,
          width: widget.size?.width ?? MediaQuery.of(context).size.width,
          height: widget.size?.height ?? MediaQuery.of(context).size.height * 0.85,
          decoration: widget.boxDecoration ??
              BoxDecoration(
                color: widget.backgroundColor ?? Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                boxShadow: [
                  BoxShadow(
                    color: widget.barrierColor ?? Colors.grey.withOpacity(1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RotationTransition(
                turns: CurvedAnimation(
                  parent: rotationController,
                  curve: Curves.easeIn,
                  reverseCurve: Curves.bounceInOut,
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  iconSize: 25,
                  icon: widget.closeIcon,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              if (!widget.hideSearch)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    style: widget.searchStyle,
                    decoration: widget.searchDecoration,
                    onChanged: _filterElements,
                  ),
                ),
              Expanded(
                child: Scrollbar(
                  thickness: widget.thickness,
                  radius: widget.radius,
                  child: ListView(
                    children: [
                      widget.favoriteElements.isEmpty
                          ? const DecoratedBox(decoration: BoxDecoration())
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...widget.favoriteElements.map(
                                  (favouriteItems) => SimpleDialogOption(
                                    child: _buildOption(favouriteItems),
                                    onPressed: () => _selectItem(favouriteItems),
                                  ),
                                ),
                                const Divider(),
                              ],
                            ),
                      if (filteredElements.isEmpty)
                        _buildEmptySearchWidget(context)
                      else
                        ...filteredElements.map(
                          (e) => SimpleDialogOption(
                            child: _buildOption(e),
                            onPressed: () {
                              _selectItem(e);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildOption(CountryCode countryCode) {
    return SizedBox(
      width: 400,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          if (widget.showFlag)
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              decoration: widget.flagDecoration,
              clipBehavior: widget.flagDecoration == null ? Clip.none : Clip.hardEdge,
              child: Image.asset(
                countryCode.flagUri,
                package: 'phone_country_picker',
                width: widget.flagWidth,
              ),
            ),
          Expanded(
            flex: 6,
            child: Text(
              countryCode.toCountryStringOnly(),
              overflow: TextOverflow.fade,
              style: widget.textStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              countryCode.toString(),
              overflow: TextOverflow.fade,
              style: widget.textStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchWidget(BuildContext context) {
    if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder(context);
    }

    return Center(
      child: Text('No country found'),
    );
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      filteredElements = widget.elements
          .where((e) => e.code.contains(s) || e.dialCode.contains(s) || e.name.toUpperCase().contains(s))
          .toList();
    });
  }

  void _selectItem(CountryCode e) {
    Navigator.pop(context, e);
  }
}

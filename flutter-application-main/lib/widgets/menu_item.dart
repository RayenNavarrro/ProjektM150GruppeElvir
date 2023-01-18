import 'package:flutter/material.dart';
import 'package:gibz_mobileapp/models/meal_information/meal_information.dart';

import 'content_box.dart';
import 'expandable_section.dart';

class MealBox extends StatefulWidget {
  final Meal meal;

  const MealBox({Key? key, required this.meal}) : super(key: key);

  @override
  _MealBoxState createState() => _MealBoxState();
}

class _MealBoxState extends State<MealBox> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ContentBox(
        // TODO: IntrinsicHeight seems to be an expensive widget. Replacement?
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            widget.meal.title,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 98, 160),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.meal.menuComponents.join("\n"),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (widget.meal.priceInternal > 0 ||
                      widget.meal.priceExternal > 0)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Text(
                            widget.meal.priceInternal.toStringAsFixed(2) +
                                " CHF\n" +
                                widget.meal.priceExternal.toStringAsFixed(2) +
                                " CHF",
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            ExpandableSection(
              expand: _isExpanded,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                  child: Column(
                    children: [
                      Table(
                        children: [
                          TableRow(children: [
                            Text(
                              'Nährwerte',
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Pro Portion',
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                          ...widget.meal.nutritionalValues.map(
                            (nutritionalValue) => TableRow(
                              children: [
                                Text(nutritionalValue.title),
                                Text(nutritionalValue.value),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Allergene',
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              widget.meal.allergenes.join(", "),
                            ),
                          ],
                        ),
                      ),
                      if (widget.meal.balance != null ||
                          widget.meal.environmentalImpact != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Table(
                            children: [
                              if (widget.meal.balance != null)
                                TableRow(
                                  children: [
                                    const Text(
                                      "Ausgewogenheit",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(widget.meal.balance!),
                                  ],
                                ),
                              if (widget.meal.environmentalImpact != null)
                                TableRow(
                                  children: [
                                    const Text(
                                      "Umweltbelastung",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(widget.meal.environmentalImpact!),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      if (widget.meal.icons.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...widget.meal.icons.map(
                                (icon) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 0,
                                  ),
                                  child: Image.network(
                                    icon.sourceUri,
                                    // width: 32,
                                    // height: 32,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                // color: Colors.grey.shade400,
                color: const Color.fromARGB(255, 0, 98, 160),
              ),
              onTap: _toggleExpand,
            ),
          ],
        ),
      ),
    );
  }
}

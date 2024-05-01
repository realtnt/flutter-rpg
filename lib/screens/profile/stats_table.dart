import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class StatsTable extends StatefulWidget {
  const StatsTable(this.character, {super.key});

  final Character character;

  @override
  State<StatsTable> createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    int points = widget.character.points;
    final Character character = widget.character;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // available points
          Container(
            color: AppColors.secondaryColor.withOpacity(0.3),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: turns,
                  child: Icon(
                    Icons.star,
                    color: points > 0 ? Colors.yellow : Colors.grey,
                  ),
                ),
                const SizedBox(width: 20),
                const StyledText('Stat points available:'),
                const Expanded(child: SizedBox(width: 20)),
                StyledHeading(points.toString()),
              ],
            ),
          ),

          // stats table
          Table(
            children: widget.character.statsAsFormattedList.map(
              (stat) {
                return TableRow(
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(0.5)),
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: StyledHeading(stat['title'] ?? '')),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: StyledHeading(stat['value'] ?? '')),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: IconButton(
                        icon: Icon(Icons.arrow_upward,
                            color: AppColors.textColor),
                        onPressed: () {
                          turns += 0.5;
                          setState(
                            () => character.increaseStat(stat['title']!),
                          );
                        },
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: IconButton(
                        icon: Icon(Icons.arrow_downward,
                            color: AppColors.textColor),
                        onPressed: () {
                          turns -= 0.5;
                          setState(
                            () => character.decreaseStat(stat['title']!),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

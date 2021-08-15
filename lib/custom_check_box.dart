import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'interface/check_box_def.dart';

class CustomCheckBox extends StatefulWidget {
  final CheckedBox onCkecked;
  final List<String> selectedTimeFrame = [];
  bool _isSelected;
  final List<String> titlesList;
  final String? checkSVG;
  final String? unCkeckdSVG;
  final double? boxSize;
  final Axis? direction;
  final TextStyle? titleTextSyle;
  CustomCheckBox(this.titlesList, this._isSelected, this.onCkecked,
      {Key? key,
      this.checkSVG,
      this.unCkeckdSVG,
      this.boxSize,
      this.titleTextSyle,
      this.direction})
      : super(key: key);
  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  void initState() {
    widget._isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: widget.direction ?? Axis.vertical,
      itemCount: widget.titlesList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (widget._isSelected) {
          return _checkBoxView(
            widget.titlesList[index],
          );
        } else {
          return _checkBoxView(
            widget.titlesList[index],
          );
        }
      },
    );
  }

  Widget _checkBoxView(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget._isSelected = !widget._isSelected;
          if (!show(title)) {
            widget.selectedTimeFrame.add(title);
          } else {
            widget.selectedTimeFrame.remove(title);
          }
          widget.onCkecked(widget.selectedTimeFrame);
        });
      },
      child: Row(
        children: [
          SvgPicture.asset(
            (show(title))
                ? widget.checkSVG ?? "assets/selected_box.svg"
                : widget.unCkeckdSVG ?? "assets/unselected_box.svg",
            width: widget.boxSize ?? 18,
            height: widget.boxSize ?? 18,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: widget.titleTextSyle ??
                TextStyle(fontSize: 16, color: Colors.grey.shade800),
          )
        ],
      ),
    );
  }

  bool show(String title) {
    bool isShow = false;
    if (widget.selectedTimeFrame.isNotEmpty) {
      for (var element in widget.selectedTimeFrame) {
        if (element == title) {
          isShow = true;
        }
      }
    }
    return isShow;
  }
}

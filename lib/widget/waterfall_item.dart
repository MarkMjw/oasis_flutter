import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oasis_flutter/model/status.dart';

class WaterfallItem extends StatefulWidget {
  Status status;

  WaterfallItem(this.status);

  @override
  State<StatefulWidget> createState() {
    return _WaterfallItemState();
  }
}

class _WaterfallItemState extends State<WaterfallItem> {
  _WaterfallItemState();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Color(0xff999999), blurRadius: 2, offset: Offset(0.5, 0.5))],
          borderRadius: BorderRadius.circular(4),
          color: Colors.white),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              child: Image.network(
                widget.status.cover,
                fit: BoxFit.cover,
              ),
              constraints: BoxConstraints.expand(),
            ),
            Container(
              constraints: BoxConstraints.expand(width: double.infinity, height: 30),
              color: Colors.black26,
              child: Center(
                child: Text(
                  widget.status.title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

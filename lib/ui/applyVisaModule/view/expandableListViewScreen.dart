import 'package:flutter/material.dart';
import 'package:visa_app/constants/appColor.dart';

class ExpandableListView extends StatefulWidget {
  final String? title;

  const ExpandableListView({Key? key, this.title}) : super(key: key);

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 1.0),
      child: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 5.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  expandFlag = !expandFlag;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    widget.title!,
                    style: new TextStyle(fontWeight: FontWeight.bold, color: colorBlack),
                  ),
                  new IconButton(
                      icon: new Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: new Center(
                          child: new Icon(
                            expandFlag ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: colorBlack,
                            size: 30.0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          expandFlag = !expandFlag;
                        });
                      }),
                ],
              ),
            ),
          ),
          new ExpandableContainer(
              expanded: expandFlag,
              child: new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    decoration:
                    new BoxDecoration(border: new Border.all(width: 1.0, color: Colors.grey), color: Colors.black),
                    child: new ListTile(
                      title: new Text(
                        "Cool $index",
                        style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      leading: new Icon(
                        Icons.local_pizza,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                itemCount: 2,
              ))
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 120.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return new AnimatedContainer(
      duration: new Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: new Container(
        child: child,
        decoration: new BoxDecoration(border: new Border.all(width: 1.0, color: colorBlack)),
      ),
    );
  }
}
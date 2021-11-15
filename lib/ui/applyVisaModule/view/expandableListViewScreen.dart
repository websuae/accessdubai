import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visa_app/constants/appColor.dart';

class ExpandableListView extends StatefulWidget {
  final String que;
  final String ans;

  const ExpandableListView({Key? key, required this.que,required this.ans}) : super(key: key);
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
          Container(
            child: InkWell(
              onTap: () {
                setState(() {
                  expandFlag = !expandFlag;
                });
              },
              child: Row(
                children: <Widget>[
                  new IconButton(
                      icon: new Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: new Center(
                          child: new Icon(
                            expandFlag
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: colorYellow,
                            size: 30.0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          expandFlag = !expandFlag;
                        });
                      }),
                  Flexible(
                    child: new Text(
                      widget.que,
                      style: new TextStyle(
                          fontWeight: FontWeight.normal, color: colorBlue),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: colorYellow,
            height: 1.h,
            width: MediaQuery.of(context).size.width,
          ),
          new ExpandableContainer(
            expanded: expandFlag,
            child: new ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(left: 25.w),
                      child: Text(
                        widget.ans,
                        style: new TextStyle(
                            fontWeight: FontWeight.normal, color: colorBlack),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 1,
            ),
          )
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
class xo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XO Game',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double RADIUS_CORNER = 12;



  var colorBorder = Colors.green[600];
  var colorBackground = Colors.green[100];
  var colorBackgroundChannelNone = Colors.green[200];
  var colorBackgroundChannelValueX = Colors.green[400];
  var colorBackgroundChannelValueO = Colors.green[400];
  var colorChannelIcon = Colors.green[800];
  var colorTextCurrentTurn = Colors.green[900];

  // State of Game
  List<List<int>> channelStatus = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
  ];

  //
  int currentTurn = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("X&O Game",style: TextStyle(color: Colors.black,fontSize: 30),)),
        ),
        body: Container(constraints: BoxConstraints.expand(),
            color: colorBackground,
            child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Turn of player",
                          style: TextStyle(
                              fontSize: 36, color: colorTextCurrentTurn,
                              fontWeight: FontWeight.bold)),
                      Icon(getIconFromStatus(currentTurn), size: 60, color: colorChannelIcon),
                      Container(
                          margin: EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                              color: colorBorder,
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: buildRowChannel(0)
                              ),
                              Row(mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: buildRowChannel(1)),
                              Row(mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: buildRowChannel(2))
                            ],
                          )
                      ),

                      Builder(
                        builder: (ctx) {
                          final GlobalKey<SlideActionState> key = GlobalKey();
                          return Padding(
                            key: key,
                            padding: const EdgeInsets.all(20.0),
                            child: SlideAction(
                              child: Text("Restart"),
                              height: 60,
                              borderRadius: 12,
                              alignment: Alignment.bottomCenter,
                              onSubmit: () {
                                playAgain();
                              }
                            ),
                          );
                        }
                      ),







                    ]
                )
            )
        )
    );
  }

  List<Widget> buildRowChannel(int row) {
    List<Widget> listWidget = [];
    for (int col = 0; col < 3; col++) {
      double tlRadius = row == 0 && col == 0 ? RADIUS_CORNER : 0;
      double trRadius = row == 0 && col == 2 ? RADIUS_CORNER : 0;
      double blRadius = row == 2 && col == 0 ? RADIUS_CORNER : 0;
      double brRadius = row == 2 && col == 2 ? RADIUS_CORNER : 0;
      Widget widget = buildChannel(
          row,
          col,
          tlRadius,
          trRadius,
          blRadius,
          brRadius,
          channelStatus[row][col]);
      listWidget.add(widget);
    }
    return listWidget;
  }

  Widget buildChannel(int row,
      int col,
      double tlRadius,
      double trRadius,
      double blRadius,
      double brRadius,
      int status) =>
      GestureDetector(onTap: () => onChannelPressed(row, col),
          child: Container(
              margin: EdgeInsets.all(2),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: getBackgroundChannelFromStatus(status),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(tlRadius),
                      topRight: Radius.circular(trRadius),
                      bottomLeft: Radius.circular(blRadius),
                      bottomRight: Radius.circular(brRadius)
                  )),
              child: Icon(getIconFromStatus(status), size: 60, color: colorChannelIcon)));

   getIconFromStatus(int status) {
    if (status == 1) {
      return Icons.close;
    } else if (status == 2) {
      return Icons.radio_button_unchecked;
    }
    return null;
  }

   getBackgroundChannelFromStatus(int status) {
    if (status == 1) {
      return colorBackgroundChannelValueX;
    } else if (status == 2) {
      return colorBackgroundChannelValueO;
    }
    return colorBackgroundChannelNone;
  }

  onChannelPressed(int row, int col) {
    if (channelStatus[row][col] == 0) {
      setState(() {
        channelStatus[row][col] = currentTurn;

        if (isGameEndedByWin()) {
          showEndGameDialog(currentTurn);
        } else {
          if(isGameEndedByDraw()){
            showEndGameByDrawDialog();
          }else {
            switchPlayer();
          }
        }
      });
    }
  }

  void switchPlayer() {
    setState(() {
      if (currentTurn == 1) {
        currentTurn = 2;
      } else if (currentTurn == 2) {
        currentTurn = 1;
      }
    });
  }

  bool isGameEndedByDraw() {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if(channelStatus[row][col] == 0){
          return false;
        }
      }
    }
    return true;
  }

  bool isGameEndedByWin() {
    // check vertical.
    for (int col = 0; col < 3; col++) {
      if (channelStatus[0][col] != 0 &&
          channelStatus[0][col] == channelStatus[1][col] &&
          channelStatus[1][col] == channelStatus[2][col]) {
        return true;
      }
    }

    // check horizontal.
    for (int row = 0; row < 3; row++) {
      if (channelStatus[row][0] != 0 &&
          channelStatus[row][0] == channelStatus[row][1] &&
          channelStatus[row][1] == channelStatus[row][2]) {
        return true;
      }
    }

    // check cross left to right.
    if (channelStatus[0][0] != 0 &&
        channelStatus[0][0] == channelStatus[1][1] &&
        channelStatus[1][1] == channelStatus[2][2]) {
      return true;
    }

    // check cross right to left.
    if (channelStatus[0][2] != 0 &&
        channelStatus[0][2] == channelStatus[1][1] &&
        channelStatus[1][1] == channelStatus[2][0]) {
      return true;
    }

    return false;
  }

  void showEndGameDialog(int winner) {
    // flutter defined function
    print("The winner is:$winner");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("The winner is", style: TextStyle(
                      fontSize: 32,
                      color: colorTextCurrentTurn,
                      fontWeight: FontWeight.bold)),
                  Icon(getIconFromStatus(currentTurn),
                      size: 60,
                      color: colorChannelIcon),
                  RaisedButton(padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    color: Colors.yellow[800],
                    child: Text("Play again",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      playAgain();
                      Navigator.of(context).pop();
                    },
                  )
                ])
        );
      },
    );
  }
  void showEndGameByDrawDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Draw", style: TextStyle(
                      fontSize: 32,
                      color: colorTextCurrentTurn,
                      fontWeight: FontWeight.bold)),
                  RaisedButton(padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    color: Colors.yellow[800],
                    child: Text("Play again",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      playAgain();
                      Navigator.of(context).pop();
                    },
                  )
                ])
        );
      },
    );
  }

  playAgain() {
    setState(() {
      currentTurn = 1;
      channelStatus = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0],
      ];
    });
  }
}
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signzy/core/messageMethods.dart';
import 'package:signzy/widgets/animatedOverlay.dart';
import 'package:vibration/vibration.dart';
import 'package:sms/sms.dart';

class DebitTabView extends StatefulWidget {
  @override
  _DebitTabViewState createState() => _DebitTabViewState();
}

class _DebitTabViewState extends State<DebitTabView> {
  List<MessageModel> messages = [];
  Methods methods = Methods();
  @override
  void initState() {
    super.initState();
    methods.getMessageData(1).then((List<MessageModel> res) {
      setState(() {
        messages = res;
      });
    });

    SmsReceiver receiver = new SmsReceiver();
    receiver.onSmsReceived.listen((SmsMessage sms) async {
      List<MessageModel> tempMsgs = new List<MessageModel>.from(messages);
      MessageModel msg = await methods.convertSmsToMessage(sms);
      tempMsgs.insert(0, msg);
      setState(() {
        messages = tempMsgs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      onRefresh: () async {
        List<MessageModel> res = await methods.getMessageData(1);
        setState(() {
          messages = res;
        });
      },
      child: messages.length > 0
          ? new ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, i) =>
        new Dismissible(
          key: new Key(messages[i].id.toString()),
          background: new Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20.0),
            color: Colors.red,
            child: new Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          secondaryBackground: new Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            color: Colors.red,
            child: new Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: new Column(
            children: <Widget>[
              new Divider(height: 10.0),
              new ListTile(
                leading: new CircleAvatar(
                  backgroundColor: Colors.yellowAccent,
                  child: new Text(
                    messages[i].name[0],
                    style: new TextStyle(color: Color(0xff303146)),
                  ),
                ),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      messages[i].name,
                      overflow: TextOverflow.ellipsis,
                      style:
                      new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      messages[i].time,
                      style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                subtitle: new Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Text(
                    messages[i].message,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator
                      .of(context)
                      .overlay
                      .insert(
                    new AnimatedOverlay(
                      title: new Text(
                        messages[i].name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      content: new SingleChildScrollView(
                        child: new Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              messages[i].message,
                              textAlign: TextAlign.left,
                              style:
                              new TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Copy"),
                          onPressed: () async {
                            await ClipboardManager
                                .copyToClipBoard(
                              messages[i].message,
                            );

                            bool canVibrate =
                            await Vibration.hasVibrator();

                            if (canVibrate) {
                              Vibration.vibrate(duration: 100);
                            }
                          },
                        ),
                      ],
                    )(),
                  );
                },
              ),
            ],
          ),
          onDismissed: (DismissDirection direction) {
            MethodChannel methodChannel = const MethodChannel(
              "channels.limitedeternity.com/main",
            );

            methodChannel.invokeMethod(
              "deleteSMS",
              <String, int>{"smsId": messages[i].id},
            );

            List<MessageModel> tempMsgs =
            new List<MessageModel>.from(messages);

            tempMsgs.removeAt(i);
            setState(() {
              messages = tempMsgs;
            });
          },
        ),
      )
          : new ListView.builder(
        itemCount: 1,
        itemBuilder: (context, i) =>
        new Column(
          children: <Widget>[
            new Divider(height: 10.0),
            new ListTile(
              title: new Align(
                alignment: Alignment.topCenter,
                child: new Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: new Text(
                    "No messages",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
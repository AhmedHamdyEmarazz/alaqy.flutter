import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MessageBubbles extends StatefulWidget {
  // final Key key;
  final String message;
  final String userName;
  final String userImage;
  final String storeImage;
  final String store_name;
  final bool isMe;
  final String type;
  final String to;
  final String me;
  final String listidflagtyping;
  final String docid;
  final String widid;

  const MessageBubbles(
      this.message,
      this.userName,
      this.userImage,
      this.storeImage,
      this.store_name,
      this.isMe,
      this.type,
      this.to,
      this.me,
      this.listidflagtyping,
      this.docid,
      this.widid,
      {super.key});

  @override
  State<MessageBubbles> createState() => _MessageBubblesState();
}

class _MessageBubblesState extends State<MessageBubbles> {
  final _transformationController = TransformationController();

  TapDownDetails? _doubleTapDetails;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  void sendpushnotification(String token, String body, String title) async {
    @pragma('vm:entry-point')
    Future<void> _onBackgroundMessage(RemoteMessage message) async {
      await Firebase.initializeApp(
          // options: DefaultFirebaseOptions.currentPlatform,
          );
      debugPrint('we have received a notification ${message.notification}');
    }

    @pragma('vm:entry-point')
    Future<void> _firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      // If you're going to use other Firebase services in the background, such as Firestore,
      // make sure you call `initializeApp` before using other Firebase services.
      await Firebase.initializeApp();
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        FirebaseMessaging.instance
            .getInitialMessage()
            .then((RemoteMessage? message) {
          if (message != null) {
            // Navigator.pushNamed(
            //   context, '/',
            //   //  arguments: MessageArguments(message, true)
            // );
          }
        });

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          final FlutterLocalNotificationsPlugin
              flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;

          if (notification != null && android != null) {
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                const NotificationDetails(
                  android: AndroidNotificationDetails(
                    playSound: true, enableLights: true,
                    importance: Importance.max,

                    priority: Priority.max,
                    'channel id',
                    'channel name',
                    //  widget.description,
                    // TODO add a proper drawable resource to android, for now using
                    //      one that already exists in example app.
                    icon: 'launch_background',
                  ),
                ));
          }
        });

        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          print('A new onMessageOpenedApp event was published!');
          // Navigator.pushNamed(
          //   context, '/',
          //   //  arguments: MessageArguments(message, true)
          // );
        });
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      });
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      print('User granted permission: ${settings.authorizationStatus}');
      messaging.subscribeToTopic('notify');
      print("Handling a background message: ${message.messageId}");
    }

    @pragma('vm:entry-point')
    Future<void> _onBackgroundMessagee(RemoteMessage message) async {
      debugPrint('we have received a notification ${message.messageId}');
    }

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'content-type': 'aplication/json',
          'Authorization':
              'key=AAAAYkVGhz8:APA91bE75B-XzSXGRP9xJ6M1Ljg7CavQe_No8g705E0XlPp1Q_QwCQ1T9o_9wjHChsWR5fpzQ1YlQ2l5D8STZGmJf9gcVuj4jRtf9lkWji79QmqOW_fwy6hg__twEGiBbooIidoVMaw-'
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'Flutter_Notification_Click',
            'status': 'done',
            'body': body,
            'title': title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            "android_channel_id": "Default channel",
          },
          "to": token,
        }),
      );
      print("herexxx push notification");
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final oppa = Provider.of<Auth>(context, listen: false).userId;
    final name =
        widget.type == 'business' ? widget.store_name : widget.userName;
    final image =
        widget.type == 'business' ? widget.storeImage : widget.userImage;
    final othername =
        widget.type == 'customer' ? widget.store_name : widget.userName;
    final otherimage =
        widget.type == 'customer' ? widget.storeImage : widget.userImage;

    return (widget.message == widget.to || widget.message == widget.me)
        ? widget.listidflagtyping != 'flag for typing'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    !widget.isMe
                        ? Text(
                            'seen by ${(othername).trim().replaceAll(RegExp(r'_'), ' ')}')
                        : Text(
                            'seen by ${(name).trim().replaceAll(RegExp(r'_'), ' ')}')
                  ])
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    !widget.isMe
                        ? Text(
                            ' ${(othername).trim().replaceAll(RegExp(r'_'), ' ')} is typing')
                        : Text(
                            ' ${(name).trim().replaceAll(RegExp(r'_'), ' ')} is typing')
                  ])
        : widget.message == 'loadingxbus??!!' ||
                widget.message == 'loadingxcus??!!'
            ? const Center(child: CircularProgressIndicator())
            : (widget.message.startsWith(
                        'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image')) &&
                    (widget.message.endsWith('permission'))
                ? SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Column(children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (ctx) => GestureDetector(
                                    onDoubleTapDown: _handleDoubleTapDown,
                                    onDoubleTap: _handleDoubleTap,
                                    onTap: () {
                                      Navigator.pop(context);
                                      //   Navigator.of(context).pop();
                                    },
                                    child: Center(
                                        child: InteractiveViewer(
                                            transformationController:
                                                _transformationController,
                                            child: Container(
                                                child: Image.network(
                                              widget.message,
                                              fit: BoxFit.contain,
                                            )))))));
                          },
                          child: Container(
                              height: 250,
                              width: double.infinity,
                              child: Image.network(
                                widget.message,
                                fit: BoxFit.fill,
                                opacity: AlwaysStoppedAnimation<double>(0.28),
                              ))),
                      ListTile(
                        tileColor: Color.fromARGB(26, 0, 0, 0),
                        trailing: TextButton.icon(
//style:ButtonStyle(alignment:Alignment.center),
                          onPressed: () async {
                            FirebaseFirestore.instance
                                .collection('chat')
                                .doc(widget.widid.toString())
                                .collection('chatx')
                                .doc(widget.docid.toString())
                                .update({'combo': 'xxx'});
                          },
                          icon: Icon(
                            size: 20,
                            Icons.close,
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                          label: Text(
                            ' حذف و إلغاء',
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                          ),
                        ),
                        leading: TextButton.icon(
//style:ButtonStyle(alignment:Alignment.center),
                          onPressed: () async {
                            final listdoc = await FirebaseFirestore.instance
                                .collection('listing')
                                .doc(widget.listidflagtyping.toString())
                                .get();
                            final userid2 = listdoc.data()!['userid2'];
                            final maindoc = await FirebaseFirestore.instance
                                .collection('chat')
                                .doc(widget.widid.toString())
                                .collection('chatx')
                                .doc(widget.docid.toString())
                                .get();
                            final customerid = maindoc.data()!['customerid'];
                            final businessid = maindoc.data()!['businessid'];
                            final text = maindoc.data()!['text'];
                            final store_name = maindoc.data()!['store_name'];
                            final basicstore_name =
                                maindoc.data()!['basicstore_name'];
                            final basicusername =
                                maindoc.data()!['basicusername'];
                            final stroeimage = maindoc.data()!['stroeimage'];
                            final userimage = maindoc.data()!['userimage'];
                            final username = maindoc.data()!['username'];
                            final to = maindoc.data()!['to'];
                            final combo = maindoc.data()!['combo'];
                            final textfix =
                                text.toString().split('permission').first;
                            final business = await FirebaseFirestore.instance
                                .collection('business_details')
                                .doc(businessid.toString())
                                .get();
                            final busid2 = business.data()!['second_uid'];
                            FirebaseFirestore.instance
                                .collection('chat')
                                .doc(widget.widid.toString())
                                .collection('chatx')
                                .doc(widget.docid.toString())
                                .update({
                              'text': textfix,
                              'createdAt': Timestamp.now(),
                            });
                            if (widget.type == 'business') {
                              final chatxx = await FirebaseFirestore.instance
                                  .collection('chat')
                                  .doc(widget.widid.toString())
                                  .collection('chatx')
                                  .doc('${basicusername}bus${basicstore_name}')
                                  .get();
                              chatxx.exists
                                  ? await FirebaseFirestore.instance
                                      .collection('chat')
                                      .doc(widget.widid.toString())
                                      .collection('chatx')
                                      .doc(
                                          '${basicusername}bus${basicstore_name}')
                                      .update({'combo': 'xxx'})
                                  : null;
                              final repto = listdoc.data()![
                                  'post_owner_reply_to_business${basicstore_name}'];
                              final busmess =
                                  listdoc.data()!['${basicstore_name}messages'];
                              final busmessseen = listdoc
                                  .data()!['${basicstore_name}messagesseen'];
                              final sent = listdoc.data()!['sent'];
                              final messages = listdoc.data()!['messages'];
                              FirebaseFirestore.instance
                                  .collection('listing')
                                  .doc(widget.widid.toString())
                                  .update({
                                'post_owner_seen_by_business${basicstore_name}':
                                    repto,
                                '${basicstore_name}messages': busmess + 1,
                                'sent': sent + 1,
                                'messages': messages + 1
                              });
                              await FirebaseFirestore.instance
                                  .collection('chat')
                                  .doc(widget.widid.toString())
                                  .collection('chatx')
                                  .doc(customerid + businessid)
                                  .collection('chatxx')
                                  .add({
                                'customerid': customerid,
                                'businessid': businessid,
                                'listid': widget.widid,
                                'createdAt': Timestamp.now(),
                                'to$customerid': true,
                                'to$businessid': false,
                                'text': textfix,
                                //  'target': customerid,
                                'store_name': store_name,
                                'basicstore_name': basicstore_name,
                                'basicusername': basicusername,
                                'stroeimage': stroeimage,
                                'userimage': userimage,
                                'username': username,
                                'to': userid2,
                                'combo': '${basicusername}${basicstore_name}'
                              });
                              await FirebaseFirestore.instance
                                  .collection('chat')
                                  .doc(widget.widid.toString())
                                  .collection('chatx')
                                  .doc(businessid + customerid)
                                  .set({
                                'lastsent': 'business',
                                'createdAt': Timestamp.now(),
                              });
                              final send = await FirebaseFirestore.instance
                                  .collection('customer_details')
                                  .doc(customerid)
                                  .collection('tokens')
                                  .get();
                              final tokenx =
                                  send.docs.first.data()['registrationTokens'];
                              await FirebaseFirestore.instance
                                  .collection('notify')
                                  .doc()
                                  .set({
                                'customerid': customerid,
                                'businessid': businessid,
                                'listid': widget.widid,
                                'createdAt': Timestamp.now(),
                                'to$customerid': true,
                                'to$businessid': false,
                                'text': 'new photo',
                                'target': customerid,
                                'store_name': store_name,
                                'tok': tokenx
                              });

                              print(tokenx);
                              print(",,,,,,,,<<<<>>>>>>>>>");

                              sendpushnotification(
                                  tokenx, 'new photo', store_name);
                              final cow = await FirebaseFirestore.instance
                                  .collection('chat')
                                  .doc(widget.widid.toString())
                                  .collection('chatx')
                                  .doc(
                                      '${basicusername}busloading${basicstore_name}')
                                  .get();
                              cow.exists
                                  ? FirebaseFirestore.instance
                                      .collection('chat')
                                      .doc(widget.widid.toString())
                                      .collection('chatx')
                                      .doc(
                                          '${basicusername}busloading${basicstore_name}')
                                      .update({'combo': 'xxxx'})
                                  : null;
                              print('business');
                            }

                            if (widget.type == 'customer') {
                              print('luck');
                              final chatxx = await FirebaseFirestore.instance
                                  .collection('chat')
                                  .doc(widget.widid.toString())
                                  .collection('chatx')
                                  .doc('${basicusername}${basicstore_name}')
                                  .get();
                              chatxx.exists
                                  ? await FirebaseFirestore.instance
                                      .collection('chat')
                                      .doc(widget.widid.toString())
                                      .collection('chatx')
                                      .doc('${basicusername}${basicstore_name}')
                                      .update({'combo': 'xxx'})
                                  : null;
                              final store_messagesIndicator =
                                  listdoc.data()![basicstore_name];
                              final store_messages =
                                  listdoc.data()!['${basicstore_name}messages'];
                              final store_messagesseen = listdoc
                                  .data()!['${basicstore_name}messagesseen'];
                              final cusid = listdoc.data()!['userid'];
                              final storeimage =
                                  listdoc.data()!['${basicstore_name}image'];
                              final userimage = listdoc.data()!['userimage'];
                              final messbaqy =
                                  store_messages - store_messagesseen;
                              final messages = listdoc.data()!['messages'];
                              final messages_seen =
                                  listdoc.data()!['messages_seen'];
                              final sent = listdoc.data()!['sent'];
                              final seen = listdoc.data()!['seen'];

                              final sentminseen = sent - seen;
                              await FirebaseFirestore.instance
                                  .collection('listing')
                                  .doc(widget.widid.toString())
                                  .update({
                                'seen':
                                    sentminseen == 0 ? seen : seen + messbaqy,
                                'messages_seen': messages_seen + messbaqy,
                                '${basicstore_name}messagesseen':
                                    store_messages,
                                'createdAt': Timestamp.now(),
                              });
                              if (store_messagesIndicator == 'off') {
                                await FirebaseFirestore.instance
                                    .collection('listing')
                                    .doc(widget.widid.toString())
                                    .update({
                                  store_name: 'on',
                                  'post_owner_reply_to_business${basicstore_name}':
                                      1,
                                  'post_owner_seen_by_business${basicstore_name}':
                                      0,
                                  'createdAt': Timestamp.now(),
                                });
                                await FirebaseFirestore.instance
                                    .collection('chat')
                                    .doc(widget.widid.toString())
                                    .set({
                                  'customerid': cusid,
                                  basicstore_name: store_name,
                                  'listid': widget.widid,
                                  'last shop link': Timestamp.now(),
                                });
                                await FirebaseFirestore.instance
                                    .collection('chat')
                                    .doc(widget.widid.toString())
                                    .collection('chatx')
                                    .doc('1')
                                    .set({
                                  'customerid': cusid,
                                  'businessid': businessid,
                                  'listid': widget.widid,
                                  'createdAt': Timestamp.now(),
                                  'to$cusid': false,
                                  'to${businessid}': true,
                                  'text': textfix,
                                  'to': busid2,
                                  'store_name': store_name,
                                  'basicstore_name': basicstore_name,
                                  'basicusername': basicusername,
                                  'stroeimage': storeimage,
                                  'userimage': userimage,
                                  'username': username,
                                  'combo': '${basicusername}${basicstore_name}'
                                });
                              }
                              if (store_messagesIndicator == 'on') {
                                final owner = await FirebaseFirestore.instance
                                    .collection('listing')
                                    .doc(widget.widid.toString())
                                    .get();
                                final owrep = owner.data()![
                                    'post_owner_reply_to_business${basicstore_name}'];
                                final owseen = owner.data()![
                                    'post_owner_seen_by_business${basicstore_name}'];
                                await FirebaseFirestore.instance
                                    .collection('listing')
                                    .doc(widget.widid.toString())
                                    .update({
                                  'post_owner_reply_to_business${basicstore_name}':
                                      owrep + 1,
                                  //     'post_owner_seen': 0,
                                });
                                await FirebaseFirestore.instance
                                    .collection('chat')
                                    .doc(widget.widid.toString())
                                    .collection('chatx')
                                    .doc(customerid + businessid)
                                    .collection('chatxx')
                                    .add({
                                  'customerid': cusid,
                                  'businessid': businessid,
                                  'listid': widget.widid,
                                  'createdAt': Timestamp.now(),
                                  'to$cusid': false,
                                  'to${businessid}': true,
                                  'text': textfix,
// 'businessid2':busid2,
// 'customerid2':userx,
                                  'to': busid2,
                                  //  'target': cusid,
                                  'store_name': store_name,
                                  'basicstore_name': basicstore_name,
                                  'basicusername': basicusername,
                                  'stroeimage': storeimage,
                                  'userimage': userimage,
                                  'username': username,
                                  'combo': '${basicusername}${basicstore_name}'
                                });
                              }
                              await FirebaseFirestore.instance
                                  .collection('chat')
                                  .doc(widget.widid.toString())
                                  .collection('chatx')
                                  .doc(businessid + customerid)
                                  .set({
                                'lastsent': 'customer',
                                'createdAt': Timestamp.now(),
                              });

                              await FirebaseFirestore.instance
                                  .collection('notify')
                                  .doc()
                                  .set({
                                'customerid': cusid,
                                'businessid': {businessid},
                                'listid': widget.widid,
                                'createdAt': Timestamp.now(),
                                'to$cusid': false,
                                'to${businessid}': true,
                                'text': 'new photo',
                                'target': businessid,
                                'store_name': username
                              });
                              final send = await FirebaseFirestore.instance
                                  .collection('customer_details')
                                  .doc(businessid)
                                  .collection('tokens')
                                  .get();
                              final tokenx =
                                  send.docs.first.data()['registrationTokens'];
                              print(tokenx);
                              print(",,,,,,,,<<<<>>>>>>>>>");

                              sendpushnotification(
                                  tokenx, 'new photo', username);
                              final business = await FirebaseFirestore.instance
                                  .collection('business_details')
                                  .doc(businessid.toString())
                                  .get();
                              final foundsent = business.data()!['foundsent'];
                              FirebaseFirestore.instance
                                  .collection('business_details')
                                  .doc(businessid.toString())
                                  .update({'foundsent': foundsent + 1});
                              final cow = await FirebaseFirestore.instance
                                  .collection('chat')
                                  .doc(widget.widid.toString())
                                  .collection('chatx')
                                  .doc(
                                      '${basicusername}loading${basicstore_name}')
                                  .get();
                              cow.exists
                                  ? FirebaseFirestore.instance
                                      .collection('chat')
                                      .doc(widget.widid.toString())
                                      .collection('chatx')
                                      .doc(
                                          '${basicusername}loading${basicstore_name}')
                                      .update({'combo': 'xxxx'})
                                  : null;
                              print('customer');
                            }
                          },
                          icon: Icon(
                            size: 20,
                            Icons.send,
                            color: Color.fromARGB(255, 255, 157, 0),
                          ),
                          label: Text(
                            ' تأكيد الإرسال',
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              color: Color.fromARGB(255, 255, 157, 0),
                            ),
                          ),
                        ),
                      ),
                    ]))
                : Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        mainAxisAlignment: !widget.isMe
                            //    oppa == 'xB1Q3KzEaIUNQGM4Fvf88MqUj1g2'
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: !widget.isMe
                                  //   oppa == 'xB1Q3KzEaIUNQGM4Fvf88MqUj1g2'
                                  ? Colors.grey[300]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(12),
                                topRight: const Radius.circular(12),
                                bottomLeft: widget.isMe
//                      oppa != 'xB1Q3KzEaIUNQGM4Fvf88MqUj1g2'
                                    ? const Radius.circular(0)
                                    : const Radius.circular(12),
                                bottomRight: !widget.isMe
                                    //         oppa == 'xB1Q3KzEaIUNQGM4Fvf88MqUj1g2'
                                    ? const Radius.circular(0)
                                    : const Radius.circular(12),
                              ),
                            ),
                            width: 140,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: !widget.isMe
                                  //   oppa == 'xB1Q3KzEaIUNQGM4Fvf88MqUj1g2'
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: <Widget>[
                                SelectableText(
                                  !widget.isMe
                                      ? (name)
                                          .trim()
                                          .replaceAll(RegExp(r'_'), ' ')
                                      : (othername)
                                          .trim()
                                          .replaceAll(RegExp(r'_'), ' '),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: !widget.isMe
                                        ? Colors.grey.shade700
                                        : Colors.blueGrey,
                                  ),
                                ),
                                (widget.message.startsWith(
                                            'https://firebasestorage.googleapis.com/v0/b/alaqy-64208.appspot.com/o/user_image')) &&
                                        (!widget.message.endsWith('permission'))
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (ctx) => GestureDetector(
                                                  onDoubleTapDown: _handleDoubleTapDown,
                                                  onDoubleTap: _handleDoubleTap,
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    //   Navigator.of(context).pop();
                                                  },
                                                  child: Center(
                                                      child: InteractiveViewer(
                                                          transformationController: _transformationController,
                                                          child: Container(
                                                              child: Image.network(
                                                            widget.message,
                                                            fit: BoxFit.contain,
                                                          )))))));
                                        },
                                        child: Container(
                                            height: 150,
                                            width: double.infinity,
                                            child: Image.network(
                                              widget.message,
                                              fit: BoxFit.fill,
                                            )))
                                    : (widget.message.startsWith(
                                            'https://www.google.com/maps/search/?api=1&query='))
                                        ? Center(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: widget.message,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  TextSpan(
                                                    text: widget.message,
                                                    style: const TextStyle(
                                                        color: Colors.blue),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            launch(
                                                                widget.message);
                                                          },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SelectableText(
                                            widget.message,
                                            style: TextStyle(
                                              color: !widget.isMe
                                                  //                        oppa == 'xB1Q3KzEaIUNQGM4Fvf88MqUj1g2'
                                                  ? Colors.black
                                                  : Colors.black54,
                                            ),
                                            textAlign: !widget.isMe
//                        oppa == 'xB1Q3KzEaIUNQGM4Fvf88MqUj1g2'
                                                ? TextAlign.end
                                                : TextAlign.start,
                                          ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        left: !widget.isMe
//              oppa == 'xB1Q3KzEaIUNQGM4Fvf88MqUj1g2'
                            ? null
                            : 120,
                        right: !widget.isMe
//              oppa == 'xB1Q3KzEaIUNQGM4Fvf88MqUj1g2'
                            ? 120
                            : null,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            !widget.isMe ? image : otherimage,
                          ),
                        ),
                      ),
                    ],
                  );
  }
}
//https://www.google.com/maps/search/?api=1&query=31.223968,29.948638
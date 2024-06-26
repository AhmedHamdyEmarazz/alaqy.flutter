/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import * as admin from 'firebase-admin';
import { App } from 'firebase-admin/app';
import { Messaging } from 'firebase-admin/lib/messaging/messaging';
import { TokenMessage } from 'firebase-admin/lib/messaging/messaging-api';
import * as functions from 'firebase-functions';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();
export type Message = TokenMessage ;
export declare function getMessaging(app?: App): Messaging;

export const sendToDevice2a = functions.firestore
  .document('notifyx/{message}')
  .onCreate(async snapshot => {


    const order = snapshot.data();

    const querySnapshot = await db
      .collection('customerx_details')
      .doc(order.target)
      .collection('tokens')
      .get();

    const tokens = querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: order.store_name,
        body: order.text,
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };

    return fcm.sendToDevice(tokens, payload);
  });
export const sendToDeviceya = functions.firestore
  .document('notifyx/{message}')
  .onCreate(async snapshot => {


    const order = snapshot.data();

    const querySnapshot = await db
      .collection('businessx_details')
      .doc(order.target)
      .collection('tokens')
      .get();

    const tokens = querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: order.store_name,
        body: order.text,
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };

    return fcm.sendToDevice(tokens, payload);
  });

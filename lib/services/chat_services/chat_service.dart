import 'package:chat_messenger/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
//   get auth and firestore instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//   send message
  Future<void> sendMessage(
      String receiverId, String receiverEmail, String message) async {
    //   get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      receiverEmail: receiverEmail,
      message: message,
      timestamp: timestamp,
    );

    //   construct a chat room if from current user and receiver id (to ensure the uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //   sort the ids(to ensure the uniqueness)
    String chatRoomId = ids.join('_'); //   combine the ids

    //   add new message to database
    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

// get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserid) {
    //   construct a chat room if from current user and receiver id (to ensure the uniqueness)
    List<String> ids = [userId, otherUserid];
    ids.sort(); //   sort the ids(to ensure the uniqueness)
    String chatRoomId = ids.join('_'); //   combine the ids

    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}

import 'package:chat_gpt_clone/models/user_model.dart';

// message_models.dart
enum MessageType { user, ai }

class Message {
 final String id;
 final String content;
 final DateTime timestamp;
 final MessageType type;
 final User sender;

 Message({
   required this.id,
   required this.content, 
   required this.timestamp,
   required this.type,
   required this.sender,
 });

 // Factory constructor to create a message
 factory Message.create({
   required String content,
   required MessageType type, 
   required User sender,
 }) {
   return Message(
     id: DateTime.now().toString(),
     content: content,
     timestamp: DateTime.now(),
     type: type,
     sender: sender,
   );
 }
}
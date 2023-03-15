// import 'package:ai_ecard/models/models/chat/chat_model.dart';
// import 'package:flutter/material.dart';
//
// class ChatView extends StatefulWidget {
//   List<ChatModel> chatModel;
//
//   ChatView({Key? key, required this.chatModel}) : super(key: key);
//
//   @override
//   State<ChatView> createState() => _ChatViewState();
// }
//
// class _ChatViewState extends State<ChatView> {
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//     });
//
//     return ListView.separated(
//       controller: _scrollController,
//       itemBuilder: (context, index) {
//         if (widget.chatModel[index].isSendMessage) {
//           return sendMessage(widget.chatModel[index].message);
//         } else {
//           return receiveMessage(widget.chatModel[index].message);
//         }
//       },
//       separatorBuilder: (BuildContext context, int index) {
//         return const SizedBox(height: 5);
//       },
//       itemCount: widget.chatModel.length,
//     );
//   }
//
//   Widget sendMessage(String message) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Container(),
//         ),
//         Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(10))),
//             constraints: BoxConstraints(
//               minWidth: 0,
//               maxWidth: MediaQuery.of(context).size.width * 0.75,
//             ),
//             child: Text(message)),
//       ],
//     );
//   }
//
//   Widget receiveMessage(String message) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//             padding: EdgeInsets.all(10),
//             decoration:
//                 BoxDecoration(color: Colors.deepPurpleAccent, borderRadius: BorderRadius.all(Radius.circular(10))),
//             constraints: BoxConstraints(
//               minWidth: 0,
//               maxWidth: MediaQuery.of(context).size.width * 0.75,
//             ),
//             child: Text(message)),
//         Expanded(child: Container())
//       ],
//     );
//   }
// }

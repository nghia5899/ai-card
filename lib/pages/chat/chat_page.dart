// import 'package:ai_ecard/pages/chat/chat_controller.dart';
// import 'package:ai_ecard/widgets/chat_view.dart';
// import 'package:ai_ecard/widgets/custom_app_button.dart';
// import 'package:ai_ecard/widgets/custom_text_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ChatPage extends GetView<ChatController> {
//   const ChatPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Stack(
//             children: [
//               ListView(
//                 children: [
//                   SizedBox(
//                     height: 50,
//                   ),
//                   SizedBox(
//                     height: 500,
//                     child: Obx(() => ChatView(chatModel: controller.chatModels.value)),
//                   ),
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextField(
//                     keyboardType: TextInputType.multiline,
//                     maxLines: 3,
//                     minLines: 1,
//                     onChanged: (value) {
//                       controller.updateText(value);
//                     },
//                   ),
//                   CustomTextButton(
//                     title: 'Test',
//                     onPressed: () async {
//                       controller.sendChat();
//                     },
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

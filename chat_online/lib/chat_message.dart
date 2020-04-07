import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final Map<String, dynamic> data;

  final bool myMsg;

  ChatMessage(this.data, this.myMsg);

  Widget buildAvatarPhoto () {
    return Padding(
      padding: myMsg ? EdgeInsets.only(left: 15) : EdgeInsets.only(right: 15),
      child: CircleAvatar(
        backgroundImage: NetworkImage(data["senderPhotoUrl"]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          myMsg ? Container() : buildAvatarPhoto(),
          Expanded(
            child: Column(
              crossAxisAlignment: myMsg ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    data["senderName"],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                ),
                  data["imgUrl"] != null ?
                      Image.network(data["imgUrl"], width: 200,)
                  :
                      Text(
                        data["text"],
                        textAlign: myMsg ? TextAlign.end : TextAlign.start,
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
              ],
            )
          ),
          myMsg ? buildAvatarPhoto() : Container(),
        ],
      ),
    );
  }
}

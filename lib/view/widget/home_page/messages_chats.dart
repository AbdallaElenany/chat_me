import 'package:chat_me/view/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/class/database_service.dart';

class RecentChats extends StatelessWidget {
  final String userimage;
  final String userid;
  const RecentChats({super.key, required this.userimage, required this.userid});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 2, left: 2),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: FutureBuilder(
            future: DatabaseService().getAllUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ChatScreen(
                              userreciver: "${snapshot.data?[index]['name']}",
                              reciverimg: "${snapshot.data?[index]['image']}",
                              reciverid: "${snapshot.data?[index]['id']}",
                              senderimg: userimage,
                              senderid: userid,
                            );
                          }));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 20.0, top: 10.0, bottom: 10.0),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFEFEE),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage: snapshot.data?[index]
                                                ['image'] ==
                                            "null" ||
                                        snapshot.data?[index]['image'] == null
                                    ? const AssetImage("assets/images/as.png")
                                    : NetworkImage(
                                            "${snapshot.data?[index]['image']}")
                                        as ImageProvider,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${snapshot.data?[index]['name']}",
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "${snapshot.data?[index]['email']}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}

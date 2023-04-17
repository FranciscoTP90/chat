import 'package:flutter/material.dart';

import 'components/contacts_chats_widget.dart';

class HomeScreenCopy extends StatefulWidget {
  const HomeScreenCopy({Key? key}) : super(key: key);

  @override
  State<HomeScreenCopy> createState() => _HomeScreenCopyState();
}

class _HomeScreenCopyState extends State<HomeScreenCopy> {
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text("Chatting Room"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                size: 28,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_outlined,
                size: 28,
              )),
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        // padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const ContactChatWidget(),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    margin: const EdgeInsets.only(bottom: 15.0),
                    height: 100,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 2.0,
                          left: 0.0,
                          child: Container(
                            height: 85,
                            width: size.width - 20,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                border:
                                    Border.all(width: 1.5, color: Colors.black),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24.0))),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 6,
                          right: 6,
                          child: Container(
                              height: 90,
                              // margin: const EdgeInsets.only(bottom: 10),
                              // width: 200,
                              width: size.width - 32,
                              // alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1.5, color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(22.0))),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircleAvatar(
                                        radius: 32,
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10.0),
                                        const Text(
                                          "Title A",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),

                                        Container(
                                          // color: Colors.red,
                                          margin: const EdgeInsets.only(
                                              right: 12.0, top: 5.0),
                                          child: const Text(
                                            "Mensje Ut reprehenderit laborum aliquip eiusmod pariatur elit culpa qui consectetur tempor occaecat laboris nostrud ad.",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                        // const SizedBox(width: 10.0)
                                        // Text(
                                        //   "Mensaje Nisi dolore id consequat sunt est ad tempor id eu id id do labore culpa. Ullamco anim nisi ullamco deserunt deserunt dolor. Dolor veniam consequat esse aliquip et esse eiusmod labore quis aute voluptate occaecat. Laboris exercitation sunt non quis esse reprehenderit. Quis id veniam Lorem veniam Lorem eiusmod dolor anim Lorem. Fugiat reprehenderit qui occaecat elit dolor dolor commodo Lorem aliquip minim id. Incididunt adipisicing consectetur ullamco cillum labore deserunt ut id magna.",
                                        //   maxLines: 2,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(height: 10.0),
                                      const Text("Fecha"),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.black),
                                            shape: BoxShape.circle),
                                        child: const Text(
                                          "1",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10.0)
                                ],
                              )
                              // child: const ListTile(
                              //   leading: CircleAvatar(),
                              //   title: Text("El nombre"),
                              //   subtitle: Text(
                              //     "El mensaje Cillum adipisicing magna minim aute Lorem amet consectetur enim sit amet velit ipsum fugiat laborum. Fugiat veniam labore velit incididunt excepteur ad. Enim consequat Lorem id in deserunt est laborum non. Lorem eu fugiat officia veniam irure ad quis incididunt. Incididunt pariatur esse enim et ex. Eiusmod aliqua ullamco mollit nostrud eiusmod. Velit voluptate ad enim laboris culpa non est consectetur commodo in incididunt aliquip consectetur ipsum.",
                              //     maxLines: 2,
                              //     overflow: TextOverflow.ellipsis,
                              //   ),
                              //   trailing: Text("La fecha"),
                              //   isThreeLine: true,
                              //   dense: true,
                              // ),
                              ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     selectedLabelStyle: const TextStyle(color: Colors.black),
      //     unselectedLabelStyle: const TextStyle(color: Colors.grey),
      //     currentIndex: currentPage,
      //     backgroundColor: Colors.pink,
      //     fixedColor: Colors.yellow,
      //     selectedItemColor: Colors.green,
      //     unselectedItemColor: Colors.grey,
      //     onTap: (value) {
      //       setState(() {
      //         currentPage = value;
      //       });
      //     },
      //     items: const [
      //       BottomNavigationBarItem(
      //           label: 'Message',
      //           backgroundColor: Colors.black,
      //           icon: Icon(Ionicons.chatbox_ellipses_outline)),
      //       BottomNavigationBarItem(
      //           backgroundColor: Colors.red,
      //           label: 'Feed',
      //           icon: Icon(Ionicons.chatbox_ellipses_outline)),
      //       BottomNavigationBarItem(
      //           backgroundColor: Colors.yellow,
      //           label: 'Add',
      //           icon: Icon(Ionicons.chatbox_ellipses_outline)),
      //       BottomNavigationBarItem(
      //           backgroundColor: Colors.purple,
      //           label: 'Call',
      //           icon: Icon(Ionicons.chatbox_ellipses_outline)),
      //     ])
    );
  }
}

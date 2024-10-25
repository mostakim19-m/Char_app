import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final String email;
  const MessageScreen({super.key, required this.email});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final Stream<QuerySnapshot> messageStream=FirebaseFirestore.instance
      .collection('Message')
      .orderBy('time')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: messageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasError){
            return Text('Something Wrong');
          }if(snapshot.connectionState==ConnectionState.waiting){
            return  Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot qds=snapshot.data!.docs[index];
            return Padding(padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10,),child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.purpleAccent
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)
                      )
                    ),
                    title: Text(qds['name'],style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                    subtitle: Text('Message',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black
                    ),softWrap: true,),
                  ),
                )
              ],
            ),);
          },);
        },);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getemployee extends StatefulWidget {
  const getemployee({Key? key}) : super(key: key);

  @override
  _getemployeeState createState() => _getemployeeState();
}

class _getemployeeState extends State<getemployee> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('faculity').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> message = snapshot.data!.docs;
                  return Column(children: [
                    Table(
                        border: TableBorder.all(),
                        children: message.map((e) {
                          return TableRow(children: [
                            Column(
                              children: [
                                Text(e['empname']),
                                Text(
                                  e['empsalary'].toString(),
                                ),
                              ],
                            )
                          ]);
                        }).toList()),
                  ]);
                } else {
                  return Text('error');
                }
              })
        ],
      ),
    );
  }
}

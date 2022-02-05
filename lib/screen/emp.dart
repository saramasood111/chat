import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getemp extends StatefulWidget {
  const getemp({Key? key}) : super(key: key);
  static const String id = 'emp_screen';

  @override
  _getempState createState() => _getempState();
}

class _getempState extends State<getemp> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('emp').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> list = snapshot.data!.docs;

                return Expanded(
                  child: Column(children: [
                    Table(
                        border: TableBorder.all(),
                        children: list.map((e) {
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
                  ]),
                );
              } else {
                return Text('error');
              }
            })
      ],
    ));
  }
}

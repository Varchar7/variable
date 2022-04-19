// getSoluions

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:variable/model/solution.dart';
import 'package:variable/search/users_builder.dart';
import 'package:variable/service/Firebase/user_service.dart';
import 'package:variable/widget/style.dart';

class SolutionBuilder extends StatelessWidget {
  final Stream<QuerySnapshot<Object?>> querySnapshot;
  const SolutionBuilder({
    Key? key,
    required this.querySnapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: querySnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong',
            style: style(),
            textAlign: TextAlign.center,
            textScaleFactor: 2,
          );
        } else {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.active) {
              List<Map<String, dynamic>> rawPosts = [];
              for (var element in (snapshot.data as QuerySnapshot).docs) {
                rawPosts.add(element.data() as Map<String, dynamic>);
              }
              List<Solution> solutions =
                  rawPosts.map((e) => Solution.fromJson(e)).toList();

              return UsersBuilder(
                querySnapshot: UsersServices.getOtherUsers(
                  solutions.map((e) => e.uid).toList(),
                ),
                builder: (users) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: solutions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          tileColor: Colors.transparent,
                          title: Text(
                            solutions[index].solution,
                            style: style(),
                          ),
                          trailing: Wrap(
                            children: [
                              Text(
                                getMessageTime(solutions[index].time.toDate()),
                                style: style(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ); /* Card(
                    child: ListTile(
                      tileColor: Colors.transparent,
                      title: Text(
                        solutions[index].solution,
                        style: style(),
                      ),
                      trailing: Wrap(
                        children: [
                          Text(
                            getMessageTime(solutions[index].time.toDate()),
                            style: style(),
                          ),
                        ],
                      ),
                    ),
                  ); */

            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
            );
          }
        }
      },
    );
  }

  String getMessageTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MMM-yyyy h:m');
    return formatter.format(dateTime);
  }
}

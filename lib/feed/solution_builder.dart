// getSoluions

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:variable/model/solution.dart';
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

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: solutions.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Text(
                      solutions[index].solution,
                      style: style(),
                    ),
                  );
                },
              );
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
}

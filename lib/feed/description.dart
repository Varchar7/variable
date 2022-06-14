import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variable/bloc/post/post_bloc.dart';
import 'package:variable/feed/text_field.dart';
import 'package:variable/model/solution.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/widget/snackbar.dart';

class Description extends StatefulWidget {
  final ScrollController scrollController;
  final String postID;
  const Description(
      {Key? key, required this.scrollController, required this.postID})
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  TextEditingController post = TextEditingController();
  bool _isHeaderShow = false;
  double letestOffest = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      onScroll();
    });
  }

  onScroll() {
    if (widget.scrollController.offset > letestOffest) {
      setState(() {
        _isHeaderShow = true;
      });
      letestOffest = widget.scrollController.offset;
    } else if (widget.scrollController.offset.isNegative ||
        widget.scrollController.offset == 0) {
      setState(() {
        _isHeaderShow = false;
      });
    } else {
      setState(() {
        _isHeaderShow = _isHeaderShow =
            letestOffest > widget.scrollController.offset ? false : true;
      });
      letestOffest = widget.scrollController.offset;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is SolutionPostedState) {
          setState(
            () {
              post.clear();
            },
          );
          popSnackbar(
            context: context,
            text: "Your answered submitted successfully",
          );
        }
      },
      child: AnimatedScale(
        alignment: Alignment.bottomCenter,
        duration: const Duration(milliseconds: 250),
        scale: _isHeaderShow ? 0 : 1,
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Review',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                        ),
                        textScaleFactor: 1.25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<PostBloc>(context).add(
                            SolutionPostEvent(
                              solution: Solution(
                                uid: FirebaseAuthenticationService.user.uid,
                                postID: widget.postID,
                                solution: post.text,
                                like: 0,
                                view: 1,
                                upvote: 0,
                                downgrade: 0,
                                time: Timestamp.now(),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.greenAccent,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Post',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                          ),
                          textScaleFactor: 1.25,
                        ),
                      ),
                    ],
                  ),
                  TextAreaField(
                    textEditingController: post,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

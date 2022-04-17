import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:variable/feed/text_field.dart';
import 'package:variable/model/post.dart';
import 'package:variable/service/Firebase/user_service.dart';
import 'package:variable/widget/style.dart';

class DescriptiveFeed extends StatefulWidget {
  final Post post;
  const DescriptiveFeed({Key? key, required this.post}) : super(key: key);

  @override
  State<DescriptiveFeed> createState() => _DescriptiveFeedState();
}

class _DescriptiveFeedState extends State<DescriptiveFeed> {
  ScrollController scrollController = ScrollController();

  bool _isHeaderShow = false;
  double letestOffest = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      onScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            controller: scrollController,
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Hero(
                        tag: widget.post.title,
                        child: Container(
                          color: widget.post.images.isEmpty
                              ? Colors.greenAccent
                              : null,
                          decoration: widget.post.images.isEmpty
                              ? null
                              : BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(widget.post.images,
                                        scale: 1),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -50,
                      child: Hero(
                        tag: widget.post.id,
                        child: const CircleAvatar(
                          radius: 75,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Chip(
                      avatar: Icon(Icons.arrow_upward),
                      label: Text(
                        '12',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                        ),
                        textScaleFactor: 1.25,
                      ),
                    ),
                    Chip(
                      avatar: Icon(Icons.arrow_downward),
                      label: Text(
                        '2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                        ),
                        textScaleFactor: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: UsersServices.getUser(widget.post.uid),
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
                        snapshot.data;
                        print((snapshot.data as Map<String,dynamic>));
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.red,
                              height: 100,
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
              ),
              const Text(
                'username',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                ),
                textScaleFactor: 2,
              ),
              ...List.generate(
                10,
                (index) => Container(
                  color: Colors.red,
                  height: 150,
                ),
              ),
            ],
          ),
          Description(
            value: _isHeaderShow,
          ),
        ],
      ),
    );
  }

  onScroll() {
    if (scrollController.offset > letestOffest) {
      setState(() {
        _isHeaderShow = true;
      });
      letestOffest = scrollController.offset;
    } else if (scrollController.offset.isNegative ||
        scrollController.offset == 0) {
      setState(() {
        _isHeaderShow = false;
      });
    } else {
      setState(() {
        _isHeaderShow = _isHeaderShow =
            letestOffest > scrollController.offset ? false : true;
      });
      letestOffest = scrollController.offset;
    }
  }
}

class Description extends StatelessWidget {
  final bool value;
  Description({Key? key, required this.value}) : super(key: key);
  TextEditingController post = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      alignment: Alignment.bottomCenter,
      duration: const Duration(milliseconds: 250),
      scale: value ? 0 : 1,
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
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
                      onPressed: () {},
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
    );
  }
}

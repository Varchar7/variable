import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variable/search/users_builder.dart';
import 'package:variable/service/Firebase/user_service.dart';
import 'package:variable/widget/textformfield.dart';

import '../bloc/profile/profile_bloc.dart';

class SearchUsers extends StatefulWidget {
  const SearchUsers({Key? key}) : super(key: key);

  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  TextEditingController search = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(
      GetUserProfileEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 75.0,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: 1,
                  ),
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () {},
                  color: Colors.green,
                  icon: const Icon(
                    Icons.notifications,
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  InputField(
                    title: "Search",
                    controller: search,
                    search: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                  UsersBuilder(
                    querySnapshot: UsersServices.getUsers(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

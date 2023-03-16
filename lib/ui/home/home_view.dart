import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../models/Post.dart';
import 'home_viewmodel.dart';
import '../widgets/smart/blogCard.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => model.isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : LiquidPullToRefresh(
              onRefresh: model.refresh,
              child: Scaffold(
                  floatingActionButton: FloatingActionButton(
                      onPressed: model.navigateToCreatePostScreen,
                      child: const Icon(Icons.create)),
                  appBar: AppBar(
                    actions: [
                      IconButton(
                          onPressed: model.logout,
                          icon: const Icon(Icons.logout_rounded)),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ListView.builder(
                        itemCount: model.allPosts.length,
                        itemBuilder: ((context, index) {
                          Post currentPost = model.allPosts[index];
                          return BlogCard(currentPost);
                        })),
                  )),
            ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

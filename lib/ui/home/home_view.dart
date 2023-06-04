import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../models/Post.dart';
import '../widgets/smart/drawer/drawer.dart';
import 'home_viewmodel.dart';
import '../widgets/smart/blogCard/blogCard.dart';
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
                  drawer: const DrawerWidget(),
                  floatingActionButton: FloatingActionButton(
                      onPressed: model.navigateToCreatePostScreen,
                      child: const Icon(Icons.create)),
                  appBar: AppBar(
                    title: const Text('Home'),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 16),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: model.allPosts.length,
                        itemBuilder: ((context, index) {
                          Post currentPost = model.allPosts[index];
                          if (model.likedList.contains(currentPost.id)) {
                            return BlogCard(
                              currentPost,
                              canLike: false,
                            );
                          } else {
                            return BlogCard(currentPost);
                          }
                        })),
                  )),
            ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

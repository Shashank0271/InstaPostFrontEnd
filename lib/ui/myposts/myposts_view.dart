import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../models/Post.dart';
import '../widgets/smart/blogCard/blogCard.dart';
import '../widgets/smart/drawer/drawer.dart';
import 'myposts_viewmodel.dart';

class MyPostsView extends StatelessWidget {
  const MyPostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyPostsViewModel>.reactive(
      builder: (context, model, child) => model.isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Scaffold(
                  drawer: const DrawerWidget(),
                  floatingActionButton: FloatingActionButton(
                      onPressed: () {}, child: const Icon(Icons.create)),
                  appBar: AppBar(
                    title: const Text('My posts'),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 16),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: model.myPostList.length,
                        itemBuilder: ((context, index) {
                          Post currentPost = model.myPostList[index];
                          return Stack(children: [
                            BlogCard(currentPost,canLike: false,),
                            Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    model.navigateToEditPostScreen(
                                        selectedPost: currentPost);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.deepOrange,
                                    child: Icon(Icons.edit),
                                  ),
                                )),
                          ]);
                        })),
                  )),
            ),
      viewModelBuilder: () => MyPostsViewModel(),
    );
  }
}

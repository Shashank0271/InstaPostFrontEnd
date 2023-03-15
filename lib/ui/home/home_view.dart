import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../models/Post.dart';
import 'home_viewmodel.dart';
import '../widgets/smart/blogCard.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => model.isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView.builder(
                    itemCount: model.allPosts.length,
                    itemBuilder: ((context, index) {
                      Post currentPost = model.allPosts[index];
                      return BlogCard(currentPost);
                    })),
              )),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

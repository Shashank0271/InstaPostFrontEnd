import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../models/Post.dart';
import 'home_viewmodel.dart';
import '../shared/ui_helper.dart';

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
              body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView.builder(
                  itemCount: model.allPosts.length,
                  itemBuilder: ((context, index) {
                    Post currentPost = model.allPosts[index];
                    return Material(
                      elevation: 14.0,
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        child: Column(children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                            height: screenHeightPercentage(context,
                                percentage: 0.2),
                            width: screenWidth(context),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(currentPost.imageUrl)),
                            ),
                          ),
                          verticalSpaceSmall,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(currentPost.title),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('writer ${currentPost.userFirebaseId}'),
                          ),
                        ]),
                      ),
                    );
                  })),
            )),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

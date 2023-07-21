import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medical_app/blocs/news/news_bloc.dart';
import 'package:medical_app/blocs/news/news_event.dart';
import 'package:medical_app/blocs/news/news_state.dart';
import 'package:medical_app/model/news_model.dart';
import 'package:medical_app/repositories/news_repositories.dart';
import 'package:medical_app/widgets/colors.dart';

import '../../utils/container_utils.dart';
import '../favorited/favourited_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 24, bottom: 12),
          child: BlocProvider(
            create: (context) => NewsBloc(
              NewRepositories(),
            )..add(FetchNewsEvent()),
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoadingState) {
                  return ContainerUtils.loadingStateContainer0;
                } else if (state is NewsErrorState) {
                  return Container(
                      margin: const EdgeInsets.all(24),
                      child: ContainerUtils.loadingErrorStateContainer);
                } else if (state is NewsLoadedState) {
                  List<NewsModel> newsList = state.newsList;
                  return newsBody(newsList);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView newsBody(List<NewsModel> newsList) {
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: newsList.length,
          itemBuilder: (context, index) => Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavouritedScreen(
                                favouritedNewsList: [newsList[index]]),
                          ),
                        );
                      },
                      icon: Icons.favorite_outline,
                      backgroundColor: Colors.green,
                    )
                  ],
                ),
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {},
                      icon: Icons.delete_outline,
                      backgroundColor: Colors.red,
                    )
                  ],
                ),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  color: AppColors.highLightColor,
                  margin: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        width: 160,
                        height: double.infinity,
                        child: Image.network(
                          newsList[index].hinhAnh.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newsList[index]
                                      .tieuDe
                                      .toString()
                                      .toUpperCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  newsList[index].gioiThieu.toString(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(.6),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}

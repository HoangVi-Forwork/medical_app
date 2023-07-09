import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/blocs/news/news_bloc.dart';
import 'package:medical_app/model/news_model.dart';
import 'package:medical_app/repositories/news_repositories.dart';
import 'package:medical_app/utils/container_utils.dart';

import '../../blocs/news/news_event.dart';
import '../../blocs/news/news_state.dart';
import '../../widgets/colors.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<bool> isSelected = [
    true,
    false
  ]; // Thay đổi giá trị mặc định của isSelected

  @override
  Widget build(BuildContext context) {
    final NewRepositories newsRepositories = NewRepositories();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocProvider(
        create: (context) => NewsBloc(newsRepositories)
          ..add(
            FetchNewsEvent(),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildToggleButtons(),
            _listNewBody(),
          ],
        ),
      ),
    );
  }

  // TOGGLE BUTTONS
  BlocBuilder<NewsBloc, NewsState> _buildToggleButtons() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return ToggleButtons(
          isSelected: isSelected,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
          },
          color: Colors.grey,
          selectedColor: AppColors.primaryColor,
          fillColor: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          children: [
            Container(
              width: 160,
              height: 44,
              color: isSelected[0]
                  ? AppColors.primaryColor
                  : Colors.grey, // Cập nhật màu sắc cho button "Tin mới"
              child: const Center(
                child: Text(
                  'Tin mới',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 160,
              height: 44,
              color: isSelected[1]
                  ? AppColors.primaryColor
                  : Colors.grey, // Cập nhật màu sắc cho button "Tin khác"
              child: const Center(
                child: Text(
                  'Tin khác',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // LIST NEWS
  Expanded _listNewBody() {
    return Expanded(
      flex: 1,
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return ContainerUtils.loadingStateContainer;
          } else if (state is NewsErrorState) {
            return ContainerUtils.loadingErrorStateContainer;
          } else if (state is NewsLoadedState) {
            List<NewsModel> listNews = state.newsList;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ListView.builder(
                itemCount: listNews.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 160,
                    color: AppColors.highLightColor,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: double.infinity,
                          margin: const EdgeInsets.only(right: 6),
                          color: Colors.grey,
                          child: Image.network(
                            '${listNews[index].hinhAnh}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  listNews[index]
                                      .tieuDe
                                      .toString()
                                      .toUpperCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    height: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Container(
                                  margin: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    listNews[index].gioiThieu.toString(),
                                    maxLines: 4,
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        height: 1.2,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

// File: search_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/utils/container_utils.dart';
import 'package:medical_app/widgets/colors.dart';

import '../../blocs/search/bloc/search_bloc.dart';
import '../../blocs/search/bloc/search_event.dart';
import '../../blocs/search/bloc/search_state.dart';
import '../../repositories/diseases_repositories.dart';
import '../home/home_detail_disease.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc _searchBloc;
  late TextEditingController _searchController;
  FocusNode searchInput = FocusNode();
  final _searchInputController = StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc(DiseaseRepository());
    _searchController = TextEditingController();

    // Thêm listener cho TextField
    _searchController.addListener(() {
      final searchText = _searchController.text;
      if (searchText.length >= 5) {
        _searchInputController.add(searchText);
      }
    });
    _searchInputController.stream.listen((searchText) {
      _performSearch();
    });
  }

  // void sharePressed() {
  //   String message = 'Gửi Tin này tới đâu?';
  //   Share.share(message);
  // }

  @override
  void dispose() {
    _searchBloc.close();
    _searchController.dispose();
    _searchInputController.close();
    super.dispose();
  }

  void _performSearch() {
    final tenBenh = _searchController.text;
    _searchBloc.add(PerformSearchEvent(tenBenh));
    // FocusScope.of(context).requestFocus(searchInput);
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: BlocBuilder<SearchBloc, SearchState>(
                  bloc: _searchBloc,
                  builder: (context, state) {
                    if (state is SearchLoadingState) {
                      return Center(
                        child: ContainerUtils.loadingStateContainer,
                      );
                    } else if (state is SearchEmptyResultState) {
                      return Center(
                        child: ContainerUtils.emptyDataLoadingState,
                      );
                    } else if (state is SearchLoadedState) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.searchResult.length,
                        itemBuilder: (context, index) {
                          final disease = state.searchResult[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.75,
                                ),
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeDetailDisease(
                                      diseases: disease,
                                    ),
                                  ),
                                );
                              },
                              title: Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  disease.tenBenh.toString().toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                disease.trieuChung ?? '',
                                maxLines: 3,
                                overflow: TextOverflow.clip,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  // _addToFavorites(disease.idBenh.toString());
                                  //sharePressed();
                                },
                                icon: const Icon(Icons.bookmarks_outlined),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is SearchErrorState) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: Text(state.errorMessage),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
            const SizedBox(
              height: 8,
            ),
            _buildSearchInput(),
          ],
        ),
      ),
    );
  }

  // SEARCH TEXTFORMFIELD AND SUBMIT INPUT BUTTON
  Column _buildSearchInput() {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          focusNode: searchInput,
          decoration: const InputDecoration(
            labelText: 'Nhập từ khóa',
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12),
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: _performSearch,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                AppColors.primaryColor,
              ),
            ),
            child: const Text('Tìm kiếm'),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:medical_app/blocs/favourites/bloc/favourites_bloc.dart';

class FavouritedScreen extends StatefulWidget {
  const FavouritedScreen({Key? key}) : super(key: key);

  @override
  State<FavouritedScreen> createState() => _FavouritedScreenState();

  void addItemToFavorites(String value) {}
}

class _FavouritedScreenState extends State<FavouritedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state.diseasesItems.isEmpty) {
            return const Center(
              child: Text('Danh sách trống'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Số cột trong lưới
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: state.diseasesItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: Image.network(
                            state.diseasesItems[index].hinhAnh.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        state.diseasesItems[index].tenBenh
                                            .toString(),
                                        // softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                    ),
                                    onPressed: () {
                                      final favBloc =
                                          BlocProvider.of<FavouritesBloc>(
                                              context);
                                      favBloc.add(RemoveFromFav(
                                          state.diseasesItems[index]));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

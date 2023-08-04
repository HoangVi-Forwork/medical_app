import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medical_app/widgets/colors.dart';
import '../../blocs/diseases/bloc/disease_bloc.dart';
import '../../model/diseases_model.dart';
import '../../repositories/diseases_repositories.dart';
import '../../utils/container_utils.dart';
import '../home/home_detail_disease.dart';

class DiseaseListScreen extends StatelessWidget {
  const DiseaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bệnh lý'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 24, bottom: 12),
          child: BlocProvider(
            create: (context) =>
                DiseaseBloc(DiseaseRepository())..add(FetchDiseasesEvent()),
            child: BlocBuilder<DiseaseBloc, DiseaseState>(
              builder: (context, state) {
                if (state is DiseaseLoadingState) {
                  return ContainerUtils.loadingStateContainer0;
                } else if (state is DiseaseErrorState) {
                  return Container(
                    margin: const EdgeInsets.all(24),
                    child: ContainerUtils.loadingErrorStateContainer,
                  );
                } else if (state is DiseaseLoadedState) {
                  return listDiseasesBody(state.diseasesList);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}

// LIST DISEASE BODY
SingleChildScrollView listDiseasesBody(List<DiseasesModel> listDisease) {
  return SingleChildScrollView(
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listDisease.length,
      itemBuilder: (context, index) {
        final disease = listDisease[index];

        return Container(
          height: 96,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 12.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 0.1),
              ),
            ],
          ),
          child: Slidable(
            startActionPane:
                ActionPane(motion: const StretchMotion(), children: [
              SlidableAction(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                onPressed: ((context) {}),
                icon: Icons.delete_outlined,
              ),
            ]),
            endActionPane: ActionPane(motion: const StretchMotion(), children: [
              SlidableAction(
                backgroundColor: const Color.fromARGB(255, 24, 163, 29),
                foregroundColor: Colors.white,
                onPressed: ((context) {}),
                icon: Icons.bookmark_add_outlined,
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomeDetailDisease(diseases: disease),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: Text('${disease.idBenh}'),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            '${disease.hinhAnh}',
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  disease.tenBenh.toString().toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  disease.trieuChung.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 12, right: 8),
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

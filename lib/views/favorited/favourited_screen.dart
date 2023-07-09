import 'package:flutter/material.dart';
import 'package:medical_app/model/department_model.dart';

import '../../repositories/department_repositories.dart';

class FavouritedScreen extends StatefulWidget {
  //final AppBar appBar;

  const FavouritedScreen({
    super.key,
  });

  @override
  State<FavouritedScreen> createState() => _FavouritedScreenState();
}

class _FavouritedScreenState extends State<FavouritedScreen> {
  final DepartmentRepository repository = DepartmentRepository();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      body: FutureBuilder(
        future: repository.getDepartment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else if (snapshot.hasData) {
            final List<DepartmentModel> departmentList = snapshot.data!;
            return ListView.builder(
                itemCount: departmentList.length,
                itemBuilder: (context, index) {
                  final DepartmentModel department = departmentList[index];
                  print("Data nè: " + department.toString());
                  return ListTile(
                    title: Text(department.tenKhoa ?? 'Hu'),
                    subtitle: Text(department.makhoa ?? 'Hu'),
                  );
                });
          } else {
            return const Center(
              child: Text('Something were wrong!'),
            );
          }
        },
      ),
    );
  }
}

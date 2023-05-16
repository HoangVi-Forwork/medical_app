import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/blocs/bloc/auth_bloc.dart';
import 'package:medical_app/views/auth/sign_in_screen.dart';
import 'package:medical_app/widgets/colors.dart';

class buildDrawer extends StatelessWidget {
  const buildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void _logout(context) {
      BlocProvider.of<AuthBloc>(context).add(
        SignOutRequested(),
      );
    }

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UnAuthenticated) {
          return const SignInScreen();
        }
        return Drawer(
          backgroundColor: AppColors.highLightColor,
          child: Column(
            children: [
              // TOP INFOMATIONS
              Container(
                width: double.infinity,
                height: 240,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 86),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 68,
                          height: 68,
                          // margin: const EdgeInsets.only(bottom: 0),
                          child: Image.network(
                            'https://i.pinimg.com/564x/ec/fd/c0/ecfdc07b30149c927956fe5bb6126e2c.jpg',
                          ),
                        ),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.only(bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Nguyen Hoang Vi",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Nguyen Hoang Vi",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // FUNC ICONS
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: const [
                            ListTile(
                              leading: Icon(Icons.book),
                              title: Text('My health check book '),
                            ),
                            ListTile(
                              leading: Icon(Icons.save),
                              title: Text('Favorites'),
                            ),
                            ListTile(
                              leading: Icon(Icons.shopping_bag),
                              title: Text('My Card'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 40,
                        thickness: 1,
                      ),
                      const ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Setting'),
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Log Out'),
                        onTap: () {
                          _logout(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

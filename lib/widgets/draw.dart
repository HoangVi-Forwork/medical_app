import 'package:flutter/material.dart';
import 'package:medical_app/widgets/colors.dart';

class buildDrawer extends StatelessWidget {
  const buildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                  ),
                  ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

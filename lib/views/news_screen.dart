import 'package:flutter/material.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widgets/draw.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final videoURL = 'https://youtu.be/xXH-vHY7Ifw';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: true,
          loop: false,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      drawer: const buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top News
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 0),
                  width: double.infinity,
                  height: 220,
                  color: Colors.grey,
                  child: Center(
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      onReady: () => debugPrint('Ready'),
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(
                          isExpanded: true,
                          colors: const ProgressBarColors(
                            playedColor: Colors.red,
                            handleColor: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                  child: Column(
                    children: [
                      const Text(
                        "Tình hình dịch bệnh đang dần chuyển biến phức tạp",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              '12:30 22.09.2023',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Báo Thanh Niên',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: const Divider(
                height: 1,
                color: Colors.black,
              ),
            ),
            // News
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: const Text(
                "Tin Mới: ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 46),
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  Color backgroundColor = (index % 2) != 0
                      ? Color.fromARGB(255, 204, 202, 202)
                      : Color.fromARGB(255, 163, 162, 162);
                  return Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 6,
                    ),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.favorite),
                      title: const Text('Health Information'),
                      subtitle: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam gravida euismod urna.',
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        // Hành động khi nhấp vào ListTile
                      },
                    ),
                  );
                },
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 26),
              child: const Center(
                child: Text('-- Hết --'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

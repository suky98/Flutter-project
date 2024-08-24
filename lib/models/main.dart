import 'package:flutter/material.dart';
import 'package:flutter_application/models/board_page.dart';
import 'package:flutter_application/models/account_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '게시판',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const BoardPage(),
    );
  }
}

class BoardItem {
  final String imageUrl;
  final String title;
  final String summary;

  BoardItem({required this.imageUrl, required this.title, required this.summary});
}

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  String? selectedChip;
  Set<String> selectedBoards = {'인기 게시판'};

  Future<List<BoardItem>> fetchBoardItems(String boardType) async {
    // boardType에 따라 데이터를 다르게 로드하도록 수정
    return List.generate(
      5,
          (index) => BoardItem(
        imageUrl: 'https://example.com/image$index.jpg',
        title: '$boardType 제목 ${index + 1}',
        summary: '$boardType 내용 요약 ${index + 1}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications, color: Colors.grey),
          onPressed: () {
            // 알림 버튼 클릭 시 처리
          },
        ),
        title: const Text('게시판', style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20
        )),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // 검색 버튼 클릭 시 처리
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(context),
          _buildPopularBoard(context, selectedChip: selectedChip),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      endDrawer: _buildDrawer(context),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      width: 500,  // Desired width
      height: 50,  // Desired height
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(right: 45), // Adjusted padding to avoid overlap
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...selectedBoards.map((board) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Transform.scale(
                            scale: 0.8,  // Adjust Chip scale
                            child: ChoiceChip(
                              label: Text(board),
                              selected: selectedChip == board,
                              backgroundColor: Colors.grey[300],
                              selectedColor: Colors.blue,
                              labelStyle: TextStyle(
                                color: selectedChip == board ? Colors.white : Colors.black,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.transparent, // Remove outline for unselected chips
                                ),
                              ),
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedChip = selected ? board : null;
                                });
                              },
                            ),
                          ),
                        )
                    ).toList(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.add, color: Colors.blue, size: 30),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer(); // Use the context from the Builder
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              '게시판 수정',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem('인기 게시판', FontAwesomeIcons.crown, Colors.yellow),
          _buildDrawerItem('최근 게시판', Icons.access_time, Colors.black),
          _buildDrawerItem('만남 게시판', Icons.favorite, Colors.pink),
          _buildDrawerItem('운동 게시판', Icons.directions_run, Colors.green),
          _buildDrawerItem('추억 게시판', Icons.bookmark, Colors.orange),
          _buildDrawerItem('음식 게시판', Icons.restaurant, Colors.grey)
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, Color color) {
    return CheckboxListTile(
      title: Text(title),
      secondary: Icon(icon, color: color),
      value: selectedBoards.contains(title),
      onChanged: (bool? value) {
        setState(() {
          if (value == true) {
            selectedBoards.add(title);
          } else {
            selectedBoards.remove(title);
          }
        });
      },
    );
  }

  Widget _buildPopularBoard(BuildContext context, {String? selectedChip, double height = 650}) {
    final boardType = selectedChip ?? '인기 게시판'; // 선택된 Chip에 따라 데이터 표시

    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  boardType,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8)
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<BoardItem>>(
              future: fetchBoardItems(boardType), // 선택된 Chip에 따라 데이터를 다르게 로드
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image, color: Colors.grey);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('TOP ${index + 1}',
                                      style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(item.title),
                                  Text(item.summary,
                                      style: const TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PopularPage()),
                  );
                },
                child: const Text(
                  '더 보기 >',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[700],
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '이야기책'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: '게시판'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '계정'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
      ],
      currentIndex: 1,
      onTap: (index) {
        if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyPage()),
          );
        }
      },
    );
  }
}


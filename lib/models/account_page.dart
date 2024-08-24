import 'package:flutter/material.dart';
import 'package:flutter_application/models/profile_change_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black),
          onPressed: () {
            // 알림 버튼 클릭 시 처리
          },
        ),
        title: const Text('계정', style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20
        )
        ),
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

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 50,
              child: Icon(Icons.person, color: Colors.white, size: 80),
            ),
            SizedBox(height: 15),
            Text(
              '김석희 님',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '010-4006-4**4',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 15),
            Text(
              '작년에 은퇴한 6학년 3반입니다. ^^ \n잘 부탁드리겠습니다!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to ProfileEditPage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileEditPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // 버튼의 배경색을 blue로 설정
              ),

              child: Text(
                '프로필 수정',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 30),

            Divider(color: Colors.grey[700]),

            ListTile(
              title: Text('로그아웃'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey[100],
                      title: Text('\n계정에서 로그아웃하시겠어요?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              child: Text(
                                '로그아웃',
                                style: TextStyle(fontSize: 12, color: Colors.red),
                              ),
                              onPressed: () {
                                // 로그아웃 로직 구현
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                '취소',
                                style: TextStyle(fontSize: 12, color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )

                      ],
                    );
                  },
                );
              },
            ),

            Divider(color: Colors.grey[700]),

            ListTile(
              title: Text('계정삭제'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey[100],
                      title: Text('\n계정을 완전히 삭제하시겠어요?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              child: Text(
                                '계정삭제',
                                style: TextStyle(fontSize: 12, color: Colors.red),
                              ),
                              onPressed: () {
                                // 계정삭제 로직 구현
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                '취소',
                                style: TextStyle(fontSize: 12, color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
            Divider(color: Colors.grey[700]),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: 3, // 현재 선택된 탭의 인덱스 (계정 탭)
        onTap: (index) {
          // 탭 클릭 시 처리
        },
      ),
    );
  }
}
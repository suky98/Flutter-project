import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PopularPage(),
    );
  }
}

class PopularPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text('인기 게시판', style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20
        )),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: ListView.builder(
        itemCount: 100, // Number of items
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 50,
              height: 50,
              color: Colors.grey[300],
              child: Icon(Icons.image, size: 30, color: Colors.grey[700]),
            ),
            title: Text('제목'),
            subtitle: Text('내용 요약'),
            trailing: Text('${(index + 1) * 2}분 전'),
          );
        },
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
        currentIndex: 1, // 현재 선택된 탭의 인덱스 (계정 탭)
        onTap: (index) {
          // 탭 클릭 시 처리
        },
      ),
    );
  }
}
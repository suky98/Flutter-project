import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  // Controllers for the TextFields
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final bio = _bioController.text;

    if (password.isEmpty || confirmPassword.isEmpty || bio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('내용을 입력하세요.')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
      );
      return;
    }

    // Here you would typically send the data to a server or save it locally

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('프로필이 저장되었습니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('프로필 수정', style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20
        )),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 30),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호 수정',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _bioController,
              maxLength: 100,
              decoration: InputDecoration(
                labelText: '자기소개 수정',
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
            ),
            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerRight, // 버튼을 오른쪽으로 정렬
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // 버튼의 배경색을 blue로 설정
                ),
                child: Text(
                  '저장',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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

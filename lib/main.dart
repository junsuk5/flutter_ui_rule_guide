import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '인스타그램 피드 예제',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FeedPage(),
    );
  }
}

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('피드'),
      ),
      body: ListView.builder(
        itemCount: feedItems.length,
        itemBuilder: (context, index) {
          return FeedItemCard(
            feedItem: feedItems[index],
            onTap: (FeedItem feedItem) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeedDetailPage(feedItem: feedItem)),
              );
            },
          );
        },
      ),
    );
  }
}

class FeedDetailPage extends StatelessWidget {
  final FeedItem feedItem;

  const FeedDetailPage({super.key, required this.feedItem});

  //

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
        title: Text(feedItem.username),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지
          Image.network(feedItem.imageUrl),
          // 설명
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              feedItem.description,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          // 좋아요 수
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('${feedItem.likes} Likes'),
          ),
        ],
      ),
    );
  }
}

class FeedItemCard extends StatelessWidget {
  final FeedItem feedItem;
  final void Function(FeedItem feedItem) onTap;

  const FeedItemCard({
    super.key,
    required this.feedItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(feedItem),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 정보
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(feedItem.userProfileImage),
              ),
              title: Text(feedItem.username),
              subtitle: Text(feedItem.timestamp),
            ),
            // 이미지
            Image.network(feedItem.imageUrl),
            // 좋아요 및 댓글 수
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${feedItem.likes} Likes'),
            ),
            // 설명
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(feedItem.description),
            ),
          ],
        ),
      ),
    );
  }
}

// 피드 항목 데이터 모델
class FeedItem {
  final String username;
  final String userProfileImage;
  final String imageUrl;
  final String description;
  final String timestamp;
  final int likes;

  FeedItem({
    required this.username,
    required this.userProfileImage,
    required this.imageUrl,
    required this.description,
    required this.timestamp,
    required this.likes,
  });
}

// 더미 데이터
final List<FeedItem> feedItems = [
  FeedItem(
    username: 'user1',
    userProfileImage: 'https://via.placeholder.com/150',
    imageUrl: 'https://via.placeholder.com/600x400',
    description: '첫 번째 게시물입니다!',
    timestamp: '1시간 전',
    likes: 120,
  ),
  FeedItem(
    username: 'user2',
    userProfileImage: 'https://via.placeholder.com/150',
    imageUrl: 'https://via.placeholder.com/600x400',
    description: '두 번째 게시물입니다!',
    timestamp: '2시간 전',
    likes: 80,
  ),
  // 추가 피드 항목을 여기에 추가할 수 있습니다.
];

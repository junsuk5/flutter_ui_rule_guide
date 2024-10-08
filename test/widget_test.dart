import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_rule/main.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('FeedItemCard displays correct information',
      (WidgetTester tester) async {
    // 테스트용 피드 아이템 생성
    final feedItem = FeedItem(
      username: 'test_user',
      userProfileImage: 'https://via.placeholder.com/150',
      imageUrl: 'https://via.placeholder.com/600x400',
      description: '테스트 게시물입니다!',
      timestamp: '1분 전',
      likes: 50,
    );

    // FeedItemCard 위젯을 테스트 환경에 추가
    await mockNetworkImagesFor(() => tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FeedItemCard(
                feedItem: feedItem,
                onTap: (FeedItem feedItem) {},
              ),
            ),
          ),
        ));

    // 사용자 이름이 올바르게 표시되는지 확인
    expect(find.text('test_user'), findsOneWidget);
    // 타임스탬프가 올바르게 표시되는지 확인
    expect(find.text('1분 전'), findsOneWidget);
    // 설명이 올바르게 표시되는지 확인
    expect(find.text('테스트 게시물입니다!'), findsOneWidget);
    // 좋아요 수가 올바르게 표시되는지 확인
    expect(find.text('50 Likes'), findsOneWidget);
    // 프로필 이미지가 올바르게 표시되는지 확인
    expect(find.byType(CircleAvatar), findsOneWidget);
    // 게시물 이미지가 올바르게 표시되는지 확인
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('FeedItemCard 가 탭이 잘 되는지', (WidgetTester tester) async {
    // 테스트용 피드 아이템 생성
    final feedItem = FeedItem(
      username: 'test_user',
      userProfileImage: 'https://via.placeholder.com/150',
      imageUrl: 'https://via.placeholder.com/600x400',
      description: '테스트 게시물입니다!',
      timestamp: '1분 전',
      likes: 50,
    );

    bool isTap = false;

    // FeedItemCard 위젯을 테스트 환경에 추가
    await mockNetworkImagesFor(() => tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FeedItemCard(
            feedItem: feedItem,
            onTap: (FeedItem feedItem) {
              isTap = true;
            },
          ),
        ),
      ),
    ));

    // FeedItemCard를 클릭
    await tester.tap(find.byType(FeedItemCard));
    await tester.pumpAndSettle(); // 애니메이션이 완료될 때까지 대기

    // 탭이 잘 되었는지 확인
    expect(isTap, isTrue);
  });
}

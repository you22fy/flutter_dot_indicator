import 'package:dot_indicator/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageViewWithDotIndicator(),
    );
  }
}

class PageViewWithDotIndicator extends HookWidget {
  const PageViewWithDotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    // サンプルページ
    final pages = [
      const SimplePage(
        title: '0ページ',
        contentText: '0ページ目のコンテンツです',
      ),
      const SimplePage(
        title: '1ページ',
        contentText: '1ページ目のコンテンツです',
      ),
      const SimplePage(
        title: '2ページ',
        contentText: '2ページ目のコンテンツです',
      ),
      const SimplePage(
        title: '3ページ',
        contentText: '3ページ目のコンテンツです',
      ),
      const SimplePage(
        title: '4ページ',
        contentText: '4ページ目のコンテンツです',
      ),
    ];

    final pageController = usePageController();

    // 現在のページ数を管理
    // round()で整数にすることで,ページの移動中にドットが消えるのを防ぐ
    final currentIndex = useState(
      (pageController.positions.isNotEmpty ? pageController.page : 0)!.round(),
    );

    // ページの移動を管理
    useEffect(
      () {
        void listener() {
          if (pageController.positions.isNotEmpty) {
            currentIndex.value = pageController.page!.round();
          }
        }

        pageController.addListener(listener);

        return () {
          pageController.removeListener(listener);
        };
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '現在のpageIndex : ${currentIndex.value.toString()}',
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: pages,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < pages.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(
                            currentIndex.value == i ? 1 : 0.1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



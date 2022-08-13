import 'package:flutter/material.dart';
import 'package:news_app/features/presentations/modules/web_view/web_view_screen.dart';

class ArticleItem extends StatelessWidget {
  final Map articleData;

  const ArticleItem({Key? key, required this.articleData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewScreen(url: articleData['url'])));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 140.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: articleData['urlToImage'] != null ? NetworkImage(articleData['urlToImage']):const NetworkImage(""),
                  onError: (context, stackTrace)
                    {
                      debugPrint("No image");
                    },
                  fit: BoxFit.cover,

                )
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                height: 110.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        "${articleData['title']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${articleData['publishedAt']}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

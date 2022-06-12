import 'dart:convert';

import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:hacker_news_scraper/hacker_news_scraper.dart'
    as hacker_news_scraper;
import 'package:http/http.dart';

void main() {
  late MockClient client;
  test('calling initiate(client) returns a list of titlelinks', () async {
    // arrange
    client = MockClient((request) => Future(() => Response(
          '''
      <body>
        <table><tbody><tr>
        <td class="title">
          <a class="titlelink" href="https://dartlang.org">Get started with Dart</a>
        </td>
        </tr></tbody></table>
      </body>
    ''',
          200,
        )));

    // act
    var response = await hacker_news_scraper.initiate(client);

    // assert
    expect(
        response,
        equals(json.encode(
          [
            {
              'title': 'Get started with Dart',
              'href': 'https://dartlang.org',
            },
          ],
        )));
  });

  test('calling initiate(client) should silently fail', () async {
    // Arrange
    client = MockClient((request) => Future(() => Response('Failed', 400)));

    // Act
    var response = await hacker_news_scraper.initiate(client);

    // Assert
    expect(response, equals('Failed'));
  });
}

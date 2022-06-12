import 'package:http/http.dart';
import 'package:hacker_news_scraper/hacker_news_scraper.dart'
    as hacker_news_scraper;

void main(List<String> arguments) async {
  var client = Client();
  print(await hacker_news_scraper.initiate(client));
}

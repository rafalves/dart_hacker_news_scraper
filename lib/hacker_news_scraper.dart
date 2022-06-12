import 'dart:convert';

import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

Future initiate(Client client) async {
  Response response = await client.get(
    Uri.parse('https://news.ycombinator.com/'),
  );

  var document = parse(response.body);
  List<Element> links = document.querySelectorAll('td.title > a.titlelink');

  List<Map<String, dynamic>> linkMap = [];
  for (var link in links) {
    linkMap.add(
      {
        'title': link.text,
        'href': link.attributes['href'],
      },
    );
  }

  if (response.statusCode != 200) return response.body;
  return json.encode(linkMap);
}

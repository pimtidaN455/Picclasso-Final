import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';

var suggestTag = ["Pizza", "Pasta", "Spagetti"];

class Searchpage extends StatelessWidget {
  final controller = Get.put(TagStateController());
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Search",
          style: TextStyle(
            fontSize: 30,
            color: MyStyle().whiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: textController,
              onEditingComplete: () {
                controller.listTagSearch.add(textController.text);
                textController.clear();
              },
              autofocus: false,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tag',
                prefixIcon: Icon(Icons.tag),
                suffixIcon: IconButton(
                  onPressed: () {
                    textController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
            suggestionsCallback: (String pattern) {
              return suggestTag.where(
                  (e) => e.toLowerCase().contains(pattern.toLowerCase()));
            },
            onSuggestionSelected: (String suggestion) =>
                controller.listTagSearch.add(suggestion),
            itemBuilder: (BuildContext context, Object? itemData) {
              return ListTile(
                leading: Icon(Icons.tag),
                title: Text(itemData.toString()),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Obx(() => controller.listTagSearch.length == 0
            ? Center(
                child: Text('No tag'),
              )
            : Wrap(
                children: controller.listTagSearch
                    .map((element) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            label: Text(element),
                            deleteIcon: Icon(Icons.clear),
                            onDeleted: () =>
                                controller.listTagSearch.remove(element),
                          ),
                        ))
                    .toList(),
              ))
      ]),
    ));
  }
}

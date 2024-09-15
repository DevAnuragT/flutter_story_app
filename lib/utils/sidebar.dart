import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capricon_story_app/controller/story_controller.dart';
import 'package:capricon_story_app/model/story_model.dart';

class StoryApp extends StatelessWidget {
  final StoryController storyController = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Story Generator")),
      body: Row(
        children: [
          // Sidebar with Story Titles
          Container(
            width: 250,
            color: Colors.grey[200],
            child: Obx(() {
              return ListView.builder(
                itemCount: storyController.stories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(storyController.stories[index].title),
                    onTap: () {
                      // Load selected story
                      storyController.selectedStoryIndex.value = index;
                    },
                  );
                },
              );
            }),
          ),

          // Main content: Generated Story
          Expanded(
            child: Obx(() {
              if (storyController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (storyController.stories.isEmpty ||
                  storyController.selectedStoryIndex.value == -1) {
                return Center(child: Text("Enter a prompt to generate a story"));
              }

              var selectedStory = storyController
                  .stories[storyController.selectedStoryIndex.value];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedStory.generatedStory,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Narrate the selected story using Flutter TTS
                        storyController.narrateStory(selectedStory.formattedStory);
                      },
                      child: Text("Narrate Story"),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Prompt input dialog to generate a new story
          showDialog(
            context: context,
            builder: (context) {
              final TextEditingController promptController = TextEditingController();

              return AlertDialog(
                title: Text("Enter a prompt"),
                content: TextField(
                  controller: promptController,
                  decoration: InputDecoration(hintText: "Enter your story prompt"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      String prompt = promptController.text.trim();
                      if (prompt.isNotEmpty) {
                        storyController.generateStory(prompt);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Generate"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

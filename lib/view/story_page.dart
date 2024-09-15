import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capricon_story_app/controller/story_controller.dart';

class StoryPage extends StatelessWidget {
  final StoryController _storyController = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Story Generator"),
      ),
      drawer: Drawer(
        child: Obx(() {
          return ListView(
            children: [
              // Topmost item: Create New Story
              ListTile(
                title: Text('Create New Story', style: TextStyle(fontWeight: FontWeight.bold)),
                leading: Icon(Icons.add),
                onTap: () {
                  _storyController.selectedStoryIndex.value = -1; // Reset selected story
                  Navigator.of(context).pop(); // Close the drawer
                },
              ),
              Divider(), // Divider to separate 'Create New Story' from the stories list

              // Display list of stories
              ListView.builder(
                shrinkWrap: true, // Wrap content size
                physics: NeverScrollableScrollPhysics(), // Disable scrolling in nested list
                itemCount: _storyController.stories.length,
                itemBuilder: (context, index) {
                  var story = _storyController.stories[index];
                  return ListTile(
                    title: Text(story.title),
                    onTap: () {
                      _storyController.selectedStoryIndex.value = index;
                      Navigator.of(context).pop(); // Close the drawer
                    },
                  );
                },
              ),
            ],
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                if (_storyController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                // Check if a story is selected or the user is creating a new story
                if (_storyController.selectedStoryIndex.value == -1 || _storyController.stories.isEmpty) {
                  return Center(
                    child: Text('No story selected. Create a new one by entering a prompt.'),
                  );
                }

                // Display the selected story
                var selectedStory = _storyController.stories[_storyController.selectedStoryIndex.value];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedStory.title,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        selectedStory.generatedStory,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _storyController.narrateStory(selectedStory.formattedStory);
                        },
                        child: Text('Narrate Story'),
                      ),
                    ],
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Obx(() {
                // Show prompt input field when no story is selected or creating a new story
                if (_storyController.selectedStoryIndex.value == -1) {
                  return TextField(
                    controller: _storyController.promptController,
                    decoration: InputDecoration(
                      hintText: 'Enter a prompt for a new story...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.create),
                        onPressed: () {
                          _storyController.generateStory(
                            _storyController.promptController.text,
                          );
                        },
                      ),
                    ),
                  );
                }
                return SizedBox(); // Empty widget if a story is selected
              }),
            ),
          ],
        ),
      ),
    );
  }
}

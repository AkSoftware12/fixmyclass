import 'package:flutter/material.dart';

class Course {
  final String title;
  final String description;
  final String imageUrl;

  Course({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class CoursesScreen extends StatelessWidget {
  CoursesScreen({super.key});

  final List<Course> courses = [
    Course(
      title: "Mathematics",
      description: "Algebra, Geometry, Calculus & more",
      imageUrl: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    ),
    Course(
      title: "Physics",
      description: "Mechanics, Thermodynamics, Optics",
      imageUrl: "https://cdn-icons-png.flaticon.com/512/1995/1995521.png",
    ),
    Course(
      title: "Chemistry",
      description: "Organic, Inorganic & Physical Chemistry",
      imageUrl: "https://cdn-icons-png.flaticon.com/512/1995/1995552.png",
    ),
    Course(
      title: "Biology",
      description: "Botany, Zoology & Human Biology",
      imageUrl: "https://cdn-icons-png.flaticon.com/512/3135/3135719.png",
    ),
    Course(
      title: "English",
      description: "Grammar, Comprehension & Writing Skills",
      imageUrl: "https://cdn-icons-png.flaticon.com/512/337/337946.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Courses"),
      //   backgroundColor: Colors.deepPurple,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Image.network(
                  course.imageUrl,
                  width: 60,
                  height: 60,
                ),
                title: Text(
                  course.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(course.description),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to course details
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You clicked ${course.title}')),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}



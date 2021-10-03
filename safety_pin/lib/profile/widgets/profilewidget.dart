import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    required this.isEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.pink;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(bottom: 0, right: 10, child: buildEditIcon(color)),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 150,
          height: 150,
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: color,
        all: 8,
        child: Icon(
          isEdit ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      );
  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

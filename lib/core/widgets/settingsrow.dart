import 'package:quick_cars_service/barrel.dart';

// ignore: must_be_immutable
class Settingsraw extends StatelessWidget {
  Settingsraw({
    super.key,
    required this.title,
    required this.function,
    this.icon,
    this.color,
  });
  String title;
  VoidCallback function;
  IconData? icon;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title),
            const Spacer(),
            IconButton(
              onPressed: function,
              color: color,
              icon: icon != null
                  ? Icon(icon)
                  : const Icon(Icons.arrow_forward_ios_outlined),
            ),
          ],
        ),
        // const SizedBox(
        //   height: 5,
        // ),
        const Divider(color: Colors.black),
      ],
    );
  }
}

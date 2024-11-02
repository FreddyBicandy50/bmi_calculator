import 'package:bmi/main.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({super.key, required this.icon, required this.onPressed});
  final Icon icon;
  final VoidCallback onPressed;
  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key, required this.getColor, required this.getWidgets});
  final int getColor;
  final List<Widget> getWidgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(getColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: getWidgets,
          ),
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  const SquareButton(
      {super.key, required this.getColor, required this.getButton});
  final int getColor;
  final ElevatedButton getButton;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(getColor),
      shape: const CircleBorder(),
      elevation: 8.0,
      child: getButton,
    );
  }
}

class GenderCard extends StatelessWidget {
  const GenderCard(
      {super.key,
      required this.gender,
      required this.genderName,
      required this.genderIcon});
  final bool gender;
  final String genderName;
  final IconData genderIcon;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      getColor: isPressed,
      getWidgets: [
        Icon(genderIcon,
            size: 110,
            color: gender ? Colors.white : const Color(textPrimaryColor)),
        Text(genderName,
            style: TextStyle(
                fontSize: 18.0,
                color: gender ? Colors.white : const Color(textPrimaryColor)))
      ],
    );
  }
}

class _RoundedButtonState extends State<RoundedButton> {
  int color = 0xFF5d5f6e;
  void buttonColorState() {
    setState(() => color = 0xFF7b7d8a);
    widget.onPressed(); // Call the callback function
    // Reset to original color after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => color = 0xFF5d5f6e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SquareButton(
      getColor: color,
      getButton: ElevatedButton(
        onPressed: buttonColorState,
        style: ElevatedButton.styleFrom(
          overlayColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: widget.icon,
      ),
    );
  }
}

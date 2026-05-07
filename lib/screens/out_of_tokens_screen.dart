class OutOfTokensScreen extends StatelessWidget {
  const OutOfTokensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min, // Takes up only needed space
      children: [
        LinearProgressIndicator(
          backgroundColor: Colors.transparent,
          color: Colors.blueAccent, // Use a corporate/institutional color
          minHeight: 3,
        ),
      ],
    );
  }
}

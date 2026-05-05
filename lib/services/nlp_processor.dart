class _HologramScreenState extends State<HologramScreen> {
  String currentInput = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // The Input Field
        TextField(
          onChanged: (text) {
            setState(() {
              currentInput = text; // Instantly updates the hologram
            });
          },
          decoration: const InputDecoration(labelText: "Ask for a hologram..."),
        ),
        
        // The Hologram that reacts to the input
        Expanded(
          child: AdaptiveHologram(userQuery: currentInput),
        ),
      ],
    );
  }
}

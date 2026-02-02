import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/* ================= COLOR PALETTE ================= */
const Color redAccent = Color(0xFFE53935);
const Color purpleAccent = Color(0xFF7E57C2);
const Color blueAccent = Color(0xFF42A5F5);
const Color darkText = Color(0xFF1F1F1F);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingSteps(),
    );
  }
}

/* ================= ONBOARDING ================= */
class OnboardingSteps extends StatefulWidget {
  const OnboardingSteps({super.key});

  @override
  State<OnboardingSteps> createState() => _OnboardingStepsState();
}

class _OnboardingStepsState extends State<OnboardingSteps> {
  final PageController _controller = PageController();
  int step = 0;

  void next() {
    if (step < 5) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFCE4EC), // light pink
              Color(0xFFE3F2FD), // light blue
              Color(0xFFEDE7F6), // light purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (i) => setState(() => step = i),
            children: [
              stepPage(
                "Select your gender",
                [
                  SelectOption(text: "Male", onTap: next),
                  SelectOption(text: "Female", onTap: next),
                  SelectOption(text: "Other", onTap: next),
                ],
              ),
              stepPage(
                "Your goal",
                [
                  SelectOption(text: "Lose weight", onTap: next),
                  SelectOption(text: "Maintain weight", onTap: next),
                  SelectOption(text: "Gain weight", onTap: next),
                ],
              ),
              stepPage(
                "Activity level",
                [
                  SelectOption(text: "Sedentary", onTap: next),
                  SelectOption(text: "Moderately active", onTap: next),
                  SelectOption(text: "Very active", onTap: next),
                ],
              ),
              stepPage(
                "Diet preference",
                [
                  SelectOption(text: "Vegetarian", onTap: next),
                  SelectOption(text: "Non-Vegetarian", onTap: next),
                  SelectOption(text: "Vegan", onTap: next),
                ],
              ),
              stepPage(
                "Any allergies?",
                [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "e.g. peanuts, dairy",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
              finalPage(),
            ],
          ),
        ),
      ),
    );
  }

  /* ================= STEP PAGE ================= */
  Widget stepPage(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Progress
          LinearProgressIndicator(
            value: (step + 1) / 6,
            minHeight: 8,
            backgroundColor: Colors.black12,
            color: redAccent,
            borderRadius: BorderRadius.circular(10),
          ),

          const SizedBox(height: 30),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: next,
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ================= FINAL PAGE ================= */
  Widget finalPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite, size: 80, color: redAccent),
            SizedBox(height: 20),
            Text(
              "Your personalized plan is ready!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "We’ll use your inputs to build a plan just for you.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

/* ================= SELECT OPTION ================= */
class SelectOption extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const SelectOption({super.key, required this.text, required this.onTap});

  @override
  State<SelectOption> createState() => _SelectOptionState();
}

class _SelectOptionState extends State<SelectOption> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => selected = true);
        Future.delayed(const Duration(milliseconds: 180), widget.onTap);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 18),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: selected ? redAccent.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: selected ? redAccent : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: selected ? redAccent : Colors.black87,
          ),
        ),
      ),
    );
  }
}

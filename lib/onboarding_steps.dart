import 'package:flutter/material.dart';

class OnboardingSteps extends StatefulWidget {
  const OnboardingSteps({super.key});

  @override
  State<OnboardingSteps> createState() => _OnboardingStepsState();
}

class _OnboardingStepsState extends State<OnboardingSteps> {
  final PageController _controller = PageController();
  int currentStep = 0;

  // Store user answers
  String gender = "";
  DateTime? birthday;
  double height = 170;
  double weight = 65;
  String goal = "";
  double targetWeight = 60;
  String speed = "";
  String activity = "";
  String diet = "";
  String allergies = "";
  String budget = "";
  String cookingLevel = "";

  void next() {
    if (currentStep < 11) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step ${currentStep + 1} of 12"),
      ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (i) => setState(() => currentStep = i),
        children: [

          /// 1. Gender
          StepPage(
            title: "Select your gender",
            child: Column(
              children: [
                choice("Male", () => gender = "Male"),
                choice("Female", () => gender = "Female"),
                choice("Other", () => gender = "Other"),
              ],
            ),
            onNext: next,
          ),

          /// 2. Birthday
          StepPage(
            title: "Your birthday",
            child: ElevatedButton(
              onPressed: () async {
                birthday = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                  initialDate: DateTime(2000),
                );
              },
              child: const Text("Pick Date"),
            ),
            onNext: next,
          ),

          /// 3. Height & Weight
          StepPage(
            title: "Height & Weight",
            child: Column(
              children: [
                slider("Height (cm)", height, 140, 210,
                    (v) => setState(() => height = v)),
                slider("Weight (kg)", weight, 40, 150,
                    (v) => setState(() => weight = v)),
              ],
            ),
            onNext: next,
          ),

          /// 4. Goal
          StepPage(
            title: "Your goal",
            child: Column(
              children: [
                choice("Lose Weight", () => goal = "Lose"),
                choice("Maintain", () => goal = "Maintain"),
                choice("Gain Weight", () => goal = "Gain"),
              ],
            ),
            onNext: next,
          ),

          /// 5. Target weight
          StepPage(
            title: "Target weight",
            child: slider(
              "Target (kg)",
              targetWeight,
              40,
              120,
              (v) => setState(() => targetWeight = v),
            ),
            onNext: next,
          ),

          /// 6. Speed
          StepPage(
            title: "How fast?",
            child: Column(
              children: [
                choice("Slow & steady", () => speed = "Slow"),
                choice("Moderate", () => speed = "Moderate"),
                choice("Aggressive", () => speed = "Fast"),
              ],
            ),
            onNext: next,
          ),

          /// 7. Activity
          StepPage(
            title: "Activity level",
            child: Column(
              children: [
                choice("Sedentary", () => activity = "Low"),
                choice("Moderate", () => activity = "Medium"),
                choice("Very Active", () => activity = "High"),
              ],
            ),
            onNext: next,
          ),

          /// 8. Diet
          StepPage(
            title: "Diet preference",
            child: Column(
              children: [
                choice("Vegetarian", () => diet = "Veg"),
                choice("Non-Vegetarian", () => diet = "Non-Veg"),
                choice("Vegan", () => diet = "Vegan"),
              ],
            ),
            onNext: next,
          ),

          /// 9. Allergies
          StepPage(
            title: "Allergies / Dislikes",
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Eg. peanuts, dairy",
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => allergies = v,
            ),
            onNext: next,
          ),

          /// 10. Budget
          StepPage(
            title: "Food budget",
            child: Column(
              children: [
                choice("Low", () => budget = "Low"),
                choice("Medium", () => budget = "Medium"),
                choice("High", () => budget = "High"),
              ],
            ),
            onNext: next,
          ),

          /// 11. Cooking level
          StepPage(
            title: "Cooking skill",
            child: Column(
              children: [
                choice("Beginner", () => cookingLevel = "Beginner"),
                choice("Intermediate", () => cookingLevel = "Intermediate"),
                choice("Advanced", () => cookingLevel = "Advanced"),
              ],
            ),
            onNext: next,
          ),

          /// 12. Final
          StepPage(
            title: "Your personalized plan is ready 🎉",
            child: const Text(
              "Based on your inputs, we’ll generate a custom meal plan.",
              textAlign: TextAlign.center,
            ),
            onNext: () {},
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget choice(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            onTap();
            next();
          },
          child: Text(text),
        ),
      ),
    );
  }

  Widget slider(
      String label, double value, double min, double max, Function(double) onChanged) {
    return Column(
      children: [
        Text("$label: ${value.toStringAsFixed(0)}"),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class StepPage extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onNext;
  final bool isLast;

  const StepPage({
    super.key,
    required this.title,
    required this.child,
    required this.onNext,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          child,
          const SizedBox(height: 30),
          if (!isLast)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onNext,
                child: const Text("Next"),
              ),
            ),
        ],
      ),
    );
  }
}

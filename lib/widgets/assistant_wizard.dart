import 'package:flutter/material.dart';

class AssistantWizard extends StatefulWidget {
  const AssistantWizard({super.key});

  @override
  State<AssistantWizard> createState() => _AssistantWizardState();
}

class _AssistantWizardState extends State<AssistantWizard> {
  int _currentStep = 0;

  final List<Map<String, dynamic>> _wizardSteps = [
    {
      'question': 'Are you a citizen of the country?',
      'options': ['Yes', 'No'],
      'info': 'Citizenship is generally required to vote in national and local elections.',
    },
    {
      'question': 'Will you be 18 years or older on Election Day?',
      'options': ['Yes', 'No'],
      'info': 'The legal voting age is 18 in most democratic countries.',
    },
    {
      'question': 'Have you registered to vote?',
      'options': ['Yes', 'No', 'Not sure'],
      'info': 'Voter registration is a mandatory step before you can cast your ballot.',
    },
  ];

  void _nextStep(String response) {
    if (_currentStep < _wizardSteps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Completed wizard
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Wizard Completed'),
          content: const Text('Thank you! Based on your answers, make sure to check your local voter registration portal to confirm your eligibility and polling location.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentStep = 0;
                });
              },
              child: const Text('Restart'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stepData = _wizardSteps[_currentStep];

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.assistant,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Eligibility Assistant',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Step ${_currentStep + 1} of ${_wizardSteps.length}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Column(
                key: ValueKey<int>(_currentStep),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stepData['question'],
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    stepData['info'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (stepData['options'] as List<String>).map((option) {
                      return ActionChip(
                        label: Text(option),
                        onPressed: () => _nextStep(option),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

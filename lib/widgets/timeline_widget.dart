import 'package:flutter/material.dart';
import 'step_detail_sheet.dart';

class TimelinePhase {
  final String title;
  final String dateRange;
  final String description;
  final IconData icon;

  TimelinePhase({
    required this.title,
    required this.dateRange,
    required this.description,
    required this.icon,
  });
}

class TimelineWidget extends StatefulWidget {
  const TimelineWidget({super.key});

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  final List<TimelinePhase> phases = [
    TimelinePhase(
      title: 'Voter Registration',
      dateRange: 'Jan 1 - Mar 31',
      description: 'Ensure you are registered to vote. Check your local guidelines for eligibility criteria and deadlines.',
      icon: Icons.app_registration,
    ),
    TimelinePhase(
      title: 'Candidate Nominations',
      dateRange: 'Apr 1 - Apr 30',
      description: 'Candidates file their nominations to run for various offices.',
      icon: Icons.person_add_alt_1,
    ),
    TimelinePhase(
      title: 'Campaigning',
      dateRange: 'May 1 - Oct 31',
      description: 'Candidates participate in debates, rallies, and town halls to share their platforms.',
      icon: Icons.campaign,
    ),
    TimelinePhase(
      title: 'Voting Day',
      dateRange: 'Nov 5',
      description: 'Head to your local polling station or mail your ballot to cast your vote.',
      icon: Icons.how_to_vote,
    ),
    TimelinePhase(
      title: 'Results & Certification',
      dateRange: 'Nov 6 - Dec 15',
      description: 'Votes are counted, audited, and official results are certified.',
      icon: Icons.fact_check,
    ),
  ];

  void _showPhaseDetails(TimelinePhase phase) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StepDetailSheet(phase: phase),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: phases.length,
      itemBuilder: (context, index) {
        final phase = phases[index];
        final isLast = index == phases.length - 1;

        return InkWell(
          onTap: () => _showPhaseDetails(phase),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        phase.icon,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        size: 20,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 60,
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        phase.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        phase.dateRange,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        phase.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

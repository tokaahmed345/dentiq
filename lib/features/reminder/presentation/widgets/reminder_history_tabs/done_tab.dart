

import 'package:dentiq/features/reminder/presentation/view_model/cubit/cubit/reminder_history_cubit.dart';
import 'package:dentiq/features/reminder/presentation/widgets/empty_state.dart';
import 'package:dentiq/features/reminder/presentation/widgets/reminder_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTab extends StatelessWidget {
  const DoneTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderHistoryCubit, ReminderHistoryState>(
      builder: (context, state) {
        if (state is ReminderHistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ReminderHistorySuccess) {
          if (state.done.isEmpty) {
            return const EmptyState(
              text: 'No completed reminders yet',
              icon: Icons.history,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.done.length,
            itemBuilder: (context, index) {
              final reminder = state.done[index];
              return ReminderHistoryCard(
                reminder: reminder,
                showDoneButton: false,
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
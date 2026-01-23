import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:dentiq/features/reminder/presentation/view_model/cubit/dental_reminder_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_type.dart';
import 'package:dentiq/core/utils/constant/constant.dart';
import 'package:go_router/go_router.dart';

class ReminderViewBody extends StatefulWidget {
  const ReminderViewBody({super.key});

  @override
  State<ReminderViewBody> createState() => _ReminderViewBodyState();
}

class _ReminderViewBodyState extends State<ReminderViewBody> {
  DentalReminderType? selectedReminder;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
  }

  void pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary!,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DentalReminderCubit, DentalReminderState>(
      listener: (context, state) {
        if (state is DentalReminderFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is DentalReminderSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reminder added successfully'),
              backgroundColor: Colors.green,
            ),
          );
        Future.delayed(const Duration(milliseconds: 300), () {
  if (context.canPop()) {
    context.pop();
  }
});

        }
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Dental Reminder",
                      style: AppStyle.text20.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Choose a reminder and set the time",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final reminder = Constant.reminderTypes[index];
                  final isSelected = selectedReminder == reminder;

                  return GestureDetector(
                    onTap: () => setState(() => selectedReminder = reminder),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 7),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary!.withOpacity(0.08)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary!
                              : Colors.grey.shade200,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: AppColors.primary,
                            child: Icon(
                              reminder.icon,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reminder.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  reminder.subtitle,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                              size: 26,
                            ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: Constant.reminderTypes.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: pickTime,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time),
                            const SizedBox(width: 12),
                            Text(
                              selectedTime.format(context),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: state is DentalReminderLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton.icon(
                              icon: const Icon(
                                Icons.alarm,
                                color: AppColors.whiteColor,
                              ),
                           onPressed: selectedReminder == null
    ? null
    : () async {
        final now = DateTime.now();
        final reminderDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        if (reminderDateTime.isBefore(now)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Cannot set a reminder in the past!"),
              backgroundColor: AppColors.redColor,
            ),
          );
          return; 
        }

        final reminder = DentalReminder(
          id: '',
          title: selectedReminder!.title,
          subtitle: selectedReminder!.subtitle,
          time: selectedTime.format(context),
          icon: selectedReminder!.icon.codePoint.toString(),
          reminderTime: Timestamp.fromDate(reminderDateTime),
        );

        await context.read<DentalReminderCubit>().addReminder(reminder);
        context.read<DentalReminderCubit>().fetchUpcomingReminders();
      },

                              label: Text(
                                "Add Reminder",
                                style: AppStyle.text16,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

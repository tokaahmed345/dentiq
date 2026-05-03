import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/reminder/presentation/view_model/cubit/cubit/reminder_history_cubit.dart';
import 'package:dentiq/features/reminder/presentation/widgets/reminder_history_tabs/done_tab.dart';
import 'package:dentiq/features/reminder/presentation/widgets/reminder_history_tabs/missed_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:go_router/go_router.dart';
class ReminderHistoryPage extends StatelessWidget {
  const ReminderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReminderHistoryCubit>()..fetchHistory(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CustomAppBar(
          arrowBack: IconButton(onPressed:(){ GoRouter.of(context).pop();}, icon: const Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,size: 27,))
          ,title: "Reminder History"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              Container(
                margin: const  EdgeInsets.only(left: 8,right: 8) ,
  padding: const EdgeInsets.symmetric(horizontal: 8),
  decoration: BoxDecoration(
    color:          Theme.of(context).scaffoldBackgroundColor,

    borderRadius: BorderRadius.circular(20),
  ),
                child: TabBar(
                  indicatorColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.grey,
                  tabs: const [
                    Tab(text: 'Missed'),
                    Tab(text: 'Done'),
                  ],
                ),
              ),
              Expanded(
                child: const TabBarView(
                  children: [
                    MissedTab(),
                    DoneTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



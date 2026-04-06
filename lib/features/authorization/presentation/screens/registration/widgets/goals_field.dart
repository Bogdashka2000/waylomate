import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waylomate/features/authorization/presentation/blocs/profile_components_bloc/bloc.dart'
    hide State;
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/goal_alert.dart';

class GoalsRegistrationScreen extends StatefulWidget {
  GoalsRegistrationScreen({Key? key}) : super(key: key);

  @override
  _GoalsRegistrationScreenState createState() =>
      _GoalsRegistrationScreenState();
}

class _GoalsRegistrationScreenState extends State<GoalsRegistrationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileComponentsBloc>().add(GoalsRequested());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 45, right: 45, bottom: 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              spacing: 20,
              children: <Widget>[
                Image.asset(
                  "assets/authorization_preview/reg_images/goals_registration_element.jpg",
                  width: MediaQuery.of(context).size.width * 0.5,
                  scale: 0.2,
                ),
                const Text(
                  "Какие поездки вы планируете?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const Text(
                  "Система подберёт попутчиков с похожими задачами. Ехать с единомышленниками комфортнее и безопаснее!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                  ),
                ),
                BlocBuilder<ProfileComponentsBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is! GoalsLoadedState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is GoalsLoadedState) {
                      return BlocBuilder<
                        RegistrationFormBloc,
                        RegistrationFormState
                      >(
                        builder: (context, formState) {
                          final selectedIds =
                              formState is RegistrationFormInProgress
                              ? formState.selectedGoalIds
                              : <int>[];
                          if (formState is RegistrationFormInProgress ||
                              formState is RegistrationFormInitial) {
                            final selectedGoals = state.goals
                                .where((goal) => selectedIds.contains(goal.Id))
                                .toList();

                            return Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: selectedGoals.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'Цели не выбраны',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      padding: const EdgeInsets.all(10),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 3.5,
                                          ),
                                      itemCount: selectedGoals.length,
                                      itemBuilder: (context, index) {
                                        final hobby = selectedGoals[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                              255,
                                              215,
                                              196,
                                              255,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              hobby.goalName,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                  255,
                                                  74,
                                                  50,
                                                  115,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );
                    }
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 126, 87, 194),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () => {
                          showDialog<void>(
                            context: context,
                            builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider<ProfileComponentsBloc>.value(
                                  value: context.read<ProfileComponentsBloc>(),
                                ),
                                BlocProvider<RegistrationFormBloc>.value(
                                  value: context.read<RegistrationFormBloc>(),
                                ),
                              ],
                              child: GoalAlert(),
                            ),
                          ),
                        },
                        icon: Icon(
                          Icons.add,
                          size: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          BlocBuilder<RegistrationFormBloc, RegistrationFormState>(
            builder: (context, formState) {
              final selectedIds = formState is RegistrationFormInProgress
                  ? formState.selectedGoalIds
                  : <int>[];
              return Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: selectedIds.isNotEmpty
                      ? const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 126, 87, 194),
                            Color.fromARGB(255, 74, 50, 115),
                          ],
                        )
                      : const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 130, 130, 130),
                            Color.fromARGB(255, 43, 43, 43),
                          ],
                        ),
                ),
                child: InkWell(
                  onTap: () => selectedIds.isNotEmpty
                      ? Navigator.of(
                          context,
                          rootNavigator: false,
                        ).pushNamed('registration_languages')
                      : null,
                  borderRadius: BorderRadius.circular(8),
                  child:
                      BlocBuilder<RegistrationFormBloc, RegistrationFormState>(
                        builder: (context, state) {
                          if (state is RegistrationFormInProgress) {
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            );
                          }
                          return const Center(
                            child: Text(
                              "ДАЛЕЕ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

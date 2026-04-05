import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/profile_components_bloc/bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';

class HobbyAlert extends StatefulWidget {
  HobbyAlert({Key? key}) : super(key: key);

  @override
  _HobbyAlertState createState() => _HobbyAlertState();
}

class _HobbyAlertState extends State<HobbyAlert> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileComponentsBloc>().add(HobbiesRequested());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Выберите ваши хобби'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: BlocBuilder<ProfileComponentsBloc, ProfileState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            if (state is HobbiesLoadedState) {
              return BlocBuilder<RegistrationFormBloc, RegistrationFormState>(
                builder: (context, formState) {
                  final selectedIds = formState is RegistrationFormInProgress
                      ? formState.selectedHobbyIds
                      : <int>[];

                  if (formState is RegistrationFormInProgress ||
                      formState is RegistrationFormInitial) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.hobbies.isEmpty
                          ? 0
                          : state.hobbies.length,
                      itemBuilder: (context, index) {
                        final hobby = state.hobbies[index];
                        final isSelected = selectedIds.contains(hobby.Id);
                        return Container(
                          margin: EdgeInsets.only(top: 10),

                          // padding: EdgeInsets.only(),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color.fromARGB(255, 127, 57, 255)
                                : const Color.fromARGB(255, 250, 248, 255),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            dense: true,
                            title: Text(
                              state.hobbies[index].hobbyName,
                              style: TextStyle(
                                color: isSelected
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.grey.shade700,
                                fontSize: 18,
                              ),
                            ),
                            trailing: Checkbox(
                              value: isSelected,
                              activeColor: const Color.fromARGB(
                                255,
                                127,
                                57,
                                255,
                              ),
                              onChanged: (bool? value) {
                                if (value == true) {
                                  context.read<RegistrationFormBloc>().add(
                                    HobbySelected(hobby.Id),
                                  );
                                } else {
                                  context.read<RegistrationFormBloc>().add(
                                    HobbyUnselected(hobby.Id),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Center(child: Text("Some wrong")),
                    );
                  }
                },
              );
            } else if (state is ErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.deepPurple,
                      size: 48,
                    ),
                    Text(
                      "Ошибка сети",
                      style: TextStyle(fontSize: 24, color: Colors.deepPurple),
                    ),
                    Text(
                      state.error,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context
                          .read<ProfileComponentsBloc>()
                          .add(HobbiesRequested()),
                      child: Text("Попробовать снова"),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text("Some wrong"));
            }
          },
        ),
      ),
      actions: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Готово",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

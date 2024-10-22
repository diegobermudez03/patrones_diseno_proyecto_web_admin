import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/events/domain/use_cases/get_event_users_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/invite_user_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/invite_users_use_case.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_user_dto.dart';
import 'package:web_admin/features/events/presentation/state/event_states.dart';
import 'package:web_admin/features/events/presentation/state/mappers.dart';

class EventBloc extends Cubit<EventState> {

  final GetEventUsersUseCase _getEventUsersUseCase;
  final InviteUsersUseCase _inviteUsersUseCase;
  final InviteUserUseCase _inviteUserUseCase;

  EventBloc(
    this._getEventUsersUseCase,
    this._inviteUsersUseCase,
    this._inviteUserUseCase
  ) 
  : super(EventInitialState());

  void searchEvent(int eventId) async {
    await Future.delayed(Duration.zero);
    emit(SearchingEventState());
    final response = await _getEventUsersUseCase(eventId);
    response.fold(
      (f)=> emit(EventFailureState()), 
      (s)=> emit(
        EventUsersRetrievedState(s.map((ent)=> occasionToEventDTO(ent)).toList())
      )
    );
  }

  void inviteAll(int eventId) async{
    await Future.delayed(Duration.zero);
    emit(SearchingEventState());

    final response =  await _inviteUsersUseCase(eventId);
    int invited = 0;
    response.fold(
      (f)=> invited = 0, 
      (n)=> invited = n
    );
    
    final responseNewUsers = await _getEventUsersUseCase(eventId);
    responseNewUsers.fold(
      (f)=> emit(EventFailureState()), 
      (s)=> emit(
        EventUsersInvitedState(
          s.map((ent)=> occasionToEventDTO(ent)).toList(),
          invited,
        )
      )
    );

  }

  void inviteUsers(int occasionId, int eventId) async{
    await Future.delayed(Duration.zero);
    final String userEmail = switch(state){
      EventUsersInvitedState s => s.users.where((dto)=> dto.occasionId == occasionId).first.email,
      EventUserInvitedState s => s.users.where((dto)=> dto.occasionId == occasionId).first.email,
      EventState _ => ""
    };
    emit(SearchingEventState());

    final response =  await _inviteUserUseCase(Tuple2(eventId, occasionId));
    String email = userEmail;
    response.fold(
      (f)=> email = "", 
      (n){},
    );
    
    final responseNewUsers = await _getEventUsersUseCase(eventId);
    responseNewUsers.fold(
      (f)=> emit(EventFailureState()), 
      (s)=> emit(
        EventUserInvitedState(
          s.map((ent)=> occasionToEventDTO(ent)).toList(),
          email,
        )
      )
    );
  }
}

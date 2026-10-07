import 'package:equatable/equatable.dart';
import '../../domain/entities/app_settings_entity.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettingsRequested extends SettingsEvent {
  const LoadSettingsRequested();
}

class UpdateSettingsRequested extends SettingsEvent {
  final AppSettingsEntity settings;

  const UpdateSettingsRequested(this.settings);

  @override
  List<Object?> get props => [settings];
}

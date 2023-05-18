// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'achievment_cubit.dart';

@immutable
abstract class AchievementState extends Equatable {}

class AchievementInitial extends AchievementState {
  final List<AchievementModel> achievements;
  final Color? startColor;
  final Color? endColor;
  AchievementInitial({
    required this.achievements,
    this.startColor,
    this.endColor,
  });

  AchievementInitial copyWith({
    List<AchievementModel>? achievements,
    Color? startColor,
    Color? endColor,
  }) {
    return AchievementInitial(
      achievements: achievements ?? this.achievements,
      startColor: startColor ?? this.startColor,
      endColor: endColor ?? this.endColor,
    );
  }

  @override
  List<Object?> get props => [achievements, startColor, endColor];
}

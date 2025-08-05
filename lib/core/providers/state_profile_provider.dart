import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// Ce provider gère les données locales de profil utilisateur
/// (nom d'affichage, icône sélectionnée, image de profil)
class StateProfileProvider extends HydratedCubit<ProfileState> {
  StateProfileProvider() : super(ProfileState());

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateIconIndex(int? index) {
    emit(state.copyWith(iconIndex: index, photoPath: null)); // Priorité à l'icône
  }

  void updatePhotoPath(String? path) {
    emit(state.copyWith(photoPath: path, iconIndex: null)); // Priorité à la photo
  }

  void reset() {
    emit(ProfileState()); // état par défaut
  }

  @override
  ProfileState fromJson(Map<String, dynamic> json) {
    return ProfileState(
      name: json['name'] as String?,
      iconIndex: json['iconIndex'] as int?,
      photoPath: json['photoPath'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson(ProfileState state) {
    return {
      'name': state.name,
      'iconIndex': state.iconIndex,
      'photoPath': state.photoPath,
    };
  }
}

/// Modèle de données persisté pour le profil
class ProfileState {
  final String? name;
  final int? iconIndex;
  final String? photoPath;

  const ProfileState({
    this.name,
    this.iconIndex,
    this.photoPath,
  });

  ProfileState copyWith({
    String? name,
    int? iconIndex,
    String? photoPath,
  }) {
    return ProfileState(
      name: name ?? this.name,
      iconIndex: iconIndex ?? this.iconIndex,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}
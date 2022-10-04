part of 'home_location_cubit.dart';

@immutable
abstract class HomeLocationState {
  const HomeLocationState();
}

class HomeLocationInitial extends HomeLocationState {
  const HomeLocationInitial();
}

class HomeLocationLoaded extends HomeLocationState {
  final HomeLocation homeLocation;
  const HomeLocationLoaded(this.homeLocation);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeLocationLoaded &&
        other.homeLocation == homeLocation;
  }

  @override
  int get hashCode => homeLocation.hashCode;
}

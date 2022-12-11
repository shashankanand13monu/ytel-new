class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    this.id=0,
    this.name="",
    this.imageUrl="",
    this.isOnline=false,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: '+1 9878767692',
  imageUrl: 'assets/images/logo.png',
  isOnline: true,
);

// USERS
final User ironMan = User(
  id: 1,
  name: '+1 9878767692',
  imageUrl: 'assets/images/user_4.png',
  isOnline: true,
);
final User captainAmerica = User(
  id: 2,
  name: '+1 9818765643',
  imageUrl: 'assets/images/user_2.png',
  isOnline: true,
);
final User hulk = User(
  id: 3,
  name: '+1 9878767692',
  imageUrl: 'assets/images/user_3.png',
  isOnline: false,
);
final User scarletWitch = User(
  id: 4,
  name: '+1 9878767692',
  imageUrl: 'assets/images/user_4.png',
  isOnline: false,
);
final User spiderMan = User(
  id: 5,
  name: '+91 6536974368',
  imageUrl: 'assets/images/user_5.png',
  isOnline: true,
);
final User blackWindow = User(
  id: 6,
  name: '+91 6536974368',
  imageUrl: 'assets/images/cn_flag.png',
  isOnline: false,
);
final User thor = User(
  id: 7,
  name: '+91 6536974368',
  imageUrl: 'assets/images/user.png',
  isOnline: false,
);
final User captainMarvel = User(
  id: 8,
  name: '+91 6536974368',
  imageUrl: 'assets/images/it_flag.png',
  isOnline: false,
);
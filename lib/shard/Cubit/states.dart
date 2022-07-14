abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

// Business States

class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates{
  final String error;

  NewsGetBusinessErrorState(this.error);
}

// Sports States
class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsSuccessState extends NewsStates{}

class NewsGetSportsErrorState extends NewsStates{
  final String error;

  NewsGetSportsErrorState(this.error);
}

// Scince States

class NewsGetScinceLoadingState extends NewsStates{}

class NewsGetScinceSuccessState extends NewsStates{}

class NewsGetScinceErrorState extends NewsStates{
  final String error;

  NewsGetScinceErrorState(this.error);
}

// Search States

class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchSuccessState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates{
  final String error;

  NewsGetSearchErrorState(this.error);
}


class NewsChangeAppThemeState extends NewsStates{}



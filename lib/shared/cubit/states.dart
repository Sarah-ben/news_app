abstract class   newsStates {}
class InitialNews extends newsStates{}
class newsBottomNav extends newsStates{}
class changeBottomNAvBarState extends newsStates{}
class NewsGetBusinessSuceessState extends newsStates{}
class NewsGetScienceSuceessState extends newsStates{}
class NewsGetSportsSuceessState extends newsStates{}
class NewsGetBusinessErrorState extends newsStates{
  final String error;
  NewsGetBusinessErrorState(this.error);
}
class NewsGetScienceErrorState extends newsStates{
  final String error;
  NewsGetScienceErrorState(this.error);
}
class NewsGetSportsErrorState extends newsStates{
  final String error;
  NewsGetSportsErrorState(this.error);
}
class NewsGetBusinessLoadingState extends newsStates{}
class NewsGetScienceLoadingState extends newsStates{}
class NewsGetSportsLoadingState extends newsStates{}
class NewsChangeAppTheme extends newsStates{}
class NewsSearchState extends newsStates{}
class NewsSearchLoadingState extends newsStates{}
class NewsSearchErrorState extends newsStates{}
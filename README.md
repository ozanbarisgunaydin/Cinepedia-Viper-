The Cinepedia app uses the MovieDB.org database. Mainly, app provides 4 different scenes which are Splash, List, Search and Detail. 
The whole app builded with VIPER architecture. In addition, a clean network layer is used for the best comminication with API.

The Auto-Layout principls applied when design the views according the guidline warframe. As shown below, the view components showed properly all of the screen sizes:

![autoLayout](https://user-images.githubusercontent.com/88930979/165840238-6396b1ed-560e-436b-bdbd-4fae0ca3fcbd.png)


Generally users can list movies after the checking the internet connection on splash screen. If the internet connection is losed app inform the user and closes the app.
Otherwise, after a 1 second users can see the movies list which are contains Up Coming and Now Playin movies.

![ezgif com-gif-maker (3)](https://user-images.githubusercontent.com/88930979/165649345-92cdc46f-f164-4fcb-ae63-f523525571cd.gif)

User can search movies with using query parameters to fetching data from API. The search is prelimited with 2 characters. 
With other words, too improve searching quality user can search after typing 3 and more letters on search bar. Also, this method works with waiting typing of users.

![ezgif com-gif-maker (4)](https://user-images.githubusercontent.com/88930979/165650374-861b2d8e-2446-4c01-a40c-cd1f1b55617d.gif)

The user can move detail all of the movie items. In the detail scene, app provides imdb link to visiting web page that provides more information.
In addition, app has a favorite movie structure which uses the UserDefaults and the main response model of detail service.

![ezgif com-gif-maker (6)](https://user-images.githubusercontent.com/88930979/165650420-834c9323-1f6e-46e9-84dd-cff9cff23c73.gif)

On the other hand, The UITests and UnitTest is added with the fully support of the VIPER design pattern.


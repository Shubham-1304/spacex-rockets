# spacex_rockets

Sample project to show spacex rockets.


## Approach
Architecture: Clean Architecture with Test Driven Development
State Management: Bloc

A single `Rocket` entity has been created for all the properties related to the rocket. This entity will be used to fill-in the data required in both the pages and cache these data once received from the api.

## Architectural Flow

`entity` - To define all the properties of Rocket.
`model` -  To implement entity class and tranform data.
`datasource` - To add methods to connect with 3rd party api & also to connect with local database for caching.
`repositories` -  To separate ui layer from the data layer.
`usecases` -  To create individual business logic methods.
`bloc` - for state management.
`widgets/screens` - for building ui

## Packages
- get_it: for dependency inversion
- sqflite: for caching data
- http: for calling apis
- flutter_bloc: for state management
- cached_network_image: To cache the network images so that image has not be fetched from url again & again
- flutter_screenutil: for making the screen height and width to create dynamic size widget

## Scope Of Improvement
There are multiple points to make the app more ui friendly and efficient:
- adding shimmer to make data loading more user friendly
- we can also add pull to refresh or a refresh button to hard load the data directly from api and not the cached data.
- Like datasource and model folder we can also do the testing for other remaining files
- for better route management we can use auto_route package


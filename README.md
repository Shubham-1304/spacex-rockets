# spacex_rockets

Sample project to show spacex rockets.


## Approach
Architecture: Clean Architecture with Test Driven Development
State Management: Bloc

A single `Rocket` entity has been created for all the properties related to the rocket. This entity will be used to fill-in the data required in both the pages and cache these data once received from the api.

## Trade-offs
An alternative approach was to create two different entities `RocketOverview` for brief details that are required in the rocket list page and `RocketDetail` for the detailed information about the rocket, needed in the second page, but this would need two separate calls to the api; but as we can extract whole information from single api this approach might be an overkill.

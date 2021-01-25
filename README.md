# RickAndMorty

## Sample project using the Rick and Morty character API: https://rickandmortyapi.com/api/character

### What would I do next?

- Since the remote responds with the full character object on the listing endpoint (something which I personally wouldn't do), 
local object caching is possible to avoid a second request in the details page. Adding a "local service" to complement the remote service (which accesses the API) would be possible.

- Add more testing to the Loading/Error views

- Change TableView cells to be prettier.

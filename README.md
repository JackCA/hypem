# Hypem Ruby Gem ![travis](https://secure.travis-ci.org/JackCA/hypem.png?branch=master) #
## Introduction ##
This is an unoffical Ruby gem for the **Hype Machine** read-only API. It currently only supports Ruby `1.9.x`.

## Usage ##

### Playlist ###

The `Playlist` object is the root of the Hypem API. Each `Playlist` has an array of `Hypem::Track`'s accessed via the `tracks` attribute. Pagination is supported with the `.next_page` and `.prev_page`, `page(num)` methods.

#### Querying #####
General playlists can be accessed using the following methods. The last argument to each method is the desired page (default `1`).

- `Hypem.playlist.artist('artist_name')` --- latest tracks from a given artist

- `Hypem.playlist.blog('blog_name')` --- latest tracks from a given blog name

- `Hypem.playlist.search('query_string')` --- tracks matching string 

- `Hypem.playlist.tags(['tag_name','electro','indie'])` --- tracks matching tags. *The API warns against combining too many different tags*

- `Hypem.playlist.popular` --- the most popular tracks over a certain timeframe or set. It accepts the following filters:
    - `'3day'` _default_ --- most popular over last 3 days
    - `:lastweek` --- most popular over last week
    - `:noremix` --- most popular non-remixed tracks over last 3 days
    - `:artists` --- most popular artists' tracks over last 3 days
    - `:twitter` --- most popular tweeted tracks over last 3 days

- `Hypem.playlist.latest` --- the latest posted tracks. It accepts the following filters:
    - `:all` _default_ --- all tracks, regardless of repost status
    - `:fresh` --- only first posted tracks
    - `:noremix` --- only non-remixed tracks
    - `:remix` --- only remixed tracks

#### Misc. ####

- `Hypem.playlist.new_from_tracks([hypem_track1,hypem_track2])` --- create a custom playlist from an array of `Hypem::Track`'s

******

### User ###
Users can be accessed via `Hypem.user('username')` and have various methods:
#### General Methods ####
- `user.get_profile` updates the user object with the following attributes: `full_name`, `location`, `image_url`, `followed_users_count`, `followed_items_count`, `followed_sites_blog`, and `followed_queries_count`

- `user.friends` retrieves the user's friends as an array of `Hypem::User` objects

- `user.favorite_blogs` retrieves the user's favorite blogs as an array of `Hypem::Blog` objects

#### Playlist Methods ####
`Hypem::User` offers several methods for accessing a particular user's personalized playlists:

  - `user.loved_playlist` --- a user's loved tracks

  - `user.obsessed_playlist` --- a user's obsessed tracks

  - `user.feed_playlist` --- a user's tracks from all followed entities

  - `user.friends_favorites_playlist` --- a user's friends' favorited tracks

  - `user.friends_history_playlist` --- tracks from a user's friends' listening histories

******

### Blog ###
Blogs can be retrieved using a blog's unique id via `Hypem.blog(1234)` and have the following methods:

- `blog.get_info` -- retrieves extended information about a blog and sets `blog_image`, `blog_image_small`, `first_posted`, `followers`, `last_posted`, `site_name`, `site_url`, `total_tracks`, and `id`

******

### Track ###
All Playlist objects have a `tracks` attribute containing an array of `Hypem::Track`'s. A sample object inspect is as follows:

      #<Hypem::Track
        artist="Hot Chip"
        date_loved=1332109580
        date_posted=1332252311
        description="O Hot Chip está de volta com um novo álbum, In Our Heads, que vai ser lançado oficialmente em junho, mas já conta com seu primeiro vídeo, “Flutes”, disponível para visualização. A faixa serve de abertura para o novo álbum dos já bem sucedidos garotos, e p"
        itunes_link="http://hypem.com/go/itunes_search/Hot%20Chip"
        loved_count=4912
        media_id="1jsw9"
        post_id=1753700
        post_url="http://www.ohmyrock.net/2012/03/hot-chip-flutes/"
        posted_count=14
        site_id=14635
        sitename="Oh My Rock"
        thumb_url="http://static-ak.hypem.net/images/albumart4.gif"
        thumb_url_large="http://static-ak.hypem.net/images/blog_images/14635.png"
        time=425
        title="Flutes">

****** 

## TODO ###
- Blogs with given tag
- Single track info
- Authenticated Requests
- Favorite a track
- Log Playback

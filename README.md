# Hypem Ruby Gem [![travis](https://secure.travis-ci.org/JackCA/hypem.png?branch=master)](http://travis-ci.org/JackCA/hypem) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/JackCA/hypem)#
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
Tracks can be initialized using a known `media_id` via `Hypem.track('media_id')` and synced using the `get` method on any instance. Depending on the playlist type, some tracks may have more detailed attributes than other.

An example track object inspection is as follows:

``` 
@media_id="1jsw9",
@artist="Hot Chip",
@title="Flutes",
@date_posted=#<DateTime: 2012-06-08T16:57:00-07:00 ((2456087j,86220s,0n),-25200s,2299161j)>,
@site_id=16116,
@site_name="the untz and the indie",
@post_url="http://theuntzandtheindie.com/2012/06/08/hot-chip-party/",
@post_id=1835105,
@loved_count=9050,
@posted_count=33,
@thumb_url="http://static-ak.hypem.net/images/albumart0.gif",
@thumb_url_large="http://static-ak.hypem.net/images/blog_images/16116.png",
@time=425,
@description="Today’s Indie: If I Was Your Girlfriend (Hot Chip Cover) / Prince /// Motion Sickness / Hot Chip /// Flutes / Hot Chip So the indie extraordinaire and goddess of all things awesome is out of town up in the Pac NW gettin silly and listening to dAHnce music",
@itunes_link="http://hypem.com/go/itunes_search/Hot%20Chip"
```

****** 

### Track Favorites ###
The users who liked a track can be retrieved via `Hypem::TrackFavorites('trackid')` or `track.favorites` and synced using the `get` method.

Their pagination is supplied via the same methods as the `Hypem::Playlist` ones, and they also accept the desired page as the last argument at initialization : `Hypem::TrackFavorites('trackid', page)`

****** 

## TODO ###
- Blogs with given tag
- Authenticated Requests
- Favorite a track
- Log Playback

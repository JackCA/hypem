# Hypem Ruby Gem #
## Introduction ##
This is an unoffical Ruby gem for the **Hype Machine** public API. It supports all of the supported Playlist requests and wraps all responses in custom Ruby objects. It currently only supports Ruby `1.9.x`.

## Usage ##

### Playlist ###
`Hypem::Playlist` is the center of the Hypem API as it stands. It supports the following calls:

- `Hypem.playlist.artist('artist_name')` --- the latest tracks from a given artist

- `Hypem.playlist.blog('blog_name')` --- the latest tracks from a given blog

- `Hypem.playlist.search('query_string')` --- searches for tracks matching given string

- `Hypem.playlist.tags('tag_name,electro,indie')` --- tracks matching given comma-delimited tags. *The API warns against combining too many different tags*

- `Hypem.playlist.popular` --- the most popular tracks over a certain timeframe or set. It accepts one of the following arguments:

<table>
  <thead>
    <tr>
      <th> Argument </th>
      <th> Response (Most Popular...) </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>'3day'</code> <em>default</em></td>
      <td>tracks over the last 3 days</td>
    </tr>
    <tr>
      <td><code>:lastweek</code></td>
      <td>tracks over the last 7 days</td>
    </tr>
    <tr>
      <td><code>:noremix</code></td>
      <td>non-remixed tracks, over last 3 days</td>
    </tr>
    <tr>
      <td><code>:artists</code></td>
      <td>tracks by most-blogged artists over last 3 days</td>
    </tr>
    <tr>
      <td><code>:twitter</code></td>
      <td>tweeted tracks over last 3 days</td>
    </tr>
  </tbody>
</table>

******

### User ###
`Hypem::User` offers several convenience methods for accessing a particular user's personalized playlists:

- `Hypem.user('name').loved_playlist` --- a user's loved tracks

- `Hypem.user('name').obsessed_playlist` --- a user's obsessed tracks

- `Hypem.user('name').feed_playlist` --- a user's tracks from all followed entities

- `Hypem.user('name').friends_favorites_playlist` --- a user's friends' favorited tracks

- `Hypem.user('name').friends_history_playlist` --- tracks from a user's friends' listening histories

******

### Track ###
All of the above methods return an array of `Hypem::Track`'s. A sample object inspect is as follows:

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

### TODO ###
  - Add single track retrieval ability

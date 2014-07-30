# App Name

TODO

# App Description

Downloads freely-available DJ sets from http://www.livesets.us and splits them using cuesheet files downloaded from http://www.cuenation.com to produce a searchable listing of DJ sets and split individual tracks (split with mp3splt) with download links to both the original DJ set file, the .cue file, and the split individual .mp3 files.

# User Stories

## Will implement

- As a user, I want to have the option to download the full DJ set.
  TODO: Add acceptance criteria.

- As a user, I want to have the option to download the associated .CUE file.
  TODO: Add acceptance criteria.

- As a user, I want to have the option to download single tracks split from a DJ set.
  TODO: Add acceptance criteria.

- As a user, I want be see the tracklist of a set.
  TODO: Add acceptance criteria.

- As a user, I want to see pictures of the artist at shows they've previously played at.
  TODO: Add acceptance criteria.

## Might implement, time-permitting

- As a user, I want to be able to visit the SoundCloud page of an artist.
- As a user, I want to be able to visit the official website of an artist.
- As a user, I want to look up the lyrics for a song I like.

## Won't implement

- As a user, I want to be able to log in and out of the app.
- As a user, I want suggestions for new artists to explore, based on the music I previously listened to.
- As a user, I want to be able to resell tickets more reliably to a show if I can't make it.
- As a user, I want to be able to find out the ID of an "ID - ID" song.
- As a user, I want search for a higher quality version of the set.
- As a user, I want to keep a log of what I've listened to.
- As a user, I want to know what my actual friends are listening to.
- As a user, I want to know when I'm able to see an artist next, up to a year in advance by seeing their tour dates.

# Pages

Create a list of pages. 

For each page, mention:
- URL structure for the page
- a sentence or two describing what that page will have on it (a form, a list, details, something else? multiple things?)

## Home Page

TODO: Fill this out based on pen and paper notes.

## Set Page

TODO: Fill this out based on pen and paper notes.

# User flow 

TODO: Reword this based on pen and paper notes.

```
1. User enters search query of artist, set name, or event location
2. Backend queries http://www.livesets.us/Search1/archive1/?term=SEARCHPHRASE&page=1&exact_on=1 using the `mechanize` gem
3. Backend *scrapes* search results from http://www.livesets.us/ using the `nokogiri` gem
4. User chooses 1 set to download [Download set] [Download singles]
5. Backend:
    1. Download .MP3 files from livesets.us
    2. Search http://www.1001tracklists.com for a tracklist
        - If there's an existing tracklist,
            - *scrapes* tracklist
    3. If there's an existing .CUE sheet at http://www.cuenation.com:
        - Download .CUE file
        - Splits the downloaded .MP3 file on the server using the `mp3splt` command line tool

Display images from Google Images API using https://github.com/maurimiranda/image_suckr
```

# Entity-Relationship Diagram

TODO: Draw with Dia and save .PNG

# APIs and links

http://musicmachinery.com/music-apis/
http://docs.seattlerb.org/mechanize/
Tickets: https://github.com/bluefocus/seatgeek
Suggested artists from last.fm using gem
Lyrics gem: https://github.com/pilu/musix_match

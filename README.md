# Roblox API — free JSON API for Roblox data (no key required)

A **free Roblox API** serving verified Roblox data as JSON: **music codes / song IDs with live working status**, **decal & image IDs**, catalog items and game codes. No API key, no signup, CORS enabled — usable from a browser, a Discord bot, or straight from a Roblox game via `HttpService`.

**Docs:** https://rblxdb.com/developers · **Status:** https://rblxdb.com/status · **How verification works:** https://rblxdb.com/how-we-verify

## Why this exists

Most Roblox ID lists are dead. Since the 2022 audio-privacy change, songs get deleted, moderated or made private constantly — and static lists never notice. This API re-verifies every audio ID against the Roblox catalog around the clock and exposes the result (`isWorking` + `verifiedAt`) so your app never plays a dead code.

## Endpoints

### Songs — verified Roblox music codes

```
GET https://rblxdb.com/api/v1/songs?q=<search>&genre=<genre>&limit=<1-100>
```

```json
{
  "count": 1,
  "attribution": {
    "text": "Roblox ID data from rblxdb",
    "url": "https://rblxdb.com",
    "html": "<a href=\"https://rblxdb.com/music\">Roblox music codes by rblxdb</a>"
  },
  "songs": [{
    "id": "142376088",
    "name": "Parry Gripp - Raining Tacos",
    "artist": "Parry Gripp",
    "genre": "electronic",
    "isWorking": true,
    "verifiedAt": "2026-08-17T09:00:00.000Z",
    "url": "https://rblxdb.com/music/parry-gripp-raining-tacos-142376088"
  }]
}
```

Every song carries `isWorking` (re-verified hourly against the Roblox catalog) and `verifiedAt`. Pass `working=false` to include unverified IDs.

### Decals — checked Roblox image IDs

```
GET https://rblxdb.com/api/v1/decals?q=<search>&theme=<anime|memes|aesthetic|cursed|cute|gaming|wallpapers|art>&limit=<1-100>
```

## Usage examples

### JavaScript / TypeScript

```js
const res = await fetch('https://rblxdb.com/api/v1/songs?q=phonk&limit=10')
const { songs } = await res.json()
const working = songs.filter(s => s.isWorking)
```

### Roblox Luau (in-game via HttpService)

```lua
-- Game Settings → Security → Allow HTTP Requests: ON
local HttpService = game:GetService("HttpService")
local res = HttpService:GetAsync("https://rblxdb.com/api/v1/songs?limit=25")
local songs = HttpService:JSONDecode(res).songs
for _, song in ipairs(songs) do
	print(song.name, song.id, song.isWorking)
end
```

### Python

```python
import requests
songs = requests.get("https://rblxdb.com/api/v1/songs", params={"q": "tacos"}).json()["songs"]
working_ids = [s["id"] for s in songs if s["isWorking"]]
```

## Attribution

Every response carries an `attribution` object with a ready-made credit line, and every item includes its own `url` back to the page for that ID. Linking those gives your users the live verification status too:

```js
const { songs, attribution } = await (await fetch('https://rblxdb.com/api/v1/songs?limit=10')).json()
songs.forEach(s => console.log(`${s.name} — ${s.id} → ${s.url}`))
document.querySelector('#credit').innerHTML = attribution.html
```

## Fair use

Free for non-commercial projects — games, Discord bots, school projects, tools. Responses are cached hourly; please cache on your side too and link back to [rblxdb.com](https://rblxdb.com) where you show the data. Commercial / high-volume use: see https://rblxdb.com/advertise.

## Related

- [rblxdb.com](https://rblxdb.com) — browse the full database: [music codes](https://rblxdb.com/music), [decal IDs](https://rblxdb.com/decals), [catalog items](https://rblxdb.com/catalog), [game codes](https://rblxdb.com/games), [player stats](https://rblxdb.com/stats), [events calendar](https://rblxdb.com/events)
- Not affiliated with Roblox Corporation. Roblox and Robux are trademarks of Roblox Corporation.

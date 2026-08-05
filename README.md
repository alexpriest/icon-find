# icon — 317k open-source icons from the command line

Wraps [Iconify](https://iconify.design)'s public API. **231 icon sets, 317,631 icons, free, no API key, no account.**
Built 2026-08-05 as the alternative to a Noun Project API subscription ($25/mo minimum,
separate from the Pro download subscription).

```sh
icon search cocktail              # ranked hits across every set, with licenses
icon sheet cocktail --open        # render candidates to a labeled PNG grid and look
icon get lucide:martini -o src/icons/
```

## Why a CLI and not an MCP

An MCP server's tool schema loads into **every** session whether or not it's used.
This gets reached for during design work, maybe weekly. A CLI costs nothing until invoked.
Same capability, no standing context tax.

## Commands

| | |
|---|---|
| `icon search <query…>` | Search all sets. Grouped by collection, license shown, lucide floated to the top. `--set lucide,tabler` to restrict, `--top N`, `--flat` for bare ids, `--json`. |
| `icon sheet <query…>` | Render up to `--top` (default 48) candidates into one labeled PNG grid. `--open` to view, `-o` for the path, `--cols`, `--cell`, `--color`. |
| `icon get <prefix:name>…` | Print the SVG to stdout, or `-o DIR` to write `<name>.svg`. `--color` bakes a hex fill, `--size` bakes a px height. |
| `icon sets [term]` | List collections — count, name, license. Filter by name/category/tag. |
| `icon info <prefix>` | One collection in detail, with sample icon ids. |

## The three things that will bite you

**1. A compound query returns 0 even when both words have hundreds of hits.**
Iconify AND-matches words against icon *names*, not concepts. `cocktail shaker` → **0**,
while `cocktail` → 49 and `shaker` → 9. There is simply no icon named both.
`icon search` handles this itself: on an empty compound result it re-searches each
word and reports them separately, and on an empty single word it retries the
singular/plural. **An empty result here is a naming miss, never proof the concept
is missing** — the tool says so in its own output rather than letting a caller
conclude otherwise.

**2. Names lie — look at the picture.** `mdi:shaker` is a *salt* shaker.
`streamline-kameleon-color:cocktail` is a full-color illustration, not a line icon.
`icon sheet` exists for exactly this: fetch the candidates, render them into one
labeled grid, and actually look before choosing. Same lesson as `photofind`'s contact sheets.

**3. Licenses are not uniform.** Most sets are MIT/ISC/Apache/CC0 — use freely.
But Font Awesome Free is CC BY 4.0, Game Icons is CC BY 3.0, Weather Icons is OFL:
**attribution required**. `search`, `sets`, and `info` all print the license and mark
attribution-bearing sets with `⚠ attribution`. Check it before shipping an icon into
a client deliverable.

## Ordering

`lucide` and `lucide-lab` are floated first and marked ★ (Alex's default set — ISC, 1,756 icons).
Then a tier of clean general-purpose sets (tabler, phosphor, heroicons, mdi, material-symbols,
solar, iconoir, carbon, fluent…), then everything else. Within a set, exact name matches rank
above partial ones. Nothing is hidden — it is display ordering only.

## Output format

SVGs come back with `width="1em" height="1em"` and `stroke="currentColor"`, so they inherit
font size and text color when dropped into a page. That's usually what you want — only pass
`--color` / `--size` when you need a standalone asset with the values baked in.
Collections with `palette: true` (emoji sets, `*-color` sets) have their own baked colors and
ignore `--color`.

## Requires

Python 3 (stdlib only). `icon sheet` additionally needs `rsvg-convert` (`brew install librsvg`)
and ImageMagick (`brew install imagemagick`) — both already installed on both machines.

⚠️ **ImageMagick on stock macOS has no font config** — `magick -list font` is empty, and montage
dies with ``unable to read font `' `` unless handed an explicit font file. The script hunts
`SFNSMono.ttf` → `Monaco.ttf` → `Arial.ttf`. Don't remove that.

## Install

```sh
~/Code/tools/icon-find/install.sh     # symlinks into ~/.local/bin
```

`~/.local/bin` is per-machine (not synced), so run this once on each Mac. `~/Code` itself
syncs via Syncthing.

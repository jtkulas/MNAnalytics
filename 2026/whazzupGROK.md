**Yes, something has changed with full Torvik data access via `cbbdata` for the 2025-26 (2026) season.**

The `cbd_torvik_ratings()` function (and related Torvik-sourced functions like player/game-level ones) is pulling **incomplete data** this year—many variables that were present in prior seasons are now missing—for the first time. This matches open issues on the cbbdata GitHub repo, including one explicitly titled **"No Bart Torvik Data for 2025-26 Season"** (plus related reports of missing 2025-26 data in other Torvik functions).

### Why this is happening
- `cbbdata` is the official successor to the deprecated `toRvik` package. It uses a custom **CBBData API** backend (not direct scraping in your R session) to pull and clean Bart Torvik data. The package site and changelog confirm this shift for faster/more structured access, with `cbd_torvik_ratings` documented as returning year-end (or current) team ratings like `adj_o`, `adj_d`, `barthag`, etc.
- The backend appears to have a lag or ingestion issue specific to the current season. The database is supposed to update every 15 minutes during the season, but Torvik-sourced content isn't fully flowing through for 2026 yet (unlike every prior year).

### Important note on the source data
The raw Torvik data **itself is unchanged and fully available** on barttorvik.com for 2026 (2025-26 season). You can see the complete set of metrics there right now (AdjOE/AdjDE, Barthag, all four factors, shooting splits, tempo, WAB, etc.—exactly as in past seasons), with no login, paywall, or format changes.

The problem is isolated to how `cbbdata`'s API is currently sourcing/processing it.

### What to do
- Watch the [cbbdata GitHub issues page](https://github.com/andreweatherman/cbbdata/issues) (the maintainer is responsive on these). Once the backend is updated, `cbd_torvik_ratings(2026)` should return the full variable set again.
- As a temporary workaround, you can manually pull from barttorvik.com (or use other sources like KenPom via the package's `cbd_all_metrics()` if it covers your needs).
- Check for package updates: `update.packages("cbbdata")` or reinstall from GitHub if a fix drops.

This is purely a backend/API hiccup on the cbbdata side for the new season—no broader change in Torvik's public data policy or accessibility. It should resolve once the maintainer syncs the 2025-26 data fully.
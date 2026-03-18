Got it—since **cbbdata** (the toRvik successor) appears to lack complete or up-to-date coverage for the 2025-2026 season (examples/docs focus on 2024, last major updates were mid-2024, and no explicit 2026 support is documented), here are the strongest **alternative sources** for accessible NCAA basketball data right now (as of March 17, 2026). These emphasize tournament-relevant files (seeds, historical results, team stats, resumes, game logs) suitable for predictive modeling like bracket probabilities, win probabilities, or March Madness simulations.

### 1. Direct from Bart Torvik (T-Rank) – Easiest Bulk Download for Current Season
Bart Torvik provides public **year-specific CSV/JSON files** that update live during the season—no API key, no package install needed. These are game-level results with per-game stats (points, efficiency, opponent, etc.), which you can aggregate yourself for team-season metrics (including proxies for SOS via opponent quality). The full aggregated ratings table (with SOS vars like nc_elite_sos) isn't directly downloadable, but the game data lets you compute most of what you need.

Key files for 2026:
- Game-by-game team results/stats: https://barttorvik.com/2026_team_results.csv  
  (Or .json version: https://barttorvik.com/2026_team_results.json)  
  This includes columns like Date, Team, Opponent, Result, AdjO, AdjD, Pace, etc.—perfect for building features (e.g., average opponent AdjO/DE for SOS). It updates constantly.

- Other useful: Player stats or splits via similar patterns (e.g., contact the maintainer @totally_t_bomb on X/Twitter for bulk player data if needed).

Quick R/Python grab (no jsonlite issues—use read.csv or pandas):
```r
# In R
df <- read.csv("https://barttorvik.com/2026_team_results.csv")
head(df)  # Inspect columns
write.csv(df, "torvik_2026_games.csv")
```

This is the closest to your original Torvik files without the hidden SOS columns—aggregate by team for season totals.

### 2. Kaggle March Machine Learning Mania 2026 – Tournament-Focused Dataset
The official Kaggle competition for forecasting the 2026 NCAA Tournament is live now (launched ~Feb 2026, with data refreshes). As of March 17:
- Data includes historical tournaments (back to ~1985), team IDs/mappings, seeds (updated post-Selection Sunday on March 15), detailed regular-season game results, and stage1/stage2 files for modeling.
- Final data refresh happened ~March 15-16 (post-Selection Sunday), so it has the full bracket setup, seeds, and historical matchups.
- Download ZIP directly—no code required after free Kaggle signup.

Link: https://www.kaggle.com/competitions/march-machine-learning-mania-2026/data  
Ideal for: Logistic models on seed diffs, win probs, upset predictions. Many past winners share notebooks using KenPom/Torvik-inspired features.

### 3. Other Strong, Accessible Options
- **EvanMiya Analytics** (https://evanmiya.com/): Free public tables for advanced metrics (player ratings, lineup data, team efficiency). No bulk CSV, but scrape tables with rvest or copy-paste—updated live, includes NET/quadrant-like resume strength.
- **Sports-Reference CBB** (https://www.sports-reference.com/cbb/): Yearly school pages with schedules/results/advanced stats (PER, BPM). Export tables manually or scrape. Historical depth great for training models.
- **ncaa-api (Public JSON, No Auth)**: Real-time tournament data (scores, brackets, box scores). Example endpoint: https://ncaa-api.henrygd.me/scoreboard/basketball-men/d1/2026/03 (adjust dates). Use httr in R:
  ```r
  library(httr)
  resp <- GET("https://ncaa-api.henrygd.me/bracket/basketball-men/d1/2026")  # Bracket structure
  bracket <- content(resp)
  ```
  Great supplement for post-season modeling.

- **Andrew Sundberg's Kaggle College Basketball Dataset**: https://www.kaggle.com/datasets/andrewsundberg/college-basketball-dataset  
  Includes cbb25 (as of ~March 18, 2025, but similar updates for 2026 likely exist or can be requested). Combines Torvik/KenPom-style stats.

If you're sticking to R and want to avoid installs, use base tools (read.csv for Torvik CSVs, httr for APIs). For modeling ideas: Start with game-level data from Torvik CSVs → compute team aggregates (e.g., avg opponent Barthag for SOS proxy) → join Kaggle seeds/results → train XGBoost/logistic on historical tourney outcomes.

If none hit the exact SOS columns and you can share what specific model/features you're targeting (e.g., resume-based bracket probs), I can refine code or suggest computations from available data!
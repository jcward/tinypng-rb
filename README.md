# tinypng-rb
Commandline script for [TinyPNG](http://tinypng.com) service

Quick'n'dirty script for PNG compression using the TinyPNG service

# Usage:

`tinypng.rb <file or directory> ...`

# Notes:
  - requires sign-up, api key from: https://tinypng.com/developers
  - modifies files in place

# Sample output

```
> tinypng.rb ./assets
Running tinypng on 2 files over 1024 bytes...
 - assets/atlas.1x.png 500742 --> 167718 (33.489999999999995%)
 - assets/atlas.2x.png 1004497 --> 408391 (40.660000000000004%)
```

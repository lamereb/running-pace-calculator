## Running Pace Calculator

This is a small script I wrote mostly to get acquainted with perl syntax. Given a time in hh:mm:ss format and a distance in miles or km, it calculates an average running pace in min/mile. Results can also be displayed in min/km if a **-k** flag is passed. A **-q** (quiet) flag will return only the number, giving me the option to use this for calculating a running average from data in a .tcx or .gpx file if I wanted.

# A Few Example Runs

```bash
pace.pl 0:18:33 5k
5:58.45 min/mile pace
```

```bash
pace.pl 0:38:29 6.2
6:11.82 min/mile pace
```

```bash
pace.pl -q 2:02:57 26.2
4:41.56
```

```bash
pace.pl -k 2:02:57 26.2
2:54.99 min/km pace
```

```bash
pace.pl -q -k 0:38:29 10k
3:50.90
```

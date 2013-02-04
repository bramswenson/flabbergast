# NAME

  flabbergast

# SYNOPSIS

  flabbergast \[options]

# DESCRIPTION

  Generate grids of random letters and find words within them

# OPTIONS

  --size NUMBER
      Number letters in each direction on the grid

  --file path
      Path to a grid to search within for words

  --dictionary path
      Path to a word dictionary

# TESTING

```
bundle install --path .bundle/bundle
bundle exec rake
bundle exec bin/flabbergast
```

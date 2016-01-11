# ruby-build-update-defs

A [rbenv][] plugin that provides a `rbenv update-version-defs` command to
create [ruby-build][]-compatible definitions.

## Installation

To install, clone this repository into your `$(rbenv root)/plugins` directory.

    $ git clone https://github.com/jasonkarns/ruby-build-update-defs.git "$(rbenv root)"/plugins/ruby-build-update-defs

## Usage

    $ rbenv update-version-defs

By default, this will create build definitions in the plugin's `share/ruby-build/` directory. This directory can be overridden with `--destination`.

Only definitions that aren't already in ruby-build's lookup path (`RUBY_BUILD_DEFINITIONS`) will be created. That is, under typical usage only definitions not already shipped with ruby-build will be created. To override this and write definitions for *all* available ruby versions, use `--force`. (This will overwrite any conflicting definition files that already exist in the destination directory.)

### Special environment variables

- `RUBY_BUILD_DEFINITIONS` can be a list of colon-separated paths that get additionally searched when looking up build definitions. All rbenv plugins' `share/ruby-build/` directories are appended to this path. Definitions already found in these paths will be skipped (unless `--force`).

## Cleanup/Pruning

In normal operation, build definitions will gradually build up in this plugin's `share/ruby-build` directory (or elsewhere if overridden with `--destination`). Eventually, as the scraped definitions are added to ruby-build itself, these user-scraped definitions will become duplicates when their ruby-build installation is updated. In order to ensure one is frequently running on the "proper" build definitions from ruby-build, any duplicates in the plugin directory ought to be removed.

    $ rbenv prune-version-defs

This subcommand removes (or lists with `--dry-run`) any duplicate build definitions. Like `update-version-defs`, `--destination <dir>` overrides the default value of `<plugin-root>/share/ruby-build` as the directory from which duplicates are removed. Duplicates are searched for under `RUBY_BUILD_DEFINITIONS` and are determined by both filename *and* contents. The file contents check can be overridden with `--force`,  which will delete duplicates based solely on filename.

This subcommand is silent by default, only printing removed duplicates if `--verbose`. (`--dry-run` implies `--verbose`)

[rbenv]: https://github.com/rbenv/rbenv
[ruby-build]: https://github.com/rbenv/ruby-build

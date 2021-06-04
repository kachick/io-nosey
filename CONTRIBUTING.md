# How to contribute

* Reporting bugs
* Suggesting features
* Creating PRs

Welcome all of the contributions!

## Development

At first, you should install development dependencies

```console
$ git clone git@github.com:kachick/io-nosey.git
$ cd ./io-nosey
$ ./bin/setup
Dependencies are installed!
```

## Feel the latest version with REPL

```console
$ ./bin/console
Starting up IRB with loading with latest code
```

## How to make ideal PRs (Not a mandatory rule, feel free to PR!)

If you try to add/change/fix features, please update and/or confirm core feature's tests are not broken.

```console
$ bundle exec rake
$ echo $?
0
```

CI includes signature check, lint, if you want to check them in own machine, below command is the one.

But please don't hesitate to send PRs even if something fail in this command!

```console
$ bundle exec rake simulate_ci
$ echo $?
0
```

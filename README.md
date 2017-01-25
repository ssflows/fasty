# Fasty

## Installation

```bash
docker pull ssflows/fasty
```

## Usage

Given that you have a properly formatted FASTA file named `input.fasta` just type:

```bash
docker run -v $PWD:/workdir ssflows/fasty input.fasta
```

This should create a temporary directory with tool workdirs inside and run the pipeline.

For smaller runtimes use multiple cores like this:

```bash
docker run -v $PWD:/workdir ssflows/fasty --nt 4 input.fasta
```

It's going to use four cores which should significantly reduce computation time.


To update pipeline to a newer version again use:

```bash
docker pull ssflows/fasty
```


## Development

TODO: Write development instructions here


## Contributing

Bug reports and pull requests are welcome!

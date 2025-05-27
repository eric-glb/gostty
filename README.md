<h1 align="center">gostty</h1>

<p align="center">
Go implementation of the iconic <a href="https://ghostty.org">ghostty.org</a> animation, in your terminal.
</p>

<br>

<div align="center">
<img src="assets/animation.gif" width="50%">
</div>

---

## Features

- **Seamless terminal animation** inspired by [ghostty.org](https://ghostty.org)
- **Customizable highlight colors** (ANSI and named colors)
- **Optional timer** to run the animation for a fixed duration
- **Resizes dynamically** with terminal dimensions
- **Animation frames embedded** inside the binary for easy distribution

## Installation

### Prerequisites

[Go 1.18+](https://golang.org/doc/install)

### Install via `go install`

```bash
go install github.com/ashish0kumar/gostty@latest
```

### Build from source

Clone the repo, build the binary, and move it into your `$PATH`

```bash
git clone https://github.com/ashish0kumar/gostty.git
cd gostty
go build
sudo mv gostty /usr/local/bin/
```

## Usage

```bash
gostty [options]
```

### Options

| Flag               | Description                                         |
|--------------------|-----------------------------------------------------|
| `-c`, `--color`    | Set highlight color (name or ANSI code)             |
| `-t`, `--timer`    | Run animation for a fixed number of seconds         |
| `--colors`         | Show supported colors                               |
| `-h`, `--help`     | Show help                                           |

## Examples

```bash
# Use cyan highlight by name
gostty -c cyan

# Use ANSI color code 36 (cyan)
gostty -c 36

# Run the animation for 10 seconds
gostty -t 10

# Show supported color options
gostty --colors
```

## Notes

- Animation frames are embedded in the binary, so no external animation data file is required at runtime.
- Make sure your terminal supports ANSI escape codes and is large enough to render the animation (77x41 chars).

## Acknowledgments

- Original ghostty animation concept from [ghostty.org](https://ghostty.org)
- Partial reference from [SohelIslamImran/ghosttime](https://github.com/SohelIslamImran/ghosttime)

## License

[MIT License](LICENSE)
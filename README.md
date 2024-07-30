# Linux Helper Scripts

This repository contains a collection of shell scripts designed to assist with common Linux tasks. These scripts aim to simplify and automate everyday operations, making it easier for users to manage their Linux systems.

## Table of Contents

- [Installation](#installation)
- [Scripts](#scripts)
  - [Memory Usage Monitor](#resources_avg)
- [Contributing](#contributing)
- [License](#license)

## Installation

1. Clone the repository to your local machine:
    ```sh
    git clone https://github.com/yourusername/linux-helper-scripts.git
    cd linux-helper-scripts
    ```

2. Make the scripts executable:
    ```sh
    chmod +x *.sh
    ```

3. Optionally, add the scripts to your PATH for easy access:
    ```sh
    export PATH=$PATH:/path/to/linux-helper-scripts
    ```

## Scripts

### resources_avg

This script monitors the average memory usage and cpu over a period of time.

#### Usage

```sh
./resources_avg.sh

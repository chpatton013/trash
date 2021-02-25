# trash

Asynchronous file and directory removal.

## Summary

Run the `trash` command to send files to a trash can directory on the same
filesystem. The `trash-daemon` will come around and empty the trash cans in the
background.

## Usage

Print the locations of all existing trash cans on this system.
```sh
trash
```

Send these files to the closest trash can.
```sh
trash FILE [FILE ...]
```

Print detailed help information:
```sh
trash -h | --help
```

# Scale Down Bitmaps

* [Parameters](#parameters)
* [Usage](#usage)
* [Examples](#examples)
* [Known Bugs](#known-bugs)

---

Scales down one or more bitmaps proportionally to match specific widths, in pixels, using [ImageMagick](https://www.imagemagick.org/).

Suitable for generating images to be used with [srcset and sizes](https://ericportis.com/posts/2014/srcset-sizes/).

Each resized file will have its new width appended to the original file name, for example, when reducing "cat.jpg" to 600px, the new file name will be "cat-600.jpg".

Non-bitmap files passed to the script will be ignored.

**Warning:** globs are **not** accepted as parameters. If passed, they will cause the script to behave unexpectedly.

## Parameters

| Name | Type | Description | Default value |
|---|---|---|---|
| s | folder or file | The source folder or file. | The current folder. |
| d | folder | The destination folder. | A folder named "resized" in the current folder. |
| w | string | The widths to resize the bitmaps to, separated&nbsp;by&nbsp;spaces. | "400 700 900 1100 1400 1700 2000 2300 2700" |


## Usage

**1.** Install ImageMagick on your computer. You can [follow these steps](http://imagemagick.org/script/download.php) or, if you are on a Mac, use [Homebrew](https://brew.sh/index.html).

```sh
$ brew install imagemagick
```

**2.** Clone or download Scale Down Bitmaps from the [GitHub repository](https://github.com/leofavre/scale-down-bitmaps.git).

**3.** Extract and save the file `scale-down.sh` to your project root.

**4.** Make sure the file is executable by running the following command.

```sh
$ chmod +x ./scale-down.sh
```

**5.** Start scaling down bitmaps!


## Examples

Process all bitmaps in the current folder with the default settings and save the results to `./resized`.

```sh
$ ./scale-down.sh
```

Process all bitmaps in `./bitmaps` with the default settings and save the results to `./bitmaps/resized`.

```sh
$ ./scale-down.sh -s ./bitmaps
```

Process the file `./bitmaps/cat.jpg` with the default settings and save the results to `./bitmaps/resized`.

```sh
$ ./scale-down.sh -s ./bitmaps/cat.jpg
```

Process all bitmaps in `./bitmaps` with the default settings and save the results to `./output`.

```sh
$ ./scale-down.sh -s ./bitmaps -d ./output
```

Process all bitmaps in `./bitmaps` with the widths passed as parameter and save the results to `./bitmaps/resized`.

```sh
$ ./scale-down.sh -s ./bitmaps -w "400 800 1200"
```

Process all bitmaps in `./bitmaps` with the widths passed as parameter and save the results to`./output`.

```sh
$ ./scale-down.sh -s ./bitmaps -d ./output -w "400 800 1200"
```

Process all bitmaps in the current folder with the widths passed as parameter and save the results to `./resized`.

```sh
$ ./scale-down.sh -w "400 800 1200 1600"
```

## Known Bugs

Image size verification will fail on animated `gif` images, causing the script to scale up this format.

# VCPKG Overlay

Custom overlay configuration for vcpkg.

## Use Pre-built Libraries

### Get Overlay

Clone `vcpkg-overlay` in the subdirectory `script/vcpkg` of your repository.

```sh
git clone https://github.com/Do-sth-sharp/vcpkg-overlay.git scripts/vcpkg
```

### Make Manifest File 

Make configuration file `vcpkg.json` in subdirectory `scripts/vcpkg-manifest`.

```json
{
    "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg-tool/main/docs/vcpkg.schema.json",
    "dependencies": [
        "some-depencency"
    ],
    "vcpkg-configuration": {
        "overlay-ports": [
            "../vcpkg/ports"
        ],
        "overlay-triplets": [
            "../vcpkg/triplets"
        ]
    }
}
```

### Setup Environment

#### Windows

```sh
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg
bootstrap-vcpkg.bat

vcpkg install --x-manifest-root=../scripts/vcpkg-manifest --x-install-root=./installed --triplet=x64-windows
```

#### Unix

```sh
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg
./bootstrap-vcpkg.sh

./vcpkg install \
    --x-manifest-root=../scripts/vcpkg-manifest \
    --x-install-root=./installed \
    --triplet=<triplet>

# triplet:
#   Mac:   `x64-osx` or `arm64-osx`
#   Linux: `x64-linux` or `arm64-linux`
```
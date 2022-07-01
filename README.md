# devops-netology
1. aefead2207ef7e2aa5dc81a34aedf0cad4c32545 Update CHANGELOG.md

2. tag: v0.12.23

3. 2 родителя (мерж-коммит)  56cd7859e05c36c06b56d013b55a252d0bb7e158     9ea88f22fc6269854151c571162c5bcf958bee2b

4. git log v0.12.23..v0.12.24 --oneline
33ff1c03b (tag: v0.12.24) v0.12.24
b14b74c49 [Website] vmc provider links
3f235065b Update CHANGELOG.md
6ae64e247 registry: Fix panic when server is unreachable
5c619ca1b website: Remove links to the getting started guide's old location
06275647e Update CHANGELOG.md
d5f9411f5 command: Fix bug when using terraform login on Windows
4b6d06cc5 Update CHANGELOG.md
dd01a3507 Update CHANGELOG.md
225466bc3 Cleanup after v0.12.23 release

5. 18dd1bb4d6134b9f8e15b9cea7fae0c878d0a8ba
git grep --break --heading -n -e 'providerSource'
git log -L :TestInit_providerSource:internal/command/init_test.go

6. git grep --break --heading -n -e 'globalPluginDirs'   git log -L :globalPluginDirs:plugins.go
78b12205587fe839f10d946ea3fdc06719decb05
52dbf94834cb970b510f2fba853a5b49ad9b1a46
41ab0aef7a0fe030e84018973a64135b11abcd70
66ebff90cdfaa6938f26f908c7ebad8d547fea17
8364383c359a6b738a436d1b7745ccdce178df47

7. 5ac311e2a91e381e2f52234668b49ba670aa0fe5
Author: Martin Atkins <mart@degeneration.co.uk>

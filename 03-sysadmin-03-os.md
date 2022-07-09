1. chdir("/tmp")

2. Командой strace -e trace=file file полмотрел все системные вызовы которые касаются файлов
  openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
  file /usr/share/misc/magic.mgc
  ../../lib/file/magic.mgc

3. 















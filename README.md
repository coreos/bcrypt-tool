A simple command line tool for generating bcrypted passwords.

[![Docker Repository on Quay](https://quay.io/repository/coreos/bcrypt-tool/status "Docker Repository on Quay")](https://quay.io/repository/coreos/bcrypt-tool)

Run via container image:

```
docker run -it --rm quay.io/coreos/bcrypt-tool
```

```
rkt run --interactive docker://quay.io/coreos/bcrypt-tool
```

Download the precompiled tool for your operating system from the [releases page](https://github.com/coreos/bcrypt-tool/releases).

```
$ wget https://github.com/coreos/bcrypt-tool/releases/download/v1.0.0/bcrypt-tool-v1.0.0-linux-amd64.tar.gz
$ sha512sum bcrypt-tool-v1.0.0-linux-amd64.tar.gz
# verify results
$ tar -zxvf bcrypt-tool-v1.0.0-linux-amd64.tar.gz
./
./bcrypt-tool/
./bcrypt-tool/bcrypt-tool
```

Use the tool to create a bcrypted password.

```
$ ./bcrypt-tool/bcrypt-tool 
Enter password: 
Re-enter password: 
$2a$10$C9DliP580ooWFpr6XTQwOuFd3znBNDMVSytJmm9viL4XLZuy.PnMm
```

Increase the cost using the `-cost` flag (defaults to 10).

```
$ ./bcrypt-tool/bcrypt-tool -cost=14
Enter password: 
Re-enter password: 
$2a$14$830vR/vhwIFKXaLtHaP41OInok.XsUBAgrG.EC3JqyQUMrbj091qG
```

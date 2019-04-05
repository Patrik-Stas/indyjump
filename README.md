# IndyJump 
IndyJump is tool manage `libindy`, `libvcx` and `libnullpay` libraries. `Indyjump` will 
help you to quickly compile `indy-sdk` binaries and mark them with a tag. Then you 
can quickly jump between different version of your `indy-sdk` binaries.

# How would you use this
Here's an workflow example:
- You checkout `1.8.2` revision of `indy-sdk` repo. 
- Now you to compile all the binaries and use them from your project
- Instead of compiling manually and copying the artifact to `/usr/local/lib`
 or `/usr/local/lib`
you will use `indyjump`!
- Simply run `ij-compile-provision-set-all foobar-1.8.2`. It will:
	- Enter currently checked out indy-sdk repo 
	- Compile `libindy`, `libvcx`, `libnullpay`
	- Track these compiled binaries in dedicated `indyjump` directory as 
	version `foobar-1.8.2`
	- Create symlinks to these binaries in your system library directory 
- Done!
- Later you'll decide to switch to your own version of binaries you've compiled
 yesterday. 
- You'd do that by running: `ij-set-all 1.8.1-with-my-changes`

# Commands

### `ijcheck`
```
> ijcheck

Active indy binaries:
/usr/local/lib/indyjump/latest-libindy.dylib
/usr/local/lib/indyjump/latest-libnullpay.dylib
/usr/local/lib/indyjump/latest-libvcx.dylib

Active indy binaries details:
-rwx--x--x   1 username  groupname    38M Apr  2 17:45 libindy.dylib
-rwx--x--x   1 username  groupname   2.6M Apr  2 17:45 libnullpay.dylib
-rwxr-xr-x   1 username  groupname    35M Apr  2 17:45 libvcx.dylib

Symlinks:
lrwxr-xr-x   1 username  groupname       44 Apr  2 17:58 libindy.dylib -> /usr/local/lib/indyjump/latest-libindy.dylib
lrwxr-xr-x   1 username  groupname       47 Apr  2 17:58 libnullpay.dylib -> /usr/local/lib/indyjump/latest-libnullpay.dylib
lrwxr-xr-x   1 username  groupname       43 Apr  2 17:58 libvcx.dylib -> /usr/local/lib/indyjump/latest-libvcx.dylib
```
### `ijcompile-one [libindy|libvcx|libnullpay]`
```
> ijcompile-one libindy

Building 'libindy' at /Users/prague/dev/hyperledger/indy-sdk/libindy/target/debug
Finished dev [unoptimized + debuginfo] target(s) in 0.58s
Artefacts at /Users/prague/dev/hyperledger/indy-sdk/libindy/target/debug
-rw-------    2 prague  staff   116M Mar 26 16:00 libindy.a
-rw-------    1 prague  staff    10K Apr  2 18:50 libindy.d
-rwx--x--x    2 prague  staff    38M Mar 26 16:00 libindy.dylib
-rw-------    2 prague  staff   110M Mar 26 16:00 libindy.rlib
```
### `ijcompile-provision-set-all [provision-name]`
```
> ijcompile-provision-set-all experiment

Building 'libindy' at /Users/prague/dev/hyperledger/indy-sdk/libindy/target/debug
    Finished dev [unoptimized + debuginfo] target(s) in 0.53s
Artefacts at /Users/prague/dev/hyperledger/indy-sdk/libindy/target/debug
-rw-------    2 prague  staff   116M Mar 26 16:00 libindy.a
-rw-------    1 prague  staff    10K Apr  2 18:53 libindy.d
-rwx--x--x    2 prague  staff    38M Mar 26 16:00 libindy.dylib
-rw-------    2 prague  staff   110M Mar 26 16:00 libindy.rlib
Will take library at: /Users/prague/dev/hyperledger/indy-sdk/libindy/target/debug/libindy.dylib
The binary will be copied to: /usr/local/lib/indyjump/experiment-libindy.dylib
Proovisioned libindy with tag 'experiment'
Version of 'libindy' changed to 'experiment'
Building 'libnullpay' at /Users/prague/dev/hyperledger/indy-sdk/libnullpay/target/debug
    Finished dev [unoptimized + debuginfo] target(s) in 0.15s
Artefacts at /Users/prague/dev/hyperledger/indy-sdk/libnullpay/target/debug
-rw-------   2 prague  staff    13M Mar 26 16:00 libnullpay.a
-rw-------   1 prague  staff   1.5K Apr  2 18:53 libnullpay.d
-rwx--x--x   2 prague  staff   2.6M Mar 26 16:00 libnullpay.dylib
-rw-------   2 prague  staff   8.6M Mar 26 16:00 libnullpay.rlib
Will take library at: /Users/prague/dev/hyperledger/indy-sdk/libnullpay/target/debug/libnullpay.dylib
The binary will be copied to: /usr/local/lib/indyjump/experiment-libnullpay.dylib
Proovisioned libnullpay with tag 'experiment'
Version of 'libnullpay' changed to 'experiment'
Building 'libvcx' at /Users/prague/dev/hyperledger/indy-sdk/vcx/libvcx/target/debug
    Finished dev [unoptimized + debuginfo] target(s) in 0.64s
Artefacts at /Users/prague/dev/hyperledger/indy-sdk/vcx/libvcx/target/debug
-rw-r--r--    2 prague  staff   156M Apr  2 17:45 libvcx.a
-rw-------    1 prague  staff   7.1K Apr  2 18:53 libvcx.d
-rwxr-xr-x    2 prague  staff    35M Apr  2 17:45 libvcx.dylib
-rw-r--r--    2 prague  staff    81M Apr  2 17:45 libvcx.rlib
Will take library at: /Users/prague/dev/hyperledger/indy-sdk/vcx/libvcx/target/debug/libvcx.dylib
The binary will be copied to: /usr/local/lib/indyjump/experiment-libvcx.dylib
Proovisioned libvcx with tag 'experiment'
Version of 'libvcx' changed to 'experiment'
```

### `ijlist`
```
> ijlist

Available indyjump-managed indy binary versions:
1.7.0
1.8.0
1.8.1
experiment
latest
master
```

### `ijprovision-all`
```
> ijprovision-all latest

Will take library at: /Users/prague/dev/hyperledger/indy-sdk/libindy/target/debug/libindy.dylib
The binary will be copied to: /usr/local/lib/indyjump/latest-libindy.dylib
Proovisioned libindy with tag 'latest'
Will take library at: /Users/prague/dev/hyperledger/indy-sdk/vcx/libvcx/target/debug/libvcx.dylib
The binary will be copied to: /usr/local/lib/indyjump/latest-libvcx.dylib
Proovisioned libvcx with tag 'latest'
Will take library at: /Users/prague/dev/hyperledger/indy-sdk/libnullpay/target/debug/libnullpay.dylib
The binary will be copied to: /usr/local/lib/indyjump/latest-libnullpay.dylib
Proovisioned libnullpay with tag 'latest'
```

### `ijprovision-one`

```
> ijprovision-one libvcx latest

Will take library at: /Users/prague/dev/hyperledger/indy-sdk/vcx/libvcx/target/debug/libvcx.dylib
The binary will be copied to: /usr/local/lib/indyjump/latest-libvcx.dylib
Proovisioned libvcx with tag 'latest'
```


### `ijset-all`
```
> ijset-all experiment

Version of 'libindy' changed to 'experiment'
Version of 'libvcx' changed to 'experiment'
Version of 'libnullpay' changed to 'experiment'
```

### `ijset-one`
```
> ijset-one libindy master

Version of 'libindy' changed to 'master'
```

# Compatibility 
- Tested on `OSX Mojave`, `Ubuntu 16.04.5 LTS`
- Does not support `Windows`.

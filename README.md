# indyjump
Tool to manage your libindy binaries.


# Quick example

Add binary among managed version and give it tag "master"
```
addindy.sh target/debug/libnullpay.dylib master
```

Use indy binaries marked by tag "master"
```
setindy.sh master
```

List all available tags
```
> listindy.sh 
1.7.0
1.8.0
1.8.1
artem
master
```


Check currently used versions
```
> checkindy.sh
lrwxr-xr-x   1 prague  admin    48B Feb 18 18:42 libindy.dylib -> /usr/local/lib/storage/indy/master-libindy.dylib
lrwxr-xr-x   1 prague  admin    52B Feb 18 18:42 libnullpay.dylib -> /usr/local/lib//storage/indy/master-libnullpay.dylib
lrwxr-xr-x   1 prague  admin    47B Feb 18 18:42 libvcx.dylib -> /usr/local/lib/storage/indy/master-libvcx.dylib
```
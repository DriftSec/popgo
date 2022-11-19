
#### One-Liner
```
bash <(wget -qO- https://raw.githubusercontent.com/DriftSec/popgo/main/popgo.sh)
```

#### Options:
 - GO_PATH: change GO_PATH, default is $HOME/go
 - JUST_GO: skip module installs, just install go

```
JUST_GO=true GO_PATH=/tmp/go bash <(wget -qO- https://raw.githubusercontent.com/DriftSec/popgo/main/popgo.sh)
```

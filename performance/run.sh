$rpcs=$1
$txs=$2
$seconds=$3

$CHAINFILLER \
--rpc-endpoints=$rpcs \
--num-transactions=$txs  \
--repeat-every-n-seconds=$seconds \
--genesis-file=$GENESIS \
--tx-export-file=/tmp \
--fuzz-transfer-value-lower-bound-eth=0.01 \
--fuzz-transfer-value-upper-bound-eth=0.03 \
--eip-1559-tx-weight=0  \
--num-threads=1 \
--filler-mode=scheduler

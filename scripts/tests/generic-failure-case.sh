set -eu

thisDir=$(dirname "$0")
baseDir=$thisDir/..

$baseDir/minting/mint-0-policy.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/lock-tx.sh
$baseDir/wait/until-next-block.sh

detected=false

"$1" || {
    detected=true
}

if [ $detected == false ]; then
  exit 1
fi

$baseDir/wait/until-next-block.sh
$baseDir/happy-path/cancel-tx.sh
$baseDir/wait/until-next-block.sh

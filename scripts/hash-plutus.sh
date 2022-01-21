cardano-cli address build \
  --payment-script-file ../artifct-lbuc-sc/scripts/artifct-lbuc.plutus \
  $BLOCKCHAIN \
  --out-file scripts/$BLOCKCHAIN_PREFIX/artifct-lbuc.addr

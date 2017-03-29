for i in {1..9}
do
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq0$i.in
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq0$i.res
done

for i in {10..55}
do
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq$i.in
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq$i.res
done

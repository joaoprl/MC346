for i in {1..9}
do
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Python/dados/arq0$i.in
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Python/dados/arq0$i.res
done

for i in {10..12}
do
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Python/dados/arq$i.in
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Python/dados/arq$i.res
done

for i in {101..179}
do
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Python/dados/arq$i.in
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Python/dados/arq$i.res
done

for i in {1..9}
do
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq0$i.in
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq0$i.res
done

for i in {10..25}
do
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq$i.in
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq$i.res
done
	 

for i in {51..62}
do
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq$i.in
    curl -O -k https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq$i.res
done	 

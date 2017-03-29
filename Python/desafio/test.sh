for i in {1..9}
do
    python main.py < testes/arq0$i.in > testes/arq0$i.out

    diff testes/arq0$i.out testes/arq0$i.res

    read -p "Continue?"
done

for i in {10..12}
do
    python main.py < testes/arq$i.in > testes/arq$i.out
    
    diff testes/arq$i.out testes/arq$i.res

    read -p "Continue?"
done

for i in {101..179}
do
    python main.py < testes/arq$i.in > testes/arq$i.out

    diff testes/arq$i.out testes/arq$i.res

    read -p "Continue?"
done


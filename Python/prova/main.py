
def reps(lista):
    conjunto = set() # guarda cada elemento
    resultado = set() # assegura unicidade da saída

    for elemento in lista:
        if elemento in conjunto:
            resultado.add(elemento)
        else:
            conjunto.add(elemento)
    
    return list(resultado)

def brancos(filename):
    try:
        f = open(filename, ('r')) # read-only
    except Exception: 
        return "falha ao abrir"
        
    try:
        fileString = f.read()
    except Exception:
        f.close()
        return "falha ao ler"
        
    count = fileString.count(' ', 0, len(fileString))
    f.close()
    
    return count

def inva(dic):
    rdic = {} # reversed dictionary
    for k, v in dic.items():
        if rdic.has_key(v):
            rdic.get(v,[]).append(k)
        else:
            rdic.update({v:[k]})
    
    return rdic

class Intervalo:
    __ID = None
    __begin = None
    __end = None
    
    def get_id(self):
        return self.__ID
    def get_xmin(self):
        return self.__begin
    def get_xmax(self):
        return self.__end

    def __init__(self, id, xmin, xmax):
        self.__ID = id
        self.__begin = min(xmin, xmax)
        self.__end = max(xmin, xmax)

    def elo(self, intervalo):
        return min(self.__end - intervalo.get_xmin(), intervalo.get_xmax() - self.__begin)
    
def main():
    # Questao 1
    print reps([1,2,3,4,5])
    print reps([1,4,2,3,4,2,3,4])

    # Questao 2
    print brancos("test.txt")

    # Questao 3
    print inva({1:2,3:1,4:2})
    print inva({2:1,1:2})

    # Questao 4
    a = Intervalo(id = 1, xmin = 2, xmax = 3)
    b = Intervalo(id = 2, xmin = 3, xmax = 4)
    print str(a.elo(b))
    print str(b.elo(Intervalo(id = 4, xmin = 8, xmax = 15)))
    print str(a.elo(Intervalo(id = 8, xmin = 2, xmax = 4)))
          
    return 0

if __name__ == "__main__":
    main()    

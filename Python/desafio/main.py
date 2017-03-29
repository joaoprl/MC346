

import sys
from operator import itemgetter

def main():

    # Getting input list
    list = []
    i = 1
    for line in sys.stdin:
        try:
            values = [int(x) for x in line.strip().split(' ')]
        except ValueError:
            print "erro; not an integer"
            return 1
            
        list.append(values)

        # Check if the line is complete
        if len(values) != 3:
            print "erro; linha invalida: " + line
            return 1

        # Check if value is valid
        if values[1] >= values[2]:
            print "erro; xmin >= xmax @ " + str(values[0])
            return 1
        i += 1

    # Check if all IDs are unique
    seen = set()
    if(any(tuple[0] in seen or seen.add(tuple[0]) for tuple in list)):
        print "erro; not all IDs are unique"
        return 1

    # Sort list using xmin
    list = sorted(list, key=itemgetter(1))

    # Check list size
    if len(list) < 2:
        print "erro; The list is too small: " + str(len(list)) + " < 2"
        return 1

    begin = list[0][1]
    end = list[0][2]
    gap = end - begin;
    
    for tuple in list:
        b = tuple[1]
        e = tuple[2]

        if gap > e - b:
            gap = e - b

        if gap > end - b:
            gap = end - b

        begin = min(begin, b)
        end = max(end, e)

    # print begin, end, gap
    print gap
    
    return 0

if __name__ == "__main__":
    main()    

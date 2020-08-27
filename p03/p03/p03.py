import sys

def openAndCreateOut(n):
    f = open(n, "r")
    line = f.readline()
    while line:
        


if len(sys.argv) == 1:
    name = sys.stdin.read()
    print(name)
elif len(sys.argv) == 2:
    f = open(sys.argv[1], "r");
    contents = f.read()
    f.close()
    print(contents)
else:
    print("error")



import csv
path = ""

with open(path + "colors.csv", "r") as csvFile:
       with open(path + "colors10.mem", "w") as memFile:
            for row in csv.reader(csvFile):
                memFile.write(" ".join(row) + "\n")

with open(path + "image.csv", "r") as csvFile:
    with open(path + "image10.mem", "w") as memFile:
        for row in csv.reader(csvFile):
            memFile.write(" ".join(row) + "\n")
